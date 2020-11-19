package com.gaia3d.web.controller.admin;

import java.io.BufferedOutputStream;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.FileSystemResource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.gaia3d.web.controller.BaseController;

import com.gaia3d.web.dto.SWPCAceMag;
import com.gaia3d.web.dto.SWPCGoesProtonFlux;
import com.gaia3d.web.dto.SWPCGoesXray1M;
import com.gaia3d.web.dto.SimpleDoubleValueChartData;
import com.gaia3d.web.dto.SimpleIntegerValueChartData;
import com.gaia3d.web.service.StatsService;

import com.gaia3d.web.util.StatsPdf;


/**
 * 월간 분석 통계 자료의 요청을 처리하는 클래스
 * @author chadol
 *
 */
@Controller
@RequestMapping("/admin/stats")
public class StatsController extends BaseController {
	
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("MM");
	
	@Autowired
	private StatsService statsService;
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired(required=false)
	@Qualifier(value="DownloadLocationResource")
	private FileSystemResource DownloadLocationResource;
	
	/**
	 * 월간 분석 자료를 그래프와 표로 보여준다.
	 * @param model
	 * @param requestParams
	 */
	@RequestMapping("stat_list.do")
	public void stat_list(ModelMap model,
			@RequestParam Map<String, Object> requestParams) {
		
		Calendar cal = Calendar.getInstance();
		
		if(!requestParams.containsKey("startYear")){
			requestParams.put("startYear", String.valueOf( cal.get(Calendar.YEAR) ));
		}
		
		if(!requestParams.containsKey("startMonth")) {
			requestParams.put("startMonth", sdf.format(cal.getTime()));
		}
		
		if(!requestParams.containsKey("search_kind")) {
			requestParams.put("search_kind", "graph");
		}
		
		model.addAttribute("xrayList", statsService.SelectXrayStat(requestParams));
		model.addAttribute("protonList", statsService.SelectProtonStat(requestParams));
		model.addAttribute("kpList", statsService.SelectKpStat(requestParams));
		model.addAttribute("mpList", statsService.SelectMpStat(requestParams));
		model.addAttribute("btList", statsService.SelectBtStat(requestParams));
		model.addAttribute("bulk_spdList", statsService.SelectBulk_SpdStat(requestParams));
		model.addAttribute("pro_densList", statsService.SelectPro_DensStat(requestParams));
		model.addAttribute("ion_tempList", statsService.SelectIon_TempStat(requestParams));
		model.addAttribute("searchInfo", requestParams);
	}
	
