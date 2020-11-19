package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.io.FileNotFoundException;
import java.sql.PreparedStatement;
import java.util.Calendar;
import java.util.StringTokenizer;

import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.joda.time.format.DateTimeFormat;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.Utils;

public class TEC extends DatabaseBatchJob {
	final String configFile;

	public TEC(String config) {
		this.configFile = config;
	}

	@Override
	protected void doJob(Database db, Calendar calendar) throws Exception {
		XMLConfiguration config = loadConfigFile(configFile);

		File inputPath = new File(config.getString("source[@path]", ""));
		if (!inputPath.exists()) {
			throw new FileNotFoundException(inputPath.getPath());
		}

		File destinationPath = new File(config.getString("destination[@path]", ""));
		if (!destinationPath.exists()) {
			throw new FileNotFoundException(destinationPath.getPath());
		}

		File updateTimeFile = new File(inputPath, "config/update.time");
		if (!updateTimeFile.exists() || !updateTimeFile.isFile()) {
			throw new FileNotFoundException(updateTimeFile.getPath());
		}
		
		File inputTECFile = new File(inputPath, "tec_latest_series.png");
		if(!inputTECFile.exists() || !inputTECFile.isFile()) {
			throw new FileNotFoundException(inputTECFile.getPath());
		}

		String updateTime = null;
		String filePathString = null;
		for (String line : FileUtils.readLines(updateTimeFile)) {
			StringTokenizer tokenzier = new StringTokenizer(line);
			String year = tokenzier.nextToken();
			String month = tokenzier.nextToken();
			String day = tokenzier.nextToken();
			String hour = tokenzier.nextToken();
			String minute = tokenzier.nextToken();
			String step = tokenzier.nextToken();

			String dateString = year + month + day + hour + minute;

			updateTime = DateTimeFormat.forPattern("yyyyMMddHHmm").parseLocalDateTime(dateString).toString("yyyyMMddHH0000");
			String tecFilename = "tec_grid_map_" + updateTime + "." + FilenameUtils.getExtension(inputTECFile.getName());
			
			filePathString = String.format("/%s/%s/%s", year, month, tecFilename);
			FileUtils.copyFile(inputTECFile, new File(destinationPath, filePathString));
		}
		
		PreparedStatement pstmt = null;
		try {
			pstmt = db.preparedStatement("MERGE INTO TB_TEC DST USING (SELECT ? TM, ? FILEPATH FROM DUAL) SRC ON(DST.TM=SRC.TM) WHEN MATCHED THEN UPDATE SET DST.FILEPATH=SRC.FILEPATH WHEN NOT MATCHED THEN INSERT (DST.TM, DST.FILEPATH) VALUES (SRC.TM, SRC.FILEPATH)");
			pstmt.setString(1, updateTime);
			pstmt.setString(2, filePathString);
			pstmt.execute();
		} finally {
			Utils.Close(pstmt);
		}
	}
}
