package com.gaia3d.web.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;

public class FTPUploader {
	FTPClient ftp = null;

	public FTPUploader(String host, int port, String user, String pwd) throws Exception {
		ftp = new FTPClient();
		//ftp.addProtocolCommandListener(new PrintCommandListener(new PrintWriter(System.out)));
		ftp.setControlEncoding("UTF-8");
		int reply;
		ftp.connect(host, port);
		reply = ftp.getReplyCode();
		if (!FTPReply.isPositiveCompletion(reply)) {
			ftp.disconnect();
			throw new Exception("Exception in connecting to FTP Server");
		}
		ftp.login(user, pwd);
		ftp.setFileType(FTP.BINARY_FILE_TYPE);
		ftp.enterLocalPassiveMode();
	}
	
	public int getReplyCode() { 
		return ftp.getReplyCode();
	}
	
	public String getReplyString() { 
		return ftp.getReplyString();
	}

	public void uploadFile(String localFileFullName, String fileName, String hostDir) throws Exception {
		try {
			InputStream input = new FileInputStream(new File(localFileFullName));
			this.ftp.storeFile(hostDir + fileName, input);
		} finally {

		}
	}
	
	public boolean upload(InputStream is, String fileName, String hostDir) throws Exception {
		try {
			String workingDir = hostDir;
			if(!hostDir.endsWith("/"))
				workingDir = hostDir + "/";
			
			return this.ftp.storeFile(workingDir + fileName, is);
		} finally {

		}
	}

	public void disconnect() {
		if (this.ftp.isConnected()) {
			try {
				this.ftp.logout();
				this.ftp.disconnect();
			} catch (IOException f) {
				// do nothing as file is already saved to server
			}
		}
	}
}
