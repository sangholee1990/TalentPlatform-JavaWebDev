package com.gaia3d.web.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Base64;
import org.joda.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.dto.ChartData;
import com.gaia3d.web.mapper.ChartDataMapper;
import com.google.common.collect.Maps;

@Controller
@RequestMapping("/chart")
public class ChartController extends BaseController {
	
	private static final SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMddHHmmss");
	
	enum CartType {
		STA__02001,
		STA__02002,
		STA__02003,
		STA__02004,
		STB__02001,
		STB__02002,
		STB__02003,
		STB__02004,
		ACE__02001,
		ACE__02002,
		ACE__02003,
		ACE__02004,
		GOE1302001,
		
		ELECTRON_FLUX_SWAA,
		ELECTRON_FLUX_SWAA_2,
		GOES_MAG_SWAA,
		
		ELECTRON_FLUX,
		ELECTRON_FLUX_ALL,
		PROTON_FLUX,
		XRAY_FLUX,
		
		KP_INDEX_SWPC,
		KP_INDEX_KHU,
		
		DST_INDEX_KYOTO,
		DST_INDEX_KHU,
		
		MAGNETOPAUSE_RADIUS,
		ACE_MAG,
		ACE_SOLARWIND_DENS,
		ACE_SOLARWIND_SPD,
		ACE_SOLARWIND_TEMP,
		
		SOLAR_MAXIMUM,
		
		TEC_IMAGE
		
	}
	
