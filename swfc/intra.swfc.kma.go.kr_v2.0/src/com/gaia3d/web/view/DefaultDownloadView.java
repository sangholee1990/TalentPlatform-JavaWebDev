package com.gaia3d.web.view;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.AbstractView;

@Component(value="DefaultDownloadView")
public class DefaultDownloadView extends AbstractView {
	private static final Logger logger = LoggerFactory.getLogger(DefaultDownloadView.class);
	
	public static final String ContentTypeKey = "contentType";
	public static final String FileKey = "file";
	public static final String FileDataKey = "fileData";
	public static final String FilenameKey = "filename";
	public static final String DeleteFileKey = "deletefile";
	
	
	public static class DownloadModelAndView extends ModelAndView{
		public DownloadModelAndView(File file) {
			super("DefaultDownloadView");
			setFile(file);
		}
		
		public DownloadModelAndView(File file, String filename) throws UnsupportedEncodingException {
			super("DefaultDownloadView");
			setFile(file);
//			filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
			//filename = URLEncoder.encode(filename, "UTF-8").replaceAll("(", "%28");
			//filename = URLEncoder.encode(filename, "UTF-8").replaceAll(")", "%29");
			setFilename(filename);
		}
		
		public DownloadModelAndView(byte[] data, String filename) {
			super("DefaultDownloadView");
			setFileData(data);
			setFilename(filename);
		}
		
		public void setContentType(String contentType) {
			this.addObject(ContentTypeKey, contentType);
		}
		
		public void setFilename(String filename) {
			this.addObject(FilenameKey, filename);
		}
		
		public void setFile(File file) {
			this.addObject(FileKey, file);
		}
		
		public void setFileData(byte[] fileData) {
			this.addObject(FileDataKey, fileData);
		}
		
		public void setDeleteFile(boolean delete) {
			this.addObject(DeleteFileKey, delete);
		}
	}	

	public void Download() {
		setContentType("application/octet-stream");
	}
	
	private void setHeader(HttpServletRequest request, HttpServletResponse response, String fileName) throws Exception {
		/*
		String userAgent = request.getHeader("User-Agent");
		boolean ie = userAgent.indexOf("MSIE") > -1;
		String newFilename;
		if (ie) {
			// fileName = URLEncoder.encode(fileName, "utf-8");
			newFilename = new String(fileName.getBytes("EUC-KR"), "8859_1");
		} else {
			newFilename = new String(fileName.getBytes("utf-8"), "8859_1");
		}// end if;
		*/
		
		
		String browser = request.getHeader("User-Agent");
		
		//System.out.println(browser);
		
		if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
			fileName = URLEncoder.encode(fileName, "utf-8").replaceAll("\\+", "%20").replace("%28", "(").replace("%29", ")");
			//fileName = URLEncoder.encode(fileName, "utf-8");
		}else{
			fileName = new String(fileName.getBytes("utf-8"), "ISO-8859-1");
		}

		
		//System.out.println(fileName);
		
		//response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		File file = (File)model.get(FileKey);
		byte[] fileData = (byte[]) model.get(FileDataKey);
		String fileName = (String) model.get(FilenameKey);
		String contentType = (String) model.get(ContentTypeKey);
		
		
		
		if (file != null) {

			if (StringUtils.isEmpty(fileName)) {
				fileName = file.getName();
			}

			if (StringUtils.isEmpty(contentType)) {
				contentType = URLConnection.guessContentTypeFromName(fileName);
			}

			if (!StringUtils.isEmpty(contentType)) {
				setContentType(contentType);
			}

			if (logger.isDebugEnabled()) {
				logger.debug("DownloadView --> FilePath : " + file.getPath());
				logger.debug("DownloadView --> FileName : " + fileName);
			}

			response.setContentType(getContentType());
			response.setContentLength((int) file.length());
			
			setHeader(request, response, fileName);

			OutputStream out = response.getOutputStream();

			FileInputStream fis = null;

			try {

				fis = new FileInputStream(file);

				FileCopyUtils.copy(fis, out);
			}catch(FileNotFoundException ex) {
				logger.error("Download", ex);
				throw new FileNotFoundException();
			} catch (Exception ex) {
				logger.error("Download", ex);
			} finally {

				if (fis != null) {
					try {
						fis.close();
					} catch (Exception e) {
					}
				}

			}// try end;
			out.flush();
			
			Boolean deleteFile = (Boolean)model.get(DeleteFileKey);
			if(deleteFile != null && deleteFile) {
				try {
					file.delete();
				}catch(Exception e) {
					logger.error("Can't delete file", e);
				}
			}
		} else if(fileData != null) {
			if (!StringUtils.isEmpty(contentType)) {
				setContentType(contentType);
			}
			
			response.setContentType(getContentType());
			response.setContentLength(fileData.length);
			
			setHeader(request, response, fileName);

			OutputStream out = response.getOutputStream();
			ByteArrayInputStream bis = new ByteArrayInputStream(fileData);
			try {
				IOUtils.copy(bis, out);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (bis != null) {
					try {
						bis.close();
					} catch (Exception e) {
					}
				}
			}// try end;
			out.flush();
		}
	}
	
	public static void mainXXX(String[] args){
		String s = "20141113(목)_우주기상_일일상황보고 (1).pdf";
		
		//s = s.replaceAll("\\(+", "%28");
		//s = s.replaceAll("\\)+", "%29");
		try {
			s = URLEncoder.encode(s, "UTF-8").replaceAll("\\+", "%20");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		System.out.println(s);
		
	}
}
