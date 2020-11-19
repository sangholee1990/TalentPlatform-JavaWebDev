package com.gaia3d.web.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.time.DateUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.dto.SimpleStringValueChartData;
import com.gaia3d.web.exception.DataNotFoundException;
import com.gaia3d.web.mapper.ChartDataMapper;
import com.gaia3d.web.mapper.FlarePredicationMapper;
import com.gaia3d.web.mapper.SolarProtonEventMapper;
import com.gaia3d.web.util.SpeImageSearch;
import com.gaia3d.web.view.DefaultDownloadView.DownloadModelAndView;
import com.google.common.collect.Maps;

@Controller
@RequestMapping("/forecast")

public class ForecastController extends BaseController {
	//private static final Logger logger = LoggerFactory.getLogger(ForecastController.class);
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	
	@Autowired(required = false)
	@Qualifier("SolarMaximumLocationResource")
	private FileSystemResource SolarMaximumLocationResource;
	
	
	@Autowired(required = false)
	@Qualifier("DefaultLocationResource")
	protected FileSystemResource DefaultLocationResource;
	
	@Value("${flare.prediction.image.path}")
	private String flarePredictionImagePath;
	
	@RequestMapping("spe_fp.do")
	public void SolarProtonEventAndFlarePrediction(ModelMap model) {
		
	}

	@RequestMapping("dst_kp_sm.do")
	public void DstKpSolarMaximum(ModelMap model) {
		
	}
	
	@RequestMapping("searchSPE.do")
	@ResponseBody
	public Map<String,Object> searchSolarProtonEvent(ModelMap model, 
			@RequestParam(value="sd", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") Date startDate,
			@RequestParam(value="ed", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") Date endDate) {
		
		SolarProtonEventMapper mapper = sessionTemplate.getMapper(SolarProtonEventMapper.class);
		MapperParam param = new MapperParam();
		param.put("startDate", startDate);
		param.put("endDate", DateUtils.addHours(endDate, 1));
		
		Map<String,Object> result = Maps.newHashMap();
		result.put("spe", mapper.SelectMany(param));
		
		/*
		param.put("startDate", sdf.format(DateUtils.truncate(startDate, Calendar.DATE)));
		param.put("endDate", sdf.format(DateUtils.addSeconds(DateUtils.addDays(DateUtils.truncate(endDate, Calendar.DATE), 1), -1)));
		*/
		//당일 예측모델 검색조건
		param.put("startDate", DateUtils.truncate(startDate, Calendar.DATE));
		param.put("endDate", DateUtils.addSeconds(DateUtils.addDays(DateUtils.truncate(endDate, Calendar.DATE), 1), -1));
		FlarePredicationMapper flareMapper= sessionTemplate.getMapper(FlarePredicationMapper.class);
		result.put("flare", flareMapper.SelectMany(param));
		
		return result; 
	}
	
	@RequestMapping("view_solar_maximum.do")
	@ResponseBody
	public DownloadModelAndView viewSolarMaximum(ModelMap model, @RequestParam(value="tm", required=true) String tm) throws FileNotFoundException, UnsupportedEncodingException {
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		MapperParam param = new MapperParam();
		param.put("tm", tm);
		SimpleStringValueChartData data = mapper.SelectOneSolarMaximum(param);
		if(data != null) {
			File file = new File(SolarMaximumLocationResource.getPath(), data.getValue());
			if(!file.exists() || !file.isFile())
				throw new FileNotFoundException();
			
			return new DownloadModelAndView(file, file.getName());
		} else {
			throw new DataNotFoundException();
		}
	}
	
	@RequestMapping("getSpeImage.do")
	@ResponseBody
	public DownloadModelAndView getSpeImage(ModelMap model, @RequestParam(value="tm", required=true) String tm) throws FileNotFoundException, UnsupportedEncodingException {
		SpeImageSearch speFileSearch = new SpeImageSearch();
		speFileSearch.setRootDir(flarePredictionImagePath);
		boolean isSearch = speFileSearch.search(tm);
		if(isSearch) {
			//File file = new File(SolarMaximumLocationResource.getPath(), data.getValue());
			File file = speFileSearch.nearFile();
			
			if(!file.exists() || !file.isFile())
				throw new FileNotFoundException();
			
			return new DownloadModelAndView(file, file.getName());
		} else {
			throw new DataNotFoundException();
		}
	}
	
	@RequestMapping("spe_image_popup.do")
	public void speImagePopup(ModelMap model) {
		
	}
	
	@RequestMapping("three_day_frct.do")
	public void three_day_frct(ModelMap model) {
		
	}
	
	@RequestMapping("get_three_day_frct.do")
	@ResponseBody
	public String get_three_day_frct(Model model, 
			@RequestParam(value="yyyy", required=true) String yyyy
			,@RequestParam(value="mm", required=true) String mm
			,@RequestParam(value="dd", required=true) String dd
			,@RequestParam(value="am_type", required=true, defaultValue="00") String amType
			,@RequestParam(value="frct_type", required=true, defaultValue="RSGA") String frctType
			,HttpServletRequest request
			,HttpServletResponse response
			) throws FileNotFoundException, UnsupportedEncodingException {
		
		String frct_rsga_path = "/swfc/OBR/NOAA/FRCT_RSGA/Y{0}/M{1}/D{2}/NOAA_FRCT_RSGA_{3}{4}{5}000000.txt";
		String frct_three_day_path = "/swfc/OBR/NOAA/FRCT_THREEDAY/Y{0}/M{1}/D{2}/NOAA_FRCT_THREEDAY_{3}{4}{5}{6}3000.txt";
		String filePath = null;
		
		if("RSGA".equals(frctType)){
			filePath = MessageFormat.format(frct_rsga_path, yyyy, mm, dd, yyyy, mm, dd);
		}else{
			filePath = MessageFormat.format(frct_three_day_path, yyyy, mm, dd, yyyy, mm, dd, amType);
		}
		
		File file = new File(filePath);
		if(!file.exists() || !file.isFile()) return "no data";
		
		BufferedReader br = null;
		StringBuffer sb = new StringBuffer();
		try{
			br = new BufferedReader(new FileReader(file));
			String s;
			while((s = br.readLine()) != null){
				sb.append(s + "<br/>");
			}
		}catch(Exception e){
			
		}finally{
			try { if(br != null) br.close(); } catch (IOException e) {}
		}
		model.addAttribute("accept", "text/plain");
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		
		return sb.toString();
	} 
}
