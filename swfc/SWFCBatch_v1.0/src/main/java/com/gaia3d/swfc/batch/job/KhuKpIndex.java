package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.StringTokenizer;

import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.lang.StringUtils;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.URLReader;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Charsets;
import com.google.common.io.LineProcessor;

public class KhuKpIndex extends DatabaseBatchJob {
	final String configFile;
	public KhuKpIndex(String config) {
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
		final PreparedStatement pstmt = db.preparedStatement("MERGE INTO TB_KP_INDEX_KHU DST USING (SELECT ? TM, ? KP FROM DUAL) SRC ON(DST.TM=SRC.TM) WHEN MATCHED THEN UPDATE SET DST.KP=SRC.KP WHEN NOT MATCHED THEN INSERT (DST.TM, DST.KP) VALUES (SRC.TM, SRC.KP)");
		try {
			URLReader.readLines(url, Charsets.ISO_8859_1, new LineProcessor<Boolean>() {
				@Override
				public Boolean getResult() {
					return true;
				}

				@Override
				public boolean processLine(String line) throws IOException {
					StringTokenizer tokenizer = new StringTokenizer(line);
					if(tokenizer.countTokens() == 8) {
						String time = tokenizer.nextToken();
						String bt = tokenizer.nextToken();
						String bx = tokenizer.nextToken();
						String by = tokenizer.nextToken();
						String bz = tokenizer.nextToken();
						String ace_wind = tokenizer.nextToken();
						String ace_density = tokenizer.nextToken();
						String kp_predicated = tokenizer.nextToken();
						if(logger.isDebugEnabled()) {
							logger.debug(String.format("Time:%s, Bt:%s, Bx:%s, By:%s, Bz:%s, ACE_Wind:%s, ACE_Density:%s, Kp_Predicated_Value:%s", time, bt, bx, by, bz, ace_wind, ace_density, kp_predicated));
						}
						
						try {
							double kp = Double.parseDouble(kp_predicated);
							String tm = StringUtils.rightPad(time, 14, '0');
							pstmt.setString(1, tm);
							pstmt.setDouble(2, kp);
							pstmt.addBatch();
						} catch (Exception e) {
							logger.error(String.format("Error on processing data - %s", line), e);
						}
						
					} else {
						logger.error(String.format("Invalid data format - %s", line));
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
