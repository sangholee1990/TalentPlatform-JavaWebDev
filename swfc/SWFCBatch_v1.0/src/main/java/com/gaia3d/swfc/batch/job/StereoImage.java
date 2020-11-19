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
import java.util.List;
import java.util.SortedSet;
import java.util.StringTokenizer;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.coobird.thumbnailator.Thumbnailator;

import org.apache.commons.configuration.HierarchicalConfiguration;
import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.gaia3d.swfc.batch.util.Database;
import com.gaia3d.swfc.batch.util.DateList;
import com.gaia3d.swfc.batch.util.DestinationInfo;
import com.gaia3d.swfc.batch.util.URLReader;
import com.gaia3d.swfc.batch.util.Utils;
import com.google.common.base.Charsets;
import com.google.common.base.Predicate;
import com.google.common.base.Stopwatch;
import com.google.common.collect.Iterables;
import com.google.common.io.LineProcessor;

public class StereoImage extends DatabaseBatchJob {
	final String configFile;
	public StereoImage(String config) {
		this.configFile = config;
	}
	
	private class Orbit {
		DateTime dateTime;
		double x;
		double y;
		double z;
		
		@Override
		public String toString() {
			return dateTime.toString();
		}
	}

	
	private class Code {
		private String code;
		private String spacecraft;
		private String instrument;

		public Code(String code, String spacecraft, String instrument) {
			this.code = code;
			this.spacecraft = spacecraft;
			this.instrument = instrument;
		}
		
		public String getCode() {
			return code;
		}
		
		public String getSpacecraft() {
			return spacecraft;
		}
		
		public String getInstrument() {
			return instrument;
		}
	}
	
