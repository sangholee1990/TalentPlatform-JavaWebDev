package com.gaia3d.web.controller;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.dto.ProgramDTO;
import com.gaia3d.web.exception.ArticleFileNotFoundException;
import com.gaia3d.web.exception.ArticleNotFoundException;
import com.gaia3d.web.mapper.CMEReportMapper;
import com.gaia3d.web.mapper.ProgramMapper;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.PageStatus;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;


@Controller
@RequestMapping("/reportdata")
public class ReportDataController extends   BaseController {
	private static final Logger logger = LoggerFactory.getLogger(ReportDataController.class);
	
	@Autowired(required=false)
	@Qualifier(value="CMEReportLocationResource")
	private FileSystemResource CMEReportLocationResource;
	
	@Autowired(required=false)
	@Qualifier(value="programLocationResource")
	private FileSystemResource CMEProgramLocationResource;
	
	public static class CMESearchInfo extends PageStatus{
		
		@DateTimeFormat(pattern="yyyyMMddHHmmss")
		Date sd;
		@DateTimeFormat(pattern="yyyyMMddHHmmss")
		Date ed;
		
		String type;
		
		public CMESearchInfo() {
			Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("UTC"));
			setEd(cal.getTime());
			cal.add(Calendar.DAY_OF_YEAR, -15);
			setSd(cal.getTime());
		}
		
		public Date getSd() {
			return sd;
		}
		
		public void setSd(Date startDate) {
			this.sd = startDate;
		}
		
		public Date getEd() {
			return ed;
		}
		
		public void setEd(Date endDate) {
			this.ed = endDate;
		}		
		
		public String getType() {
			return type;
		}
		
