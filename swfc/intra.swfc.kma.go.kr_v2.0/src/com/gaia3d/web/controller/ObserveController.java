package com.gaia3d.web.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.web.mapper.ForecastReportMapper;
import com.gaia3d.web.util.PageNavigation;

@Controller
@RequestMapping("/observe")
public class ObserveController extends BaseController {
	//private static final Logger logger = LoggerFactory.getLogger(ObserveController.class);
	
	@RequestMapping("observe_list.do")
	public void observe_list(ModelMap model) {
		
	}

	@RequestMapping("guidence_list.do")
	public void guidence_list(ModelMap model, @RequestParam(value = "p", defaultValue = "1") int page) {
		ForecastReportMapper mapper = sessionTemplate.getMapper(ForecastReportMapper.class);

		Map<String, Object> params = new HashMap<String, Object>();

		int count = mapper.Count(params);

		PageNavigation navigation = new PageNavigation(page, count, 10);
		params.put("startRow", navigation.getStartRow());
		params.put("endRow", navigation.getEndRow());

		model.addAttribute("list", mapper.SelectMany(params));
		model.addAttribute("pageNavigation", navigation);
	}
}
