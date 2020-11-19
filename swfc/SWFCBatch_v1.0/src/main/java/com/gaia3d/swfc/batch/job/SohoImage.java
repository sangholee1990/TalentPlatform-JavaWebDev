package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;
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

import com.gaia3d.swfc.batch.util.CXFormJNI;
import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.DateList;
import com.gaia3d.swfc.batch.util.DestinationInfo;
import com.gaia3d.swfc.batch.util.LocalDateRange;
import com.gaia3d.swfc.batch.util.URLReader;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Charsets;
import com.google.common.base.Function;
import com.google.common.base.Joiner;
import com.google.common.base.Predicate;
import com.google.common.base.Stopwatch;
import com.google.common.collect.Iterables;
import com.google.common.collect.Lists;
import com.google.common.collect.Range;
import com.google.common.io.LineProcessor;
import com.google.common.io.Resources;

public class SohoImage extends DatabaseBatchJob {

	final String baseUrl = "http://sohowww.nascom.nasa.gov/data/REPROCESSING/Completed";
	final String nominalRollUrl = "http://sohowww.nascom.nasa.gov/data/ancillary/attitude/roll/nominal_roll_attitude.dat";
	
	final String configFile;
	public SohoImage(String config) {
		this.configFile = config;
	}
	
	private class NominalRollList {
		List<Range<NominalRoll>> list = new ArrayList<Range<NominalRoll>>();
		
		public void add(NominalRoll nominalRoll) {
			Range<NominalRoll> range = null;
			if(list.size() == 0) {
				range = Range.lessThan(nominalRoll);
			} else {
				range = Range.closedOpen(Iterables.getLast(list).upperEndpoint(), nominalRoll);
			}
			list.add(range);
		}
		
		public void addClose() {
			list.add(Range.atLeast(Iterables.getLast(list).upperEndpoint()));
		}
		
		public String findValue(DateTime dateTime) {
			NominalRoll roll = find(dateTime);
			if(roll != null) {
				if(roll.roll)
					return "T";
				else
					return "F";
			}
			return null;
		}
		
		public NominalRoll find(DateTime date) {
			final NominalRoll nominalRoll = new NominalRoll(date, true);
			Range<NominalRoll> findRange = Iterables.tryFind(Lists.reverse(list), new Predicate<Range<NominalRoll>>() {
				@Override
				public boolean apply(Range<NominalRoll> range) {
					return range.contains(nominalRoll);
				}
			}).orNull();
			if(findRange != null)
				return findRange.hasLowerBound()?findRange.lowerEndpoint():findRange.upperEndpoint();
			return null;
		}
	}
	
	private class NominalRoll implements Comparable<NominalRoll> {
		public NominalRoll(DateTime dateTime, boolean roll) {
			this.dateTime = dateTime;
			this.roll = roll;
		}
		
		DateTime dateTime;
		boolean roll;
		
		@Override
		public int compareTo(NominalRoll o) {
			return this.dateTime.compareTo(o.dateTime);
		}
		
		@Override
		public String toString() {
			return dateTime.toString() + ":" + this.roll;
		}
	}
	
	private class Orbit {
		DateTime dateTime;
		double heeq_x;
		double heeq_y;
		double heeq_z;
		
		@Override
		public String toString() {
			return dateTime.toString();
		}
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
	
