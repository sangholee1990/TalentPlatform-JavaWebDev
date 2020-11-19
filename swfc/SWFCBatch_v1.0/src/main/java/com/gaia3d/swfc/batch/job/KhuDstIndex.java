package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.lang.StringUtils;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.URLReader;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Charsets;
import com.google.common.io.LineProcessor;

public class KhuDstIndex extends DatabaseBatchJob {
	final String configFile;
	public KhuDstIndex(String config) {
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
		final PreparedStatement pstmt = db.preparedStatement("MERGE INTO TB_DST_INDEX_KHU DST USING (SELECT ? TM, ? DST FROM DUAL) SRC ON(DST.TM=SRC.TM) WHEN MATCHED THEN UPDATE SET DST.DST=SRC.DST WHEN NOT MATCHED THEN INSERT (DST.TM, DST.DST) VALUES (SRC.TM, SRC.DST)");
		final Pattern dataPattern = Pattern.compile("^(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+(\\d+)\\s+([-+]?[0-9]*\\.?[0-9]+(?:[eE][-+]?[0-9]+)?)");
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
						try {
							String tm = matcher.group(1) + StringUtils.leftPad(matcher.group(2), 2, '0') + StringUtils.leftPad(matcher.group(3), 2, '0') + StringUtils.leftPad(matcher.group(4), 4, '0') + "00";
							
							double value = Double.parseDouble(matcher.group(5));
							
							pstmt.setString(1, tm);
							pstmt.setDouble(2, value);
							pstmt.addBatch();
						} catch (SQLException e) {
							logger.error("Parsing KHU Dst Index data, line : " + line);
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
