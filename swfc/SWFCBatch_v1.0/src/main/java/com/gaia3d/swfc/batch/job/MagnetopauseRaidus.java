package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.lang.StringUtils;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.DateList;
import com.gaia3d.swfc.batch.util.URLReader;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Charsets;
import com.google.common.io.LineProcessor;

public class MagnetopauseRaidus extends DatabaseBatchJob {
	final String configFile;
	public MagnetopauseRaidus(String config) {
		this.configFile = config;
	}

	@Override
	protected void doJob(Database db, Calendar calendar) throws Exception {
		XMLConfiguration config = loadConfigFile(configFile);
		
		int timeOffset = config.getInt("source[@timeOffset]", 0);
		final DateList dateList = new DateList(calendar, timeOffset);
		
		File inputFile = new File(config.getString("source[@file]", ""));
		if(!inputFile.isFile() || !inputFile.exists()) {
			throw new FileNotFoundException(inputFile.getPath());
		}
		
		URL url = inputFile.toURI().toURL();
		final PreparedStatement pstmt = db.preparedStatement("MERGE INTO TB_MAGNETOPAUSE_RADIUS DST USING (SELECT ? TM, ? RADIUS FROM DUAL) SRC ON(DST.TM=SRC.TM) WHEN MATCHED THEN UPDATE SET DST.RADIUS=SRC.RADIUS WHEN NOT MATCHED THEN INSERT (DST.TM, DST.RADIUS) VALUES (SRC.TM, SRC.RADIUS)");
		final Pattern dataPattern = Pattern.compile("^\\s*(\\d+)\\s+([-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?)");
		try {
			URLReader.readLines(url, Charsets.ISO_8859_1, new LineProcessor<Boolean>() {
				@Override
				public Boolean getResult() {
					return true;
				}

				@Override
				public boolean processLine(String line) throws IOException {
					Matcher matcher = dataPattern.matcher(line);
					if(matcher.matches()) {
						String tm = StringUtils.rightPad(matcher.group(1), 14, '0');
						try {
							if(dateList.contains(tm)) {
								double value = Double.parseDouble(matcher.group(2));
								pstmt.setString(1, tm);
								pstmt.setDouble(2, value);
								pstmt.addBatch();
							}
						} catch (Exception e) {
							logger.error("Parse magnetopause_raidus data, line : " + line);
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