	List<Orbit> getOrbitList(LocalDateRange dateRange) throws IOException {
		final List<Orbit> orbitList = new ArrayList<Orbit>();
		
		//여러 날짜일 경우 한번에 가져오기 우해 정규식을 만들다.
		String datePattern = Joiner.on("|").join(Iterables.transform(dateRange, new Function<LocalDate, String>() {
			@Override
			public String apply(LocalDate date) {
				String year = date.toString("yyyy");
				String month = date.toString("MM");
				String day = date.toString("dd");
				return year + month + day;
			}
		}));
		
		//정규식 패턴 작성
		String patternString = String.format(".*SO_OR_PRE_(%s)_V(\\d+).DAT\\s*", datePattern);
		Pattern pattern = Pattern.compile(patternString, Pattern.CASE_INSENSITIVE);

		Map<String, String> list = new HashMap<String,String>();
		String predictiveUrl = "http://sohowww.nascom.nasa.gov/data/ancillary/orbit/predictive";
		logger.info(String.format("Retrieving orbit file list from %s", predictiveUrl));
		
		Document document = Jsoup.connect(predictiveUrl).timeout(120000).maxBodySize(0).get();
		for(Element link : document.select("a[href~=(?i)" + patternString + "]")) {
			String url = link.absUrl("href");
			Matcher matcher = pattern.matcher(url);
			if(matcher.matches()) {
				String orbitDate = matcher.group(1);
				//String version = matcher.group(2);
				list.put(orbitDate, url);
			}
		}
		
		//좌표 정보를 가져온다.
		final DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern("dd-MMM-yyyy HH:mm:ss").withLocale(Locale.ENGLISH);
		
		for(String value : list.values()) {
			logger.info(String.format("Retrieving orbit predictive from %s", value));
			URL url = new URL(value);
			Resources.readLines(url, Charsets.ISO_8859_1, new LineProcessor<Void>() {
				@Override
				public Void getResult() {
					return null;
				}

				@Override
				public boolean processLine(String line) throws IOException {
					try {
						StringTokenizer tokenizer = new StringTokenizer(line);
						String dateString = tokenizer.nextToken();
						String timeString = tokenizer.nextToken();
						
						String year = tokenizer.nextToken();
						String dayOfYear = tokenizer.nextToken();
						String millOfDay = tokenizer.nextToken();
						
						String gci_x = tokenizer.nextToken();
						String gci_y = tokenizer.nextToken();
						String gci_z = tokenizer.nextToken();
						String gci_vx = tokenizer.nextToken();
						String gci_vy = tokenizer.nextToken();
						String gci_vz = tokenizer.nextToken();
						
						String gse_x = tokenizer.nextToken();
						String gse_y = tokenizer.nextToken();
						String gse_z = tokenizer.nextToken();
						String gse_vx = tokenizer.nextToken();
						String gse_vy = tokenizer.nextToken();
						String gse_vz = tokenizer.nextToken();
	
						String gsm_x = tokenizer.nextToken();
						String gsm_y = tokenizer.nextToken();
						String gsm_z = tokenizer.nextToken();
						String gsm_vx = tokenizer.nextToken();
						String gsm_vy = tokenizer.nextToken();
						String gsm_vz = tokenizer.nextToken();
	
						String gci_sun_vector = tokenizer.nextToken();
						
						String hec_x = tokenizer.nextToken();
						String hec_y = tokenizer.nextToken();
						String hec_z = tokenizer.nextToken();
						String hec_vx = tokenizer.nextToken();
						String hec_vy = tokenizer.nextToken();
						String hec_vz = tokenizer.nextToken();
						
						if(logger.isDebugEnabled()) {
							String msg = String.format("%s %s %s %s %s gci(%s, %s, %s, %s, %s, %s) gse(%s, %s, %s, %s, %s, %s) gsm(%s, %s, %s, %s, %s, %s) gci_sun_vector(%s) hec(%s, %s, %s, %s, %s, %s)", dateString, timeString, year, dayOfYear, millOfDay, gci_x, gci_y, gci_z, gci_vx, gci_vy, gci_vz, gse_x, gse_y, gse_z, gse_vx, gse_vy, gse_vz, gsm_x, gsm_y, gsm_z, gsm_vx, gsm_vy, gsm_vz, gci_sun_vector, hec_x, hec_y, hec_z, hec_vx, hec_vy, hec_vz);
							logger.debug(msg);
						}
						String dateTimeString = String.format("%s %s", dateString, timeString.substring(0, 8));
						DateTime date = dateTimeFormatter.parseDateTime(dateTimeString);
						
						double[] in = new double[3];
						in[0] = Double.parseDouble(gse_x);
						in[1] = Double.parseDouble(gse_y);
						in[2] = Double.parseDouble(gse_z);
						
						double[] heeq = CXFormJNI.cxform(date.getYear(), date.getMonthOfYear(), date.getDayOfMonth(), date.getHourOfDay(), date.getMinuteOfHour(), date.getSecondOfMinute(), in, CXFormJNI.Sys.GSE, CXFormJNI.Sys.HEEQ);
						
						Orbit orbit = new Orbit();
						orbit.dateTime = date;
						orbit.heeq_x = heeq[0];
						orbit.heeq_y = heeq[1];
						orbit.heeq_z = heeq[2];
						orbitList.add(orbit);
					}catch(Exception ex) {
						logger.error("Parsing orbit predictive data line : " + line, ex);
					}
					return true;					
				}
			});			
		}

		Collections.sort(orbitList, new Comparator<Orbit>() {
			@Override
			public int compare(Orbit o1, Orbit o2) {
				return o1.dateTime.compareTo(o2.dateTime);
			}
		});
		Collections.reverse(orbitList);
		
		return orbitList;
	}
	
