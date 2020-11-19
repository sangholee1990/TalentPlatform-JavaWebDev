package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.configuration.XMLConfiguration;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.URLReader;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Charsets;
import com.google.common.io.LineProcessor;

public class KhuSolarProtonEvent extends DatabaseBatchJob {
	final String configFile;
	public KhuSolarProtonEvent(String config) {
		this.configFile = config;
	}
	
	@Override
	protected void doJob(Database db, Calendar calendar) throws Exception {
		XMLConfiguration config = loadConfigFile(configFile);
		
		File inputFile = new File(config.getString("source[@file]", ""));
		if(!inputFile.isFile() || !inputFile.exists()) {
			throw new FileNotFoundException(inputFile.getPath());
		}
		
		URL url = inputFile.toURI().toURL();
		final PreparedStatement pstmt = db.preparedStatement("MERGE INTO TB_SOLAR_PROTON_EVENT DST USING (SELECT ? START_DATE,? STOP_DATE,? PEAK_DATE,? GCLS,? POSITION,? PROBAB,? PKFLUX,? ARR_TM,? ARR_DATE,? SPOT FROM DUAL) SRC ON(DST.START_DATE=SRC.START_DATE) " +
		"WHEN MATCHED THEN UPDATE SET DST.STOP_DATE=SRC.STOP_DATE, DST.PEAK_DATE=SRC.PEAK_DATE, DST.GCLS=SRC.GCLS, DST.POSITION=SRC.POSITION, DST.PROBAB=SRC.PROBAB, DST.PKFLUX=SRC.PKFLUX, DST.ARR_TM=SRC.ARR_TM, DST.ARR_DATE=SRC.ARR_DATE, DST.SPOT=SRC.SPOT " +
		"WHEN NOT MATCHED THEN INSERT (DST.START_DATE, DST.STOP_DATE, DST.PEAK_DATE, DST.GCLS, DST.POSITION, DST.PROBAB, DST.PKFLUX, DST.ARR_TM, DST.ARR_DATE, DST.SPOT) VALUES (SRC.START_DATE, SRC.STOP_DATE, SRC.PEAK_DATE, SRC.GCLS, SRC.POSITION, SRC.PROBAB, SRC.PKFLUX, SRC.ARR_TM, SRC.ARR_DATE, SRC.SPOT)");
		final Pattern dataPattern = Pattern.compile("^\\s*(\\d+)\\s+(\\S+)\\s+(\\d{4}/\\d{2}/\\d{2})\\s+(\\d{2}:\\d{2}:\\d{2})\\s+(\\d{2}:\\d{2}:\\d{2})\\s+(\\d{2}:\\d{2}:\\d{2})\\s+(\\S+)\\s+(\\S+)\\s+([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\\s+([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\\s+([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\\s+(\\s+|\\d{4}/\\d{2}/\\d{2})\\s+(\\s+|\\d{2}:\\d{2}:\\d{2})\\s+(\\d+)$");
		try {
			URLReader.readLines(url, Charsets.ISO_8859_1, new LineProcessor<Boolean>() {
				SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

				@Override
				public Boolean getResult() {
					return true;
				}

				@Override
				public boolean processLine(String line) throws IOException {
					Matcher matcher = dataPattern.matcher(line);
					if(matcher.matches()) {
						String id = matcher.group(1);
						String ename = matcher.group(2);
						String startDate = matcher.group(3);
						String startTime = matcher.group(4);
						String stopTime = matcher.group(5);
						String peakTime = matcher.group(6);
						String gcls = matcher.group(7);
						String posi = matcher.group(8);
						String probab = matcher.group(9);
						String pkflux = matcher.group(10);
						String arr_tm = matcher.group(11);
						String arr_utc_date = matcher.group(12);
						String arr_utc_time = matcher.group(13);
						String spotNumber = matcher.group(14);
						
						try {
							Timestamp startTimestamp = new Timestamp(df.parse(String.format("%s %s", startDate, startTime)).getTime());
							Timestamp stopTimestamp = new Timestamp(df.parse(String.format("%s %s", startDate, stopTime)).getTime());
							Timestamp peakTimestamp = new Timestamp(df.parse(String.format("%s %s", startDate, peakTime)).getTime());
							Timestamp arrTimestamp = null;
							try {
								arrTimestamp = new Timestamp(df.parse(String.format("%s %s", arr_utc_date, arr_utc_time)).getTime());
							}catch(Exception ex) {
								
							}
							
							pstmt.setTimestamp(1, startTimestamp);
							pstmt.setTimestamp(2, stopTimestamp);
							pstmt.setTimestamp(3, peakTimestamp);
							pstmt.setString(4, gcls);
							pstmt.setString(5, posi);
							pstmt.setDouble(6, Double.parseDouble(probab));
							pstmt.setDouble(7, Double.parseDouble(pkflux));
							pstmt.setDouble(8, Double.parseDouble(arr_tm));
							pstmt.setTimestamp(9, arrTimestamp);
							pstmt.setDouble(10, Integer.parseInt(spotNumber));
							
							pstmt.addBatch();
						} catch (Exception e) {
							logger.error("Parse KHU Solar Proton Event data, line : " + line);
						}
					}
					return true;
				}
			});
			pstmt.executeBatch();
		} catch (Exception e) {
			logger.error(e);
		} finally {
			Utils.Close(pstmt);
		}	
	}
}
