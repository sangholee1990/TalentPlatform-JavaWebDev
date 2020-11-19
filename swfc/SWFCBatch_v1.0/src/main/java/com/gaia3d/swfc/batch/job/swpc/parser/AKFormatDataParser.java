package com.gaia3d.swfc.batch.job.swpc.parser;

import java.io.IOException;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

import com.gaia3d.swfc.batch.job.swpc.SWPCDataType;
import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.URLReader;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Charsets;
import com.google.common.io.LineProcessor;

public class AKFormatDataParser implements SWPCDataParser {
	static final Logger logger = LogManager.getLogger(AKFormatDataParser.class.getName());

	@Override
	public void parseData(Database database, final SWPCDataType dataType, URL url) {
		try {
			final PreparedStatement pstmt = database.preparedStatement(dataType.getSql());
			try {
				final String filename = FilenameUtils.getName(url.getFile());
				final Pattern datePattern = Pattern.compile("^\\s*\\d{4}\\s+(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\s+\\d+\\s*$");
				final Pattern dataPattern = Pattern.compile("^Planetary.*\\s+([-+]?\\d+)\\s+([-+]?\\d+)\\s+([-+]?\\d+)\\s+([-+]?\\d+)\\s+([-+]?\\d+)\\s+([-+]?\\d+)\\s+([-+]?\\d+)\\s+([-+]?\\d+)\\s+([-+]?\\d+)\\s*$");

				URLReader.readLines(url, Charsets.ISO_8859_1, new LineProcessor<Boolean>() {
					DateTime date = null;

					@Override
					public Boolean getResult() {
						try {
							pstmt.executeBatch();
						} catch (SQLException e) {
							logger.error(String.format("[%s]Commit data from %s", dataType, filename), e);
							return false;
						}
						return true;
					}

					@Override
					public boolean processLine(String line) throws IOException {
						if (line.isEmpty() || line.startsWith(":") || line.startsWith("#")) {
							return true;
						}
						try {
							Matcher dateMatcher = datePattern.matcher(line);
							if (dateMatcher.matches()) {
								date = DateTime.parse(line, DateTimeFormat.forPattern("yyyy MMM dd").withLocale(Locale.ENGLISH));
								//date = dateFormat.parse(line);
							} else {
								Matcher dataMatcher = dataPattern.matcher(line);
								if (dataMatcher.matches()) {
									for(int i=1; i<=dataMatcher.groupCount(); ++i) {
										int value = Integer.parseInt(dataMatcher.group(i));
										if(i == 1) //A Index;
											continue;
										
										if(value == -1) // Missing Data;
											continue;
										
										//K Index is start from 2
										pstmt.setString(1, DateTimeFormat.forPattern("yyyyMMddHHmmss").print(date.plusHours((i-1)*3)));
										pstmt.setInt(2, value);
										pstmt.addBatch();
									}
									pstmt.executeBatch();
								}
							}
						} catch (Exception e) {
							logger.warn(String.format("[%s]Parsing line from %s : %s", dataType, filename, line), e);
						}
						return true;
					}
				});
			} finally {
				Utils.Close(pstmt);
			}
		} catch (Exception e) {
			logger.error(String.format("Parsing data from %s", url), e);
		}
	}
}
