package com.gaia3d.web.controller.admin;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.service.SolarEventReportService;
import com.gaia3d.web.service.StatisticsService;

@Controller
@RequestMapping("/admin/statistics/")
public class StatisticsController extends BaseController{
	
	private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	
	@Autowired
	private StatisticsService statisticsService; 
	
	@Autowired
	private SolarEventReportService solarEventService;
	
	
	@RequestMapping("grade_list.do")
	public String listGrade(@RequestParam Map<String, Object> params, Model model) throws Exception{
		
		
		Calendar cal = Calendar.getInstance();
		
		if(!params.containsKey("endDate")){
			params.put("endDate", sdf.format(cal.getTime()));
		}
		
		cal.add(Calendar.MONTH, -1);
		
		if(!params.containsKey("startDate")){
			params.put("startDate", sdf.format(cal.getTime()));
		}
		
		String[] data = {"1", "2", "3", "4"};
		params.put("datas", data);
		
		model.addAttribute("list", statisticsService.listGrade(params));
		model.addAttribute("xra", solarEventService.selectGrade(params));
		model.addAttribute("params", params);
		return "admin/statistics/grade_list";
	}
	
}
