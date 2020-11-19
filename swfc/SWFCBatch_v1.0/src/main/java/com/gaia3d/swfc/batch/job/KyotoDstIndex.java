package com.gaia3d.swfc.batch.job;

import java.io.StringReader;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.io.IOUtils;
import org.joda.time.LocalDate;
import org.jsoup.HttpStatusException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.DateList;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

/**
 * SDO Batch Job
 * 
 */
public class KyotoDstIndex extends DatabaseBatchJob {
	final String baseUrl = "http://wdc.kugi.kyoto-u.ac.jp/dst_realtime";
	final String porvisionalUrl = "http://wdc.kugi.kyoto-u.ac.jp/dst_provisional";
	final String finalUrl = "http://wdc.kugi.kyoto-u.ac.jp/dst_final";
	
	final String configFile;
	public KyotoDstIndex(String config) {
		this.configFile = config;
	}

	@Override
	public void doJob(final Database db, final Calendar calendar) throws Exception {
		XMLConfiguration config = loadConfigFile(configFile);

		int timeOffset = config.getInt("source[@timeOffset]");
		DateList dateList = new DateList(calendar, timeOffset);
		if (logger.isInfoEnabled())
			logger.info("Retrieving range " + dateList.toString());

		// 날짜 목록을 구한다.
		Map<String, Multimap<String, Integer>> daysMap = new HashMap<String, Multimap<String, Integer>>();
		for (LocalDate date : dateList.getDayIterable()) {
			String year = date.toString("yyyy");
			String month = date.toString("MM");
			String day = date.toString("dd");

			Multimap<String, Integer> monthMap;
			if (daysMap.containsKey(year)) {
				monthMap = daysMap.get(year);
			} else {
				monthMap = ArrayListMultimap.create();
				daysMap.put(year, monthMap);
			}
			monthMap.put(month, Integer.parseInt(day));
		}

		for (String year : daysMap.keySet()) {
			for (String month : daysMap.get(year).keySet()) {
				
				//기본 경로에서 검색
				String requestUrl = baseUrl + String.format("/%s%s/index.html", year, month);
				if (logger.isInfoEnabled())
					logger.info("Retrieving data from " + requestUrl);

				try {
					parseDst(db, requestUrl, year, month, daysMap.get(year).get(month));
				} catch (HttpStatusException ex) {
					
					//예전 데이터의 경로
					requestUrl = porvisionalUrl + String.format("/%s%s/index.html", year, month);
					if (logger.isInfoEnabled())
						logger.info("Retrieving data from " + requestUrl);
					try {
						
						//아주 예전 데이터의 경로
						parseDst(db, requestUrl, year, month, daysMap.get(year).get(month));
					} catch (HttpStatusException ex1) {
						requestUrl = finalUrl + String.format("/%s%s/index.html", year, month);
						if (logger.isInfoEnabled())
							logger.info("Retrieving data from " + requestUrl);
						try {
							parseDst(db, requestUrl, year, month, daysMap.get(year).get(month));
						} catch (HttpStatusException ex2) {

						}
					}
				}
			}
		}
	}

	private void parseDst(final Database db, String url, String year, String month, Collection<Integer> days) throws SQLException, HttpStatusException {
		PreparedStatement pstmt = db.preparedStatement("MERGE INTO TB_DST_INDEX DST USING (SELECT ? TM, ? DST FROM DUAL) SRC ON(DST.TM=SRC.TM) WHEN NOT MATCHED THEN INSERT (DST.TM, DST.DST) VALUES (SRC.TM, SRC.DST)");
		try {
			Document document = Jsoup.connect(url).timeout(60000).maxBodySize(0).get();
			Elements links = document.select("pre.data");
			for (Element link : links) {
				String pattern = String.format("^([\\s|\\d]\\d)\\s(.{4})(.{4})(.{4})(.{4})(.{4})(.{4})(.{4})(.{4})\\s(.{4})(.{4})(.{4})(.{4})(.{4})(.{4})(.{4})(.{4})\\s(.{4})(.{4})(.{4})(.{4})(.{4})(.{4})(.{4})(.{4})$");
				Pattern filenamePattern = Pattern.compile(pattern, Pattern.CASE_INSENSITIVE);
				for (String line : IOUtils.readLines(new StringReader(link.text()))) {
					Matcher matcher = filenamePattern.matcher(line);
					if (matcher.matches()) {

						int day = Integer.parseInt(matcher.group(1).trim());

						// 날짜 목록에 존재하는 데이터에 대해서만 DB 작업을 진행한다.
						// 해당 날짜의 모든 시간에 일괄적으로 진행한다.
						if (days.contains(day)) {
							for (int hour = 1; hour <= 24; ++hour) {
								String tm = String.format("%s%s%02d%02d0000", year, month, day, hour - 1);
								int value = Integer.parseInt(matcher.group(hour + 1).trim());
								if (value != 9999) {
									pstmt.setString(1, tm);
									pstmt.setInt(2, value);
									pstmt.addBatch();
								}
							}
						}
					}
				}
				pstmt.executeBatch();
			}
		} catch (HttpStatusException ex) {
			logger.error(ex);
			throw ex;
		} catch (Exception e) {
			logger.error(e);
		} finally {
			Utils.Close(pstmt);
		}
	}
}