		public void setType(String type) {
			this.type = type;
		}
	}
	
	@RequestMapping("cme_list.do")
	public void pds_list(ModelMap model, @ModelAttribute("searchInfo") CMESearchInfo searchInfo) {
		CMEReportMapper mapper = sessionTemplate.getMapper(CMEReportMapper.class);
		
		MapperParam params = new MapperParam();
		params.put("startDate", searchInfo.getSd());
		params.put("endDate", searchInfo.getEd());
		params.put("type", searchInfo.getType());
		int count = mapper.Count(params);
		
		PageNavigation navigation = new PageNavigation(searchInfo.getPage(), count, 10);
		params.put("startRow", navigation.getStartRow());
		params.put("endRow", navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(params));
		model.addAttribute("pageNavigation", navigation);
	}	

	@RequestMapping("cme_download.do")
	public DownloadModelAndView cme_download(@RequestParam(value="f", required=true)  String filepathString) throws FileNotFoundException, ArticleNotFoundException{
		String filepath = filepathString;
		
		if(StringUtils.isEmpty(filepath))
			throw new ArticleFileNotFoundException();
		
		File file = new File(CMEReportLocationResource.getFile(), filepath);
		if(!file.exists() || !file.isFile())
			throw new ArticleFileNotFoundException();
		
	    return new DownloadModelAndView(file);
	}
	
	@RequestMapping("cme_download_program.do")
	public DownloadModelAndView cme_download_program() throws FileNotFoundException, ArticleNotFoundException, UnsupportedEncodingException{
		ProgramMapper mapper = sessionTemplate.getMapper(ProgramMapper.class);
		ProgramDTO dto = mapper.SelectRecentOne("CME");
		if(dto == null) 
			throw new ArticleNotFoundException();
		
		String filepath = dto.getFilepath();
		if(filepath == null)
			throw new ArticleFileNotFoundException();
		
		File file = new File(CMEProgramLocationResource.getFile(), filepath);
		if(!file.exists() || !file.isFile())
			throw new ArticleFileNotFoundException();
		
	    return new DownloadModelAndView(file, dto.getFilename());
	}
	

	/**
	 * STOA CME 모델 분석 표출 페이지 이동
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("cme_model.do")
	public void cmeModel(Model model) throws Exception{
	}

	/**
	 * 파일 리스트
	  * jQuery File Tree JSP Connector
	  * Version 1.0
	  * Copyright 2008 Joshua Gould
	  * 21 April 2008
	 * @throws Exception 
	*/	
	@RequestMapping(value ="/jqueryFileTree.do", method = RequestMethod.POST)
	@ResponseBody
	public void fileTree(HttpServletRequest request, HttpServletResponse response) throws Exception{
		PrintWriter out = null;
		try{
			response.setContentType("text/html");
			response.setCharacterEncoding("UTF-8");
			
			out = response.getWriter();
			
			String dirStr = request.getParameter("dir");
			
		    if (dirStr == null) {
		    	return;
		    }
			
			if (dirStr.charAt(dirStr.length()-1) == '\\') {
				dirStr = dirStr.substring(0, dirStr.length()-1) + "/";
			} else if (dirStr.charAt(dirStr.length()-1) != '/') {
				dirStr += "/";
			}
			
			dirStr = java.net.URLDecoder.decode(dirStr, "UTF-8");	
			File dir = new File(dirStr);
		    if (dir.exists()) {
				String[] files = dir.list(new FilenameFilter() {
				    public boolean accept(File dir, String name) {
						return name.charAt(0) != '.';
				    }
				});
				Arrays.sort(files, String.CASE_INSENSITIVE_ORDER);
				out.print("<ul class=\"jqueryFileTree\" style=\"display: none;\">");
				// All dirs
				for (String file : files) {
				    if (new File(dirStr, file).isDirectory()) {
						out.print("<li class=\"directory collapsed\"><a href=\"#\" rel=\"" + dirStr + file + "/\">"
							+ file + "</a></li>");
				    }
				}
				// All files
				for (String file : files) {
				    if (!new File(dirStr, file).isDirectory()) {
						int dotIndex = file.lastIndexOf('.');
						String ext = dotIndex > 0 ? file.substring(dotIndex + 1) : "";
						out.print("<li class=\"file ext_" + ext + "\"><a href=\"#\" rel=\"" + dirStr + file + "\">"
							+ file + "</a></li>");
				    	}
				}
				out.print("</ul>");
		    }
		}catch(Exception e){
			throw e;
		}finally{
			if(out != null) try{ out.close(); }catch (Exception e2) {}
		}
		
	}//fileTree end
	
	
	/**
	 * 파일 정보 가져오기
	 * @param fileName
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("modelData.do")
	@ResponseBody
	public List<String> modelData(@RequestParam(value="filePath", required=true) String filePath) throws Exception{
		//CME 모델 경로
		List<String> data = null;
		BufferedReader in = null;
		File file =  new File(filePath);
		if(file.exists()){	
			try{
				in = new BufferedReader(new FileReader(file));
				String line = null;
				data = new ArrayList<String>();
				while ((line = in.readLine()) != null) {		//파일 읽기
					line = line.replaceAll("#", "");
					if(!line.equals("")){					
						data.add(line);
					}
				}
			}catch(Exception e){
				throw e;
			}finally{
				if(in != null) try{ in.close(); }catch (Exception e2) {}
			}
		}
		return data;
	}//modelData end
	
	/**
	 * 그래프 이미지 파일 
	 * @param request, response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("imageExport.do")
	public void imageExport(HttpServletRequest request, HttpServletResponse response) throws Exception{
		try {
			String data = request.getParameter("data");	// Base64 코드
	        data = data.replaceAll("data:image/png;base64,", "");
	        byte[] file = Base64.decodeBase64(data);	//Base64  >> Byte Code  org.apache.commons.codec.binary.Base64
	        ByteArrayInputStream is = new ByteArrayInputStream(file);	//Byte Code 입력

	        response.setContentType("image/png"); 	//페이지 Type
	        response.setHeader("Content-Disposition", "attachment; filename=model.png");  //페이지  Header
	        IOUtils.copy(is, response.getOutputStream());	//Byte Code 출력 org.apache.commons.io.IOUtils
	        IOUtils.closeQuietly(is);	//닫기
	        response.flushBuffer();
		}catch(IOException e) {
			logger.error("", e);
		}
	}

}
