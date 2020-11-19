package com.gaia3d.web.util;

import java.io.IOException;
import java.io.InputStream;
import java.text.MessageFormat;
import java.util.Hashtable;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelExec;
import com.jcraft.jsch.ChannelShell;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.ProxySOCKS5;
import com.jcraft.jsch.Session;

public class SSHUtils extends Thread{
	
	private static final Log log = LogFactory.getLog(SSHUtils.class); 
	
	private int repeat = 0;
	private JSch jsch = null;
	private Session session = null;
	private Channel channel = null;
	
	private String host = null;
	private String userId = null;
	private String userPassword = null;
	private int port = 22;
	private String command = null;;
	private String saveFileName = null;
	
	private String proxy_host = "172.19.11.23";
	private int proxy_port = 8325;
	
	/**
	 * 컨넥션을 연결하고 연결 결과를 반환한다.
	 * @return
	 * @throws JSchException
	 */
	private boolean connect() throws JSchException{
		jsch = new JSch();
		session = jsch.getSession(userId, host, port);
		Hashtable<String, String> configJSH = new Hashtable<String, String>();
		configJSH.put("StrictHostKeyChecking", "no");
		session.setConfig(configJSH);
		//session.setProxy(new ProxySOCKS5(proxy_host, proxy_port));
		session.setPassword(userPassword);
		session.connect();
		return session.isConnected();
	}

	@Override
	public void run() {
		if(log.isInfoEnabled()){
			log.info("/===== shell call start =========/");
			log.info("shell call start");
			log.info("host : " + host);
			log.info("port : " + port);
			log.info("user id : " + userId);
			//log.info("user password : " + userPassword);
			log.info("command : " + command);
			log.info("log file : " + saveFileName);
			log.info("/================================/");
		}
		try{
			
			boolean isConnected = connect();
			
			//System.out.println(isConnected);
			
			channel = session.openChannel("exec");
			((ChannelExec) channel).setCommand(command);
			
			//channel.setInputStream(System.in);
			//((ChannelExec) channel).setErrStream(System.err);
			//channel.setInputStream(null);

			InputStream in = channel.getInputStream();
			channel.connect();
			
			//channel.run();

			byte[] tmp = new byte[1024];
			String line;
			while (true) {
				while (in.available() > 0) {
					int i = in.read(tmp, 0, 1024);
					if (i < 0)
						break;
					line = new String(tmp, 0, i);
					//if(line.indexOf("STATUS[OK]") != -1)break;
					//FileUtils.save(saveFileName, line);
					//System.out.println(line);
					//log.info(line);
				}
				
				if (channel.isClosed()) {
					if (in.available() > 0)	continue;
					log.info("exit-status: " + channel.getExitStatus());
					break;
				}
			}
		} catch (JSchException e) {
			log.error(e);
		} catch (IOException e) {
			log.error(e);
		} finally {
			if (channel != null) {
				channel.disconnect();
			}
			if (session != null) {
				session.disconnect();
			}
			
			if(log.isInfoEnabled()){
				log.info("/===== shell call end =========/");
			}
		}
	}

	public void setHost(String host) {
		this.host = host;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public void setCommand(String command) {
		this.command = command;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	public static void test(String[] args){
		String host = "203.247.75.50";
		String user = "gnssadmin";
		String password = "gnssadmin123!@#";
		
		String subject = new String( Base64.encodeBase64("제목 테스트 합니다.".getBytes() ));
		String contents = new String( Base64.encodeBase64("내용 테스트 합니다.".getBytes() ));
		String toNumber = new String( Base64.encodeBase64("01027928830".getBytes() ));
		String params="subject:{0} contents:{1} toNumber:{2}";
		params = MessageFormat.format(params, subject, contents, toNumber);
		
		System.out.println(params);
		
		String command = "/data1/GNSS/gnssadmin/PROG/JAVA/SmsSender/smsSender.sh " + params;
		
		SSHUtils ssh = new SSHUtils();
		ssh.setHost(host);
		ssh.setUserId(user);
		ssh.setUserPassword(password);
		ssh.setCommand(command);
		//ssh.setSaveFileName("d:\\test1111.txt");
		//shell.setDaemon(true);
		ssh.start();
	}

	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
}
