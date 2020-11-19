package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.configuration.XMLConfiguration;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.URLReader;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Charsets;
import com.google.common.io.LineProcessor;

public class KhuFlarePredication extends DatabaseBatchJob {
	final String configFile;
	
	class FlareData {
		String cls;
		int ap;
		String phrase;
		double c;
		double m;
		double x;
	}
	
	public KhuFlarePredication(String config) {
		this.configFile = config;
	}
	
	@Override
	protected void doJob(final Database db, Calendar calendar) throws Exception {
		XMLConfiguration config = loadConfigFile(configFile);
		
		File inputFile = new File(config.getString("source[@file]", ""));
		if(!inputFile.isFile() || !inputFile.exists()) {
			throw new FileNotFoundException(inputFile.getPath());
		}
		
		URL url = inputFile.toURI().toURL();
		final Pattern dataPattern = Pattern.compile("^\\s*(\\S+)\\s+(\\d+)\\s+(\\S+)\\s+([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\\s+([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\\s+([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\\s*$");
		final Pattern totalPattern = Pattern.compile("^\\s*([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\\s+([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\\s+([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\\s*$");
		final Pattern datePattern = Pattern.compile("^\\s*(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s*$");
		try {
			URLReader.readLines(url, Charsets.ISO_8859_1, new LineProcessor<Boolean>() {
				Timestamp createDate = null;
				Double totalC, totalM, totalX;
				List<FlareData> dataList = new ArrayList<FlareData>();
				
				@Override
				public Boolean getResult() {
					try {
						PreparedStatement pstmt = db.preparedStatement("MERGE INTO TB_FLARE_PREDICATION DST USING (SELECT ? CREATE_DATE, ? TOTAL_C, ? TOTAL_M, ? TOTAL_X FROM DUAL) SRC ON(DST.CREATE_DATE=SRC.CREATE_DATE) " + 
								"WHEN MATCHED THEN UPDATE SET DST.TOTAL_C=SRC.TOTAL_C, DST.TOTAL_M=SRC.TOTAL_M, DST.TOTAL_X=SRC.TOTAL_X " + 
								"WHEN NOT MATCHED THEN INSERT (DST.CREATE_DATE, DST.TOTAL_C, DST.TOTAL_M, DST.TOTAL_X) VALUES (SRC.CREATE_DATE, SRC.TOTAL_C, SRC.TOTAL_M, SRC.TOTAL_X)");
						pstmt.setTimestamp(1, createDate);
						pstmt.setDouble(2, totalC);
						pstmt.setDouble(3, totalM);
						pstmt.setDouble(4, totalX);
						pstmt.execute();
						Utils.Close(pstmt);

						pstmt = db.preparedStatement("INSERT INTO TB_FLARE_PREDICATION_DETAIL (CREATE_DATE, CLS, AR, PHASE, C, M, X) VALUES (?, ?, ?, ?, ?, ?, ?)");
						for(FlareData data : dataList) {
							pstmt.setTimestamp(1, createDate);
							pstmt.setString(2, data.cls);
							pstmt.setInt(3, data.ap);
							pstmt.setString(4, data.phrase);
							pstmt.setDouble(5, data.c);
							pstmt.setDouble(6, data.m);
							pstmt.setDouble(7, data.x);
							pstmt.addBatch();
						}
						pstmt.executeBatch();
						Utils.Close(pstmt);
					} catch (Exception e) {
						logger.error("Insert KHU Flase Predication data", e);
					}					
					return true;
				}

				@Override
				public boolean processLine(String line) throws IOException {
					Matcher matcher = dataPattern.matcher(line);
					try {
						if(matcher.matches()) {
							FlareData data = new FlareData();
							data.cls = matcher.group(1);
							data.ap = Integer.parseInt(matcher.group(2));
							data.phrase = matcher.group(3);
							data.c = Double.parseDouble(matcher.group(4));
							data.m = Double.parseDouble(matcher.group(5));
							data.x = Double.parseDouble(matcher.group(6));
							dataList.add(data);
						} else {
							matcher = totalPattern.matcher(line);
							if(matcher.matches()) {
								totalC = Double.parseDouble(matcher.group(1));
								totalM = Double.parseDouble(matcher.group(2));
								totalX = Double.parseDouble(matcher.group(3));
							} else {
								matcher = datePattern.matcher(line);
								if(matcher.matches()) {
									SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmm");
									String tm = matcher.group(1) + matcher.group(2) + matcher.group(3) + matcher.group(4) + matcher.group(5);
									createDate = new Timestamp(df.parse(tm).getTime());
								}
							}
						}
					}catch(Exception ex) {
						logger.error("Parsing KHU Flase Predication data, line : " + line);
					}
					return true;
				}
			});
		} catch (Exception e) {
			logger.error(e);
		} finally {
			
		}	
	}
}