	List<Orbit> getOrbitList(String spacecraft, DateList dateList) throws IOException {
		final List<Orbit> orbitList = new ArrayList<Orbit>();
		
		SortedSet<String> yearSet = new TreeSet<String>();
		for(LocalDate date : dateList.getDayIterable()) {
			String year = date.toString("yyyy");
			yearSet.add(year);
		}
		
		//final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy D HH:mm:ss");
		//dateFormat.setTimeZone(TimeZone.getTimeZone("UTC"));
		
		final DateTimeFormatter dateTimeFormat = DateTimeFormat.forPattern("yyyy D HH:mm:ss");
		
		for(String year : yearSet) {
			String urlString = String.format("http://www.srl.caltech.edu/STEREO2/Position/%s/position_%s_%s_HEEQ.txt", spacecraft, spacecraft, year);
			logger.info(String.format("Retrieving stereo position from %s", urlString));
			URL url = new URL(urlString);
			URLReader.readLines(url, Charsets.ISO_8859_1, new LineProcessor<Void>() {
				@Override
				public Void getResult() {
					// TODO Auto-generated method stub
					return null;
				}

				@Override
				public boolean processLine(String line) throws IOException {
					try {
						StringTokenizer tokenizer = new StringTokenizer(line);
						String year = tokenizer.nextToken();
						String dayOfYear = tokenizer.nextToken();
						long secondOfDay = Long.parseLong(tokenizer.nextToken());
						String type = tokenizer.nextToken();//0:predictive, 1: definitive
						double x = Double.parseDouble(tokenizer.nextToken());
						double y = Double.parseDouble(tokenizer.nextToken());
						double z = Double.parseDouble(tokenizer.nextToken());
						
						int hour = (int) (secondOfDay / 3600);
						int minute = (int) ((secondOfDay - hour*3600) / 60);
						int second = (int) (secondOfDay - hour*3600 - minute * 60);
						
						//Date date = dateFormat.parse(String.format("%s %s %s:%s:%s", year, dayOfYear, hour, minute, second));
						DateTime dateTime = dateTimeFormat.parseDateTime(String.format("%s %s %s:%s:%s", year, dayOfYear, hour, minute, second));
						Orbit orbit = new Orbit();
						orbit.dateTime = dateTime;
						orbit.x = x;
						orbit.y = y;
						orbit.z = z;
						orbitList.add(orbit);
					} catch (Exception ex) {
						logger.error("Parsing stereo position data line : " + line, ex);
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

		int timeOffset = config.getInt("source[@timeOffset]");
		
		FTPClient ftp = new FTPClient();
		final PreparedStatement pstmt;
		try {
			DestinationInfo destInfo = new DestinationInfo(config.configurationAt("destination"));
			
			Utils.initializeFtpClient(ftp, config.configurationAt("source.ftp"));

			String[] resolutionList = config.getStringArray("source.resolution");
			
			List<Code> codeList = new ArrayList<Code>();
			for (HierarchicalConfiguration codeNode : config.configurationsAt("source.code_list.code")) {
				String code = codeNode.getString("[@code]");
				String spacecraft = codeNode.getString("[@spacecraft]");
				String instrument = codeNode.getString("[@instrument]");
				codeList.add(new Code(code, spacecraft, instrument));
			}
			
			Stopwatch stopwatch = Stopwatch.createStarted();
			
			DateList dateList = new DateList(calendar, timeOffset);
			if (logger.isInfoEnabled())
				logger.info("Retrieving range " + dateList.toString());
			
			final List<Orbit> aheadOrbitList = getOrbitList("ahead", dateList);
			final List<Orbit> behindOrbitList = getOrbitList("behind", dateList);
			
			DateTimeFormatter formatter = DateTimeFormat.forPattern("yyyyMMdd_HHmmss");
			
			Pattern imageFilenamePattern = Pattern.compile("^(\\d{8}_\\d{6}).*");
			
			pstmt = db.preparedStatement("INSERT INTO TB_IMAGE_META (CODE, CREATEDATE, FILEPATH, X, Y, Z) values (?,?,?,?,?,?)");
			for (LocalDate date : dateList.getDayIterable()) {
				String year = date.toString("yyyy");
				String month = date.toString("MM");
				String day = date.toString("dd");
				
				for (String resolution : resolutionList) {
					for(Code code : codeList) {
						List<Orbit> orbitList = null;
						if(code.getSpacecraft().equalsIgnoreCase("ahead")) {
							orbitList = aheadOrbitList;
						} else {
							orbitList = behindOrbitList;
						}
						String path = String.format("/pub/browse/%s/%s/%s/%s/%s/%s/*.jpg", year, month, day, code.getSpacecraft(), code.getInstrument(), resolution);

						String subPath = String.format("/%s/%s/%s/%s/%s/%s", year, month, day, code.getSpacecraft(), code.getInstrument(), resolution);
						destInfo.setSubPath(subPath);
						
						FTPFile[] files = ftp.listFiles(path);
						Utils.checkFtpReply(ftp);

						for (FTPFile file : files) {
							if (file.isFile()) {
								String filename = FilenameUtils.getName(file.getName());
								Matcher matcher = imageFilenamePattern.matcher(filename);
								if(matcher.matches()) {
									String dateTimeString = matcher.group(1);
									File filePath = new File(subPath, filename);
									try {
										final DateTime dateTime = formatter.parseDateTime(dateTimeString);
										Timestamp timestamp = new Timestamp(dateTime.getMillis());
										
										if (!db.isExistImageMeta(code.getCode(), timestamp, filePath.getPath())) {
											stopwatch.reset().start();
											
											Orbit orbit = Iterables.tryFind(orbitList, new Predicate<Orbit>() {
												@Override
												public boolean apply(Orbit orbit) {
													return orbit.dateTime.isBefore(dateTime);
												}
											}).orNull();
											
											if(orbit == null) {
												throw new Exception("No orbit available." + filename);
											}
											

											File destFile = new File(destInfo.getBrowsePath(), filename);
											File thumFile = new File(destInfo.getThumbnailPath(), filename);
											
											Utils.download(ftp, file.getName(), destFile);
											Thumbnailator.createThumbnail(destFile, thumFile, destInfo.getThumbnailWidth(), destInfo.getThumbnailHeight());
											
											pstmt.setString(1, code.getCode());
											pstmt.setTimestamp(2, timestamp);
											pstmt.setString(3, filePath.getPath());
											pstmt.setDouble(4, orbit.x);
											pstmt.setDouble(5, orbit.y);
											pstmt.setDouble(6, orbit.z);
											pstmt.execute();
											
											if (logger.isInfoEnabled())
												logger.info("Success:" + file.getName() + " (" + stopwatch.toString() + ")");
										} else {
											if (logger.isDebugEnabled())
												logger.debug("Skip:" + file);
										}
									} catch (Exception ex) {
										logger.error("Failed:", ex);
									}									
								}
							}
						}
					}
				}
			}
		} finally {
			if (ftp.isConnected()) {
				ftp.logout();
				ftp.disconnect();
			}
		}
		Utils.Close(pstmt);
	}
}
