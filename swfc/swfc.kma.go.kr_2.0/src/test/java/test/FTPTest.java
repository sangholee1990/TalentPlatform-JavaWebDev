package test;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.SocketException;
import java.util.Map;

import org.apache.commons.net.PrintCommandListener;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;


public class FTPTest {
	
	static String  host = "192.168.0.121";
	static int port = 21;
	static String userId = "sat";
	static String userPassword = "sat";
	static String serverWorkingDir = "/";
	static String filePath = "C:/home/gnss/swfc_resource/forecast_report/2015/02/12";
	static String fileName = "swfc_fct_201502121600_1.pdf";

	public static void main(String[] args) {
		//new FTPTest().transferFileUsingFTP();
		
		String file = "swfc_fct_201502121600_1_n.pdf";
		if(file.indexOf("_n.") != -1){
			file = file.replace("_n.", ".");
		}
		
		System.out.println(file);
	}
	
	public static void transferFileUsingFTP() {
		String message = null;
		int reply = 0;
		boolean isSuccess = false;
		
		FTPClient ftp = new FTPClient();
		ftp.setControlEncoding("UTF-8");
		
		try {
			
			ftp.connect(host, port);
			
			if(!ftp.login(userId, userPassword)) {
				ftp.logout();
			} else {
			
				reply = ftp.getReplyCode();
				
				if(!FTPReply.isPositiveCompletion(reply)) {
					ftp.disconnect();
				} else {
					ftp.enterLocalPassiveMode();
					ftp.setKeepAlive(true);
					ftp.setControlKeepAliveTimeout(30);
					ftp.addProtocolCommandListener(new PrintCommandListener(System.out, true));
					ftp.setBufferSize(1024000);
					ftp.setFileType(FTP.BINARY_FILE_TYPE);
					ftp.changeWorkingDirectory(serverWorkingDir);
					
					FileInputStream fis = null;
					File uploadFile = new File(filePath, fileName);
					
					try {
						fis = new FileInputStream(uploadFile);
						isSuccess = ftp.storeFile("test.pdf", fis);
						message = "전송 성공";
					} catch(FileNotFoundException fnfe) {
						message = "파일이 존재하지 않습니다.";
//						fnfe.printStackTrace();
					} catch(IOException ioe) {
						message = "입출력 오류";
//						ioe.printStackTrace();
					} finally { if(fis != null) fis.close(); }
				}
			}
		} catch(SocketException se) {
			message = "접속 오류";
//			se.printStackTrace();
		} catch(IOException ioe) {
			message = "입출력 오류";
//			ioe.printStackTrace();
		} finally {
			
			//makeMessages(result, message, isSuccess);
			
			if(ftp != null && ftp.isConnected()) {
				try {
					ftp.disconnect();
				} catch(IOException ioe) {
//					ioe.printStackTrace();
				}
			}
		}
		
		System.out.println(message);
		
		//return result;
	}

}
