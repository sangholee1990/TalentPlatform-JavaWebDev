package com.gaia3d.web.controller;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.code.IMAGE_CODE;
import com.gaia3d.web.dto.ChartSummaryDTO;
import com.gaia3d.web.dto.ChartSummaryDTO.Duration;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.dto.SWFCImageMetaDTO;
import com.gaia3d.web.mapper.ChartDataMapper;
import com.gaia3d.web.mapper.SWFCImageMetaMapper;
import com.google.common.base.Function;
import com.google.common.collect.ImmutableListMultimap;
import com.google.common.collect.Maps;
import com.google.common.collect.Multimaps;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/monitor")
public class MonitorController extends BaseController {
	
	private static final Logger logger = LoggerFactory.getLogger(MonitorController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping("monitor.do")
	public String main(Locale locale, Model model) {
		//logger.debug("Welcome home! The client locale is {}.", locale);
		//Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		//String formattedDate = dateFormat.format(date);
		//model.addAttribute("serverTime", formattedDate );
		
		return "/monitor/main";
	}
	
	@RequestMapping("chart_popup.do")
	public void chart_popup(Locale locale, Model model) {
		
	}
	
	@RequestMapping("chart_indicator.do")
	@ResponseBody
	public Map<String, Object> chart_indicator(Locale locale, Model model) {
		ChartDataMapper mapper = sessionTemplate.getMapper(ChartDataMapper.class);
		List<ChartSummaryDTO> summaryList = mapper.SelectSummary();
		ImmutableListMultimap<ChartSummaryDTO.DataType, ChartSummaryDTO> result = Multimaps.index(summaryList, new Function<ChartSummaryDTO, ChartSummaryDTO.DataType>() {
			@Override
			public ChartSummaryDTO.DataType apply(ChartSummaryDTO arg0) {
				return arg0.getDataType();
			}
		});
		Map<ChartSummaryDTO.DataType, Map<ChartSummaryDTO.Duration, ChartSummaryDTO>> result2 = Maps.newHashMap();
		for(Map.Entry<ChartSummaryDTO.DataType, ChartSummaryDTO> entry : result.entries()) {
			ChartSummaryDTO.DataType key = entry.getKey();
			result2.put(key, Maps.uniqueIndex(result.get(entry.getKey()), new Function<ChartSummaryDTO, ChartSummaryDTO.Duration>() {
				@Override
				public ChartSummaryDTO.Duration apply(ChartSummaryDTO arg0) {
					return arg0.getDuration();
				}
			}));
		}
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("notice1", ChartSummaryDTO.MaxCodeFor기상위성운영(summaryList, Duration.H3));
		output.put("notice2", ChartSummaryDTO.MaxCodeFor극항로항공기상(summaryList, Duration.H3));
		output.put("notice3", ChartSummaryDTO.MaxCodeFor전리권기상(summaryList, Duration.H3));
		output.put("elements", result2);
		return output;
	}
	
	@RequestMapping("search_by_code.do")
	@ResponseBody
	public Collection<SWFCImageMetaDTO> search_by_code(@RequestParam(value = "code", required = true) IMAGE_CODE code, 
			@RequestParam(value="createDate", required=false) @DateTimeFormat(pattern = "yyyyMMddHH") Date date) {
		
		SWFCImageMetaMapper mapper = sessionTemplate.getMapper(SWFCImageMetaMapper.class);
		MapperParam param = new MapperParam();
		param.put("code", code);
		param.put("createDate", date);
		return mapper.SelectManyIntertemporalByCode(param);
	}
	
	@RequestMapping("mainMonitor.do")
	public void mainMonitor(Locale locale, Model model) {
		
	}
}