	/**
	 * 월간 분석 자료를 PDF로 다운로드 받는다.
	 * @param model
	 * @param requestParams
	 */
	@RequestMapping("stat_download_pdf.do")
	public void stat_download_pdf(@RequestParam(value="startYear") String startYear, @RequestParam(value="startMonth") String startMonth, @RequestParam(value="search_current") String search_current, @RequestParam(value="search_kind") String search_kind
			,@RequestParam Map<String, Object> param
			, HttpServletRequest request
			, HttpServletResponse response
			) throws Exception {
		
		Map<String, Object> pdfParamMap = new HashMap<String, Object>();
		
		List<SWPCGoesXray1M> xrayStatReport = null;
		List<SWPCGoesProtonFlux> protonStatReport = null;
		List<SimpleIntegerValueChartData> kpStatReport = null;
		List<SimpleDoubleValueChartData> mpStatReport = null;
		List<SWPCAceMag> btStatReport = null;
		List<SimpleDoubleValueChartData> bulk_spdReport = null;
		List<SimpleDoubleValueChartData> pro_densReport = null;
		List<SimpleDoubleValueChartData> ion_tempReport = null;
		
		String xrayStatImagedata = null;
		String xrayStatImageFile = null;
		
		String protonStatImagedata = null;
		String protonStatImageFile = null;
		
		String kpStatImagedata = null;
		String kpStatImageFile = null;
		
		String mpStatImagedata = null;
		String mpStatImageFile = null;
		
		String btStatImagedata = null;
		String btStatImageFile = null;
		
		String bulk_spdStatImagedata = null;
		String bulk_spdStatImageFile = null;
		
		String pro_densStatImagedata = null;
		String pro_densStatImageFile = null;
		
		String ion_tempStatImagedata = null;
		String ion_tempStatImageFile = null;
		
		if(search_current == null) search_current = "";
		
		
		if("".equals(search_current) || search_current.equals("XRAY")) {
			xrayStatReport = statsService.SelectXrayStat(param);
			pdfParamMap.put("xrayTable", xrayStatReport);
			 xrayStatImagedata = (String)param.get("statXrayData");
			 xrayStatImageFile = DownloadLocationResource.getPath() + File.separator + "xrayStatImageFile" + System.currentTimeMillis() + ".png";
			
			if(saveChart(xrayStatImagedata,  xrayStatImageFile)){ 
				pdfParamMap.put("xrayImage", xrayStatImageFile);
			}
		}
		
		if("".equals(search_current) || search_current.equals("PROTON")) {
			protonStatReport = statsService.SelectProtonStat(param);
			pdfParamMap.put("protonTable", protonStatReport);
			
			protonStatImagedata = (String)param.get("statProtonData");
			protonStatImageFile = DownloadLocationResource.getPath() + File.separator +  "protonStatImageFile" + System.currentTimeMillis() + ".png";
			
			if(saveChart(protonStatImagedata, protonStatImageFile)) {
				pdfParamMap.put("protonImage", protonStatImageFile);
			}
		}
		
		if("".equals(search_current) || search_current.equals("KP")) {
			kpStatReport =  statsService.SelectKpStat(param);
			pdfParamMap.put("kpTable", kpStatReport);
			
			kpStatImagedata = (String)param.get("statKpData");
			kpStatImageFile = DownloadLocationResource.getPath() + File.separator +  "kpStatImageFile" + System.currentTimeMillis() + ".png";
			
			if(saveChart(kpStatImagedata, kpStatImageFile)) {
				pdfParamMap.put("kpImage", kpStatImageFile);
			}
		}
		
		if("".equals(search_current) || search_current.equals("MP")) {
			mpStatReport = statsService.SelectMpStat(param);
			pdfParamMap.put("mpTable", mpStatReport);
			
			mpStatImagedata = (String)param.get("statMpData");
			mpStatImageFile = DownloadLocationResource.getPath() + File.separator + "mpStatImageFile" + System.currentTimeMillis() + ".png";
			
			if(saveChart(mpStatImagedata, mpStatImageFile)) {
				pdfParamMap.put("mpImage", mpStatImageFile);
			}
		}
		
		if("".equals(search_current) || search_current.equals("BT")) {
			btStatReport = statsService.SelectBtStat(param);
			pdfParamMap.put("btTable", btStatReport);
			
			btStatImagedata = (String)param.get("statBtData");
			btStatImageFile = DownloadLocationResource.getPath() + File.separator + "btStatImageFile" + System.currentTimeMillis() + ".png";
			
			if(saveChart(btStatImagedata, btStatImageFile)) {
				pdfParamMap.put("btImage", btStatImageFile);
			}
		}
		
		if("".equals(search_current) || search_current.equals("BULK_SPD")) {
			bulk_spdReport = statsService.SelectBulk_SpdStat(param);
			pdfParamMap.put("bulk_spdTable", bulk_spdReport);
			
			bulk_spdStatImagedata = (String)param.get("statBulk_spdData");
			bulk_spdStatImageFile = DownloadLocationResource.getPath() + File.separator + "bulk_spdStatImageFile" + System.currentTimeMillis() + ".png";
			
			if(saveChart(bulk_spdStatImagedata, bulk_spdStatImageFile)) {
				pdfParamMap.put("bulk_spdImage", bulk_spdStatImageFile);
			}
		}
		
		if("".equals(search_current) || search_current.equals("PRO_DENS")) {
			pro_densReport = statsService.SelectPro_DensStat(param);
			pdfParamMap.put("pro_densTable", pro_densReport);
			
			pro_densStatImagedata = (String)param.get("statPro_densData");
			pro_densStatImageFile = DownloadLocationResource.getPath() + File.separator + "pro_densStatImageFile" + System.currentTimeMillis() + ".png";
			
			if(saveChart(pro_densStatImagedata, pro_densStatImageFile)) {
				pdfParamMap.put("pro_densImage", pro_densStatImageFile);
			}
		}
		
		if("".equals(search_current) || search_current.equals("ION_TEMP")) {
			ion_tempReport = statsService.SelectIon_TempStat(param);
			pdfParamMap.put("ion_tempTable", ion_tempReport);
			
			ion_tempStatImagedata = (String)param.get("statIon_tempData");
			ion_tempStatImageFile = DownloadLocationResource.getPath() + File.separator + "ion_tempStatImageFile" + System.currentTimeMillis() + ".png";
			
			if(saveChart(ion_tempStatImagedata, ion_tempStatImageFile)) {
				pdfParamMap.put("ion_tempImage", ion_tempStatImageFile);
			}
		
		}
	
		String fontPath = String.format("%s,%s", servletContext.getRealPath("/WEB-INF/classes/BATANG.TTC"), 0);
		
		StatsPdf statspdf = new StatsPdf(DownloadLocationResource.getFile(), fontPath);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		try {
			statspdf.createPdf(pdfParamMap, baos, startYear, startMonth, search_current, search_kind);
		} catch(Exception ex) {
			ex.printStackTrace();
		}
		
		String filename = "월간통계정보_" +  startYear +"_"+ startMonth + ".pdf";
		
		// 브라우저에 따라 문자열을 인코딩
		String browser = request.getHeader("User-Agent");
		if(browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")){
			filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		}else{
			filename = new String(filename.getBytes("UTF-8"), "ISO-8859-1");
		}
		
		// 타입을 PDF로 지정
		response.setContentType("application/pdf");
		response.setHeader("Expires:", "0");
		response.setHeader("Content-Disposition", "attachment; filename=" + filename);
		
		OutputStream os = null;
		try{
			os = response.getOutputStream();
			os.write(baos.toByteArray());
		}finally{
			if(os != null)os.close();
		}
	}
	
	// 차트를 이미지 파일로 저장
	public boolean saveChart(String imageData, String savePath){
		imageData = imageData.replaceAll("data:image/png;base64,", "");
		byte[] file = Base64.decodeBase64(imageData);	//Base64  >> Byte Code  org.apache.commons.codec.binary.Base64
		//ByteArrayInputStream is = new ByteArrayInputStream(file);	//Byte Code ?낅젰
		FileOutputStream o = null;
		BufferedOutputStream bos = null;
		File realFile = new File(savePath);
		boolean isSave = false; 
		try {
			o = new FileOutputStream(savePath);
			bos = new BufferedOutputStream(o);
			bos.write(file);
			isSave = true;
		} catch (FileNotFoundException e) {
		} catch (IOException e) {
		}finally{
			if(bos != null)
				try { bos.close(); } catch (IOException e) {}
		}
		
		
		if(realFile.exists()){
			return isSave;
		}
		
		return isSave;
	}
}