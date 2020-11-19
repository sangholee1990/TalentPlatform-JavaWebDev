package com.gaia3d.swfc.batch.job;

import java.io.File;
import java.io.FileNotFoundException;
import java.sql.PreparedStatement;
import java.util.Calendar;

import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.joda.time.LocalDateTime;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.Utils;

public class SolarMaximum extends DatabaseBatchJob {
	final String configFile;

	public SolarMaximum(String config) {
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

		File inputFile = new File(inputPath, "pred_ssn.png");
		if(!inputFile.exists() || !inputFile.isFile()) {
			throw new FileNotFoundException(inputFile.getPath());
		}
		
		

		Calendar cal = Calendar.getInstance();
		LocalDateTime dateTime = LocalDateTime.fromCalendarFields(cal);
		
		String updateTime = dateTime.toString("yyyyMM00000000");
		String outputFilename = "pred_ssn_" + updateTime + "." + FilenameUtils.getExtension(inputFile.getName());
		
		String filePathString = String.format("/%s/%s", dateTime.toString("yyyy"), outputFilename);
		File outputFile = new File(destinationPath, filePathString);
		logger.info(String.format("copy from %s to %s", inputFile.getPath(), outputFile.getPath()));
		
		FileUtils.copyFile(inputFile, outputFile);
		
		PreparedStatement pstmt = null;
		try {
			pstmt = db.preparedStatement("MERGE INTO TB_SOLAR_MAXIMUM DST USING (SELECT ? TM, ? FILEPATH FROM DUAL) SRC ON(DST.TM=SRC.TM) WHEN MATCHED THEN UPDATE SET DST.FILEPATH=SRC.FILEPATH WHEN NOT MATCHED THEN INSERT (DST.TM, DST.FILEPATH) VALUES (SRC.TM, SRC.FILEPATH)");
			pstmt.setString(1, updateTime);
			pstmt.setString(2, filePathString);
			pstmt.execute();
		} finally {
			Utils.Close(pstmt);
		}		
	}
}
