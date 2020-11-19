/**
 * 
 */
package com.gaia3d.web.util;

import java.io.File;
import java.io.FilenameFilter;
import java.text.MessageFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

/**
 * spe 이미지 파일의 가까운 시간을 계산하는 클래스
 * @author Administrator
 *
 */
public class SpeImageSearch {
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/ddHH:mm:ss");
	private static final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmmss");
	private static final SimpleDateFormat yyyymmdd = new SimpleDateFormat("yyyyMMdd");
	private static final SimpleDateFormat yyyymmdd2 = new SimpleDateFormat("yyyy/MM/dd");
	
	String rootDir = "/swfc/OBR/ASIA/Y{0}/M{1}/D{2}";
	private List<FileTempVo> fileList = null;
	
	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		SpeImageSearch speFileSearch = new SpeImageSearch();
		boolean isSearch = speFileSearch.search("2014/11/26 03:00:00");
		if(isSearch){
			File file = speFileSearch.nearFile();
			//System.out.println(file.getName());
		}else{
			System.out.println("nothing");
		}
	}
	
	public boolean search(String searchDate){
		
		Date requestDate = null;
		
		try{
			requestDate = sdf.parse(searchDate);
			String searchDir = MessageFormat.format(rootDir, yyyymmdd2.format(requestDate).split("/"));
			
			
			//System.out.println(searchDir);
			
			File dir = new File(searchDir);
			if(!dir.exists() || !dir.isDirectory()) return false;
			
			File[] imageList = dir.listFiles(new FilenameFilter() {
				@Override
				public boolean accept(File dir, String name) {
					//return (name.matches("AIA(\\d{8})_(\\d{6})_(\\d{4})_350.png"));
					return (name.matches("saia_00193_fd_(\\d{8})_(\\d{6}).png"));
				}
			});
			
			
			//System.out.println("image list==>" + imageList.length);
			
			
			fileList = new ArrayList<FileTempVo>();
			Date fileDate;
			String fileName;
			String[] token;
			String date;
			String time;
			FileTempVo vo;
			for(File f : imageList){
				
				//System.out.println(f.getName());
				
				fileName = f.getName();
				token = fileName.split("_");
				date = token[3];
				time = token[4];
				fileDate = sdf2.parse(date + time);
				
				Long diff = Math.abs( (requestDate.getTime() - fileDate.getTime()) / 1000 / 60 ); //시간계산
				vo = new FileTempVo(diff, fileName);
				vo.setPath(f.getPath());
				vo.setFile(f);
				fileList.add(vo);
				
			}
			
			Comparator comparator = new Comparator<FileTempVo>() {
				@Override
				public int compare(FileTempVo o1, FileTempVo o2) {
					FileTempVo t1 = o1;
					FileTempVo t2 = o2;
					return t1.getDiff().compareTo(t2.getDiff());
				}
			};
			
			Collections.sort(fileList, comparator);
			
			
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return (fileList != null && fileList.size() > 0);
	}
	
	public File nearFile(){
		if(fileList == null || fileList.size() == 0) return null;
		FileTempVo vo = fileList.get(0);
		return vo.getFile();
	}
	
	
	
	public void setRootDir(String rootDir) {
		this.rootDir = rootDir;
	}

	public class FileTempVo{
		private String path;
		private Long diff;
		private String fileName;
		private File file;
		
		public FileTempVo(Long diff, String fileName){
			this.diff = diff;
			this.fileName = fileName;
		}

		public String getPath() {
			return path;
		}

		public void setPath(String path) {
			this.path = path;
		}

		public Long getDiff() {
			return diff;
		}

		public void setDiff(Long diff) {
			this.diff = diff;
		}

		public String getFileName() {
			return fileName;
		}

		public void setFileName(String fileName) {
			this.fileName = fileName;
		}

		public File getFile() {
			return file;
		}

		public void setFile(File file) {
			this.file = file;
		}
		
	}
}