	@Override
	protected void doJob(final Database db, final Calendar calendar) throws Exception {
		XMLConfiguration config = loadConfigFile(configFile);

		DestinationInfo destInfo = new DestinationInfo(config.configurationAt("destination"));

		int timeOffset = config.getInt("source[@timeOffset]");
		List<String> imageSizeList = Utils.getStringList(config, "source.size_list.size");
		logger.info(String.format("Retrieving nominal roll attitude from %s", nominalRollUrl));
		final NominalRollList nominalRollList = new NominalRollList();
		try {
			URL url = new URL(nominalRollUrl);
			final DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
			URLReader.readLines(url, Charsets.ISO_8859_1, new LineProcessor<Void>() {
				@Override
				public Void getResult() {
					nominalRollList.addClose();
					return null;
				}
	
				@Override
				public boolean processLine(String line) throws IOException {
					if(line.startsWith("#"))
						return true;
					
					StringTokenizer tokenizer = new StringTokenizer(line);
					if(tokenizer.countTokens() == 3) {
						try {
							String dateTimeString = String.format("%s %s", tokenizer.nextToken(), tokenizer.nextToken());
							DateTime dateTime = dateTimeFormatter.parseDateTime(dateTimeString);

							double roll = Double.parseDouble(tokenizer.nextToken());
							NominalRoll nominalRoll = new NominalRoll(dateTime, roll==0.0?false:true);
							nominalRollList.add(nominalRoll);
						} catch (Exception e) {
							logger.error("Parsing nominal roll data:" + line, e);
						}
					}
					return true;
				}
			});
		} catch(Exception ex) {
			logger.error(String.format("Retrieving nominal roll attitude from %s", nominalRollUrl), ex);
			throw ex;
		}
		
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
		
		String pattern = String.format("(\\d+)_(\\d+)_(%s)_(%s)\\.(jpg|gif|bmp|png)", codePattern, imageSizePattern);
		Pattern filenamePattern = Pattern.compile(pattern, Pattern.CASE_INSENSITIVE);

		Stopwatch stopwatch = Stopwatch.createStarted();

		DateList dateList = new DateList(calendar, timeOffset);
		if (logger.isInfoEnabled())
			logger.info("Retrieving range " + dateList.toString());
		
		final PreparedStatement pstmt = db.preparedStatement("INSERT INTO TB_IMAGE_META (CODE, CREATEDATE, FILEPATH, X, Y, Z, ROLLINFO) values (?,?,?,?,?,?,?)");
		
		final List<Orbit> orbitList = getOrbitList(dateList.getDayIterable());
		
		final DateTimeFormatter dateTimeFormatter = DateTimeFormat.forPattern("yyyyMMddHHmm");
		
		for (LocalDate date : dateList.getDayIterable()) {
			String year = date.toString("yyyy");
			String month = date.toString("MM");
			String day = date.toString("dd");
			
			for (Code code : codeList) {
				try {
					String requestUrl = baseUrl + String.format("/%s/%s/%s%s%s", year, code.getValue(), year, month, day);
					if (logger.isInfoEnabled())
						logger.info("Retrieving list from " + requestUrl);

					String subPath = String.format("/%s/%s/%s", year, month, day);
					destInfo.setSubPath(subPath);

					Document document = Jsoup.connect(requestUrl).maxBodySize(0).get();
					Elements links = document.select("a[href]");
					for (Element link : links) {
						String url = link.absUrl("href");
						String filename = FilenameUtils.getName(url);
						File filePath = new File(subPath, filename);

						Matcher matcher = filenamePattern.matcher(filename);
						if (matcher.matches()) {
							String yyyyMMdd = matcher.group(1);
							String hhmm = matcher.group(2);
							final String dateType = matcher.group(3);
							// final String imageSize = matcher.group(4);

							if (dateList.contains(yyyyMMdd + hhmm)) {
								Code dataCode = Iterables.find(codeList, new Predicate<Code>() {
									public boolean apply(Code code) {
										return code.getValue().equalsIgnoreCase(dateType);
									}
								});

								try {
									
									final DateTime fileDate = dateTimeFormatter.parseDateTime(yyyyMMdd+hhmm);
									Timestamp timestamp = new Timestamp(fileDate.getMillis());
									
									if (!db.isExistImageMeta(dataCode.getCode(), timestamp, filePath.getPath())) {
										stopwatch.reset().start();
										
										Orbit orbit = Iterables.tryFind(orbitList, new Predicate<Orbit>() {
											@Override
											public boolean apply(Orbit orbit) {
												return orbit.dateTime.isBefore(fileDate);
											}
										}).orNull();
										
										if(orbit == null) {
											throw new Exception("No orbit available." + filename);
										}

										File destFile = new File(destInfo.getBrowsePath(), filename);
										File thumFile = new File(destInfo.getThumbnailPath(), filename);

										FileUtils.copyURLToFile(new URL(url), destFile);
										Thumbnailator.createThumbnail(destFile, thumFile, destInfo.getThumbnailWidth(), destInfo.getThumbnailHeight());
										
										pstmt.setString(1, dataCode.getCode());
										pstmt.setTimestamp(2, timestamp);
										pstmt.setString(3, filePath.getPath());
										pstmt.setDouble(4, orbit.heeq_x);
										pstmt.setDouble(5, orbit.heeq_y);
										pstmt.setDouble(6, orbit.heeq_z);
										pstmt.setString(7, nominalRollList.findValue(fileDate));
										pstmt.execute();
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
		
		Utils.Close(pstmt);
	}
}