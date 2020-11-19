package com.gaia3d.swfc.batch.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.commons.configuration.AbstractConfiguration;
import org.apache.commons.configuration.SubnodeConfiguration;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPClientConfig;
import org.apache.commons.net.ftp.FTPReply;

import com.gaia3d.swfc.batch.FtpException;

public abstract class Utils {
	private static Pattern pattern = Pattern.compile("([^\\s]+(\\.(?i)(jpg|png|gif|bmp))$)");
	public static List<String> getStringList(AbstractConfiguration config, String key) {
		List<String> list = new ArrayList<String>();
		for (Object value : config.getList(key)) {
			list.add(value.toString());
		}
		return list;
	}

	/** 
	 * Calculate date range from now
	 * @param timeOffset offset value by minute
	 * @return Date iterator 
	 */
	/*
	public static LocalDateRange getDateRange(int timeOffset) {
		TimeZone utc = TimeZone.getTimeZone("UTC");
		Calendar calendar = Calendar.getInstance(utc);
		return getDateRange(calendar, timeOffset);
	}
	*/
	/** 
	 * Calculate date range
	 * @param calendar calendar(UTC)
	 * @param timeOffset offset value by minute
	 * @return Date iterator 
	 */
	/*
	public static LocalDateRange getDateRange(final Calendar calendar, int timeOffset) {
		LocalDate range1 = LocalDate.fromCalendarFields(calendar);
		calendar.add(Calendar.MINUTE, timeOffset);
		LocalDate range2 = LocalDate.fromCalendarFields(calendar);

		if (range1.isBefore(range2)) {
			return new LocalDateRange(range1, range2);
		} else
			return new LocalDateRange(range2, range1);
	}
	*/
	/** 
	 * check file extension (jpg, png, gif, bmp)
	 * @param filename
	 */
	public boolean isImageExtention(String filename) {
		return pattern.matcher(filename).matches();
	}
	
	public static void download(final FTPClient ftp, String remote, File destFile) throws IOException {
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(destFile);
			ftp.retrieveFile(remote, fos);
		} finally {
			if(fos != null) {
				fos.close();
				fos = null;
			}
		}
	}
	
	public static void checkFtpReply(final FTPClient ftp) throws Exception {
		int reply;
		reply = ftp.getReplyCode();
		if (!FTPReply.isPositiveCompletion(reply)) {
			throw new FtpException(ftp.getReplyString());
		}
	}
	
	public static void initializeFtpClient(final FTPClient ftp, final SubnodeConfiguration config) throws Exception {
		FTPClientConfig ftpConfig = new FTPClientConfig();
		ftp.configure(ftpConfig);

		int reply;
		ftp.setAutodetectUTF8(true);
		ftp.connect(config.getString("host"), config.getInt("port"));
		reply = ftp.getReplyCode();
		if (!FTPReply.isPositiveCompletion(reply)) {
			throw new FtpException(ftp.getReplyString());
		}
		
		ftp.enterLocalPassiveMode();
		reply = ftp.getReplyCode();
		if (!FTPReply.isPositiveCompletion(reply)) {
			ftp.disconnect();
			throw new FtpException(ftp.getReplyString());
		}

		ftp.setFileType(FTP.BINARY_FILE_TYPE);
		reply = ftp.getReplyCode();
		if (!FTPReply.isPositiveCompletion(reply)) {
			ftp.disconnect();
			throw new FtpException(ftp.getReplyString());
		}

		ftp.login("anonymous", "");
		reply = ftp.getReplyCode();
		if (!FTPReply.isPositiveCompletion(reply)) {
			ftp.disconnect();
			throw new FtpException(ftp.getReplyString());
		}
	}
	
	public static void Close(Statement statement) {
		if(statement != null) {
			try {
				statement.close();
			}catch(Exception ex) {
				
			}
		}
	}
}
