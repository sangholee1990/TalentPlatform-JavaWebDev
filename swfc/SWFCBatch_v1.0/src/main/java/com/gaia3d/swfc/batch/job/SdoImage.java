package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.net.URL;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.coobird.thumbnailator.Thumbnailator;

import org.apache.commons.configuration.HierarchicalConfiguration;
import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.DateList;
import com.gaia3d.swfc.batch.util.DestinationInfo;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Function;
import com.google.common.base.Joiner;
import com.google.common.base.Predicate;
import com.google.common.base.Stopwatch;
import com.google.common.collect.Iterables;

/**
 * SDO Batch Job
 * 
 */
public class SdoImage extends DatabaseBatchJob {
	final String baseUrl = "http://sdo.gsfc.nasa.gov/assets/img/browse";
	
	final String configFile;
	public SdoImage(String config) {
		this.configFile = config;
	}


	private class Code {
		private String code;
		private String value;

		public Code(String code, String value) {
			this.code = code;
			this.value = value;
		}

		public String getCode() {
			return code;
		}

		public String getValue() {
			return value;
		}
	}

	@Override
	public void doJob(final Database db, final Calendar calendar) throws Exception {
		XMLConfiguration config = loadConfigFile(configFile);

		DestinationInfo destInfo = new DestinationInfo(config.configurationAt("destination"));

		int timeOffset = config.getInt("source[@timeOffset]");
		List<String> imageSizeList = Utils.getStringList(config, "source.size_list.size");

		List<Code> codeList = new ArrayList<Code>();
		for (HierarchicalConfiguration codeNode : config.configurationsAt("source.code_list.code")) {
			String code = codeNode.getString("[@code]");
			String value = codeNode.getString("[@value]");
			codeList.add(new Code(code, value));
		}

		String imageSizePattern = Joiner.on("|").join(imageSizeList);
		String codePattern = Joiner.on("|").join(Iterables.transform(codeList, new Function<Code, String>() {
			@Override
			public String apply(Code code) {
				return code.getValue();
			}
		}));

		String pattern = String.format("(\\d{8})_(\\d{6})_(%s)_(%s)\\.(jpg|gif|bmp|png)", imageSizePattern, codePattern);
		Pattern filenamePattern = Pattern.compile(pattern, Pattern.CASE_INSENSITIVE);
		Stopwatch stopwatch = Stopwatch.createStarted();
		
		DateList dateList = new DateList(calendar, timeOffset);
		if (logger.isInfoEnabled())
			logger.info("Retrieving range " + dateList.toString());
		
		DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyyMMddHHmmss");
		
		for (LocalDate date : dateList.getDayIterable()) {
			String year = date.toString("yyyy");
			String month = date.toString("MM");
			String day = date.toString("dd");

			String subPath = String.format("/%s/%s/%s", year, month, day);
			destInfo.setSubPath(subPath);

			try {
				String requestUrl = baseUrl + String.format("/%s/%s/%s", year, month, day);
				if (logger.isInfoEnabled())
					logger.info("Retrieving list from " + requestUrl);

				Document document = Jsoup.connect(requestUrl).timeout(60000).maxBodySize(0).get();
				Elements links = document.select("a[href]");
				for (Element link : links) {
					String url = link.absUrl("href");
					String filename = FilenameUtils.getName(url);
					File filePath = new File(subPath, filename);

					Matcher matcher = filenamePattern.matcher(filename);
					if (matcher.matches()) {
						String yyyyMMdd = matcher.group(1);
						String hhmmss = matcher.group(2);
						//final String imageSize = matcher.group(3);
						final String dateType = matcher.group(4);

						if (dateList.contains(yyyyMMdd + hhmmss)) {
							Code code = Iterables.find(codeList, new Predicate<Code>() {
								public boolean apply(Code code) {
									return code.getValue().equalsIgnoreCase(dateType);
								}
							});
							try {
								DateTime fileDateTime = formatter.parseDateTime(yyyyMMdd+hhmmss);
								Timestamp timestamp = new Timestamp(fileDateTime.getMillis());
								
								if (!db.isExistImageMeta(code.getCode(), timestamp, filePath.getPath())) {
									stopwatch.reset().start();

									File destFile = new File(destInfo.getBrowsePath(), filename);
									File thumFile = new File(destInfo.getThumbnailPath(), filename);

									FileUtils.copyURLToFile(new URL(url), destFile);
									Thumbnailator.createThumbnail(destFile, thumFile, destInfo.getThumbnailWidth(), destInfo.getThumbnailHeight());

									db.insertImageMeta(code.getCode(), timestamp, filePath.getPath());

									if (logger.isInfoEnabled())
										logger.info("Success:" + url + " (" + stopwatch.toString() + ")");
								} else {
									if (logger.isDebugEnabled())
										logger.debug("Skip:" + url);
								}
							} catch (Exception ex) {
								logger.error("Failed:", ex);
							}
						}
					}
				}
			} catch (Exception e) {
				logger.error(e);
			}
		}
	}
}