	private List<? extends ChartData> searchChartDate(CartType chartType, LocalDateTime startDate, LocalDateTime endDate) {
		
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		List<? extends ChartData> list = null;
		
		Map<String, Object> params = Maps.newHashMap();
		switch(chartType) {
		case SOLAR_MAXIMUM:
			params.put("startDate", startDate.toString("yyyyMM") + "00000000");
			params.put("endDate", endDate.plusMonths(1).toString("yyyyMM") + "00000000");
			break;
		case TEC_IMAGE:
			params.put("startDate", startDate.toString("yyyyMMddHHmmss"));
			params.put("endDate", endDate.plusDays(1).toString("yyyyMMddHHmmss"));
			break;
			default:
				params.put("startDate", startDate.toString("yyyyMMddHHmmss"));
				params.put("endDate", endDate.plusHours(1).toString("yyyyMMddHHmmss"));
				
				break;
		}
		
		switch(chartType) {
		case STA__02001:
			list = mapper.SelectManyStaHet(params);
			break;
		case STA__02002:
			list = mapper.SelectManyStaImpact(params);
			break;
		case STA__02003:
			list = mapper.SelectManyStaMag(params);
			break;
		case STA__02004:
			list = mapper.SelectManyStaPlastic(params);
			break;
		case STB__02001:
			list = mapper.SelectManyStbHet(params);
			break;
		case STB__02002:
			list = mapper.SelectManyStbImpact(params);
			break;
		case STB__02003:
			list = mapper.SelectManyStbMag(params);
			break;
		case STB__02004:
			list = mapper.SelectManyStbPlastic(params);
			break;
		case ACE__02001:
			list = mapper.SelectManyAceEpam(params);
			break;
		case ACE__02002:
			list = mapper.SelectManyAceMag(params);
			break;
		case ACE__02003:
			list = mapper.SelectManyAceSis(params);
			break;
		case ACE__02004:
			list = mapper.SelectManyAceSwepam(params);
			break;
		case GOE1302001:
			break;
			
		case ELECTRON_FLUX_SWAA:
			list = mapper.SelectManyGoesElectronFluxSWAA(params);
			break;
		case ELECTRON_FLUX_SWAA_2:
			list = mapper.SelectManyGoesElectronFluxSWAA2(params);
			break;
		case GOES_MAG_SWAA:
			list = mapper.SelectManyGoesMagSWAA(params);
			break;
			
		case ELECTRON_FLUX:
			list = mapper.SelectManyGoesElectronFlux(params);
			break;
		case ELECTRON_FLUX_ALL:
			list = mapper.SelectManyGoesElectronFluxAll(params);
			break;
		case PROTON_FLUX:
			list = mapper.SelectManyGoesProtonFlux(params);
			break;
		case XRAY_FLUX:
			//list = mapper.SelectManyGoesXray5M(params);
			list = mapper.SelectManyGoesXray1M(params);
			break;
		case KP_INDEX_SWPC:
			list = mapper.SelectManyKpIndexSwpc(params);
			break;

		case KP_INDEX_KHU:
			list = mapper.SelectManyKpIndexKhu(params);
			break;
			
		case DST_INDEX_KYOTO:
			list = mapper.SelectManyDstIndexKyoto(params);
			break;
			
		case DST_INDEX_KHU:
			list = mapper.SelectManyDstKhuIndex(params);
			break;
			
		case ACE_MAG:
			list = mapper.SelectManyAceMag(params);
			break;
			
		case ACE_SOLARWIND_DENS:
			list = mapper.SelectManyAceSolarWindDensity(params);
			break;
			
		case ACE_SOLARWIND_SPD:
			list = mapper.SelectManyAceSolarWindSpeed(params);
			break;
			
		case ACE_SOLARWIND_TEMP:
			list = mapper.SelectManyAceSolarWindTemperature(params);
			break;
			
		case MAGNETOPAUSE_RADIUS:
			list = mapper.SelectManyMagnetopauseRadius(params);
			break;
			
		case SOLAR_MAXIMUM:
			list = mapper.SelectManySolarMaximum(params);
			break;

		case TEC_IMAGE:
			list = mapper.SelectManyTEC(params);
			break;

		default:
			break;
		}
		return list;		
	}
	@RequestMapping("chartData.do")
	@ResponseBody
	public List<? extends ChartData> chartData(ModelMap model, @RequestParam(value="type", required=true, defaultValue="--NOTEMPTY--") CartType type, 
			@RequestParam(value="sd", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") LocalDateTime startDate,
			@RequestParam(value="ed", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") LocalDateTime endDate) {
		
		return searchChartDate(type, startDate, endDate);
	}
	/*
	@RequestMapping("chartData.do")
	public ModelAndView chartData(ModelMap model, @RequestParam(value="type", required=true, defaultValue="--NOTEMPTY--") CartType type, 
			@RequestParam(value="sd", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") LocalDateTime startDate,
			@RequestParam(value="ed", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") LocalDateTime endDate) {
		
		List<? extends ChartData> chartData = searchChartDate(type, startDate, endDate);
		
		ModelAndView mav = new ModelAndView("JsonView");
		List<String> labels = new ArrayList<String>();
		labels.add("Date");
		labels.add("Value1");
		labels.add("Value2");
		mav.addObject("labels", labels);
		
		List<List<Object>> data = new ArrayList<List<Object>>();
		for(ChartData chart : chartData) {
			List<Object> a = new ArrayList<Object>();
			a.add(chart.getTm());
			a.add(1);
			a.add(2);
			a.add(3);
			data.add(a);
		}
		mav.addObject("data", data);
		return mav;
	}	
	*/
	
	@RequestMapping("chart.do")
	public void chart(ModelMap model) {

	}
	
	@RequestMapping("chart_popup.do")
	public void chart_popup(ModelMap model, @RequestParam(value="type", required=true, defaultValue="--NOTEMPTY--") CartType type,
			@RequestParam(value="sd", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") LocalDateTime startDate,
			@RequestParam(value="ed", required=true) @DateTimeFormat(pattern="yyyyMMddHHmmss") LocalDateTime endDate
			) {
		
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
	}
	
	// 차트를 이미지 파일로 저장
	@RequestMapping("exportChartImage.do")
	public void exportChartImage(@RequestParam(value="chartImage", required=true) String chartImage, @RequestParam(value="chartType", required=true) String chartType, HttpServletRequest request, HttpServletResponse response){
		chartImage = chartImage.replaceAll("data:image/png;base64,", "");
		byte[] file = Base64.decodeBase64(chartImage);	//Base64  >> Byte Code  org.apache.commons.codec.binary.Base64
		OutputStream output = null;
		
		if(chartType != null){
			chartType = chartType.toLowerCase();
		}else{
			chartType = "chart";
		}
		chartType = chartType +"_"+ sdf1.format(new Date());
		chartType = chartType + ".png";
		
		response.setContentType("image/png");
		response.setHeader("Content-disposition", "attachment; filename=\""+ chartType +"\""); 
		try {
			output = response.getOutputStream();
			output.write(file);
			output.close();
		} catch (IOException e) {
		}finally{
			if(output != null) try { output.close(); } catch (IOException e) {}
		}
	}

}
