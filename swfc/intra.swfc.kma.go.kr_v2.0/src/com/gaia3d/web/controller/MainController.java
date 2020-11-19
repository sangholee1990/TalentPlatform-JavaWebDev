package com.gaia3d.web.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.web.dto.BoardsDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.exception.ArticleNotFoundException;
import com.gaia3d.web.mapper.BoardMapper;
import com.gaia3d.web.util.Constants;
import com.gaia3d.web.util.PageNavigation;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/")
public class MainController extends BaseController {
	
	
	private static final String SITE_CODE_CD = "SITE_CODE_CD";
	private static final String BOARD_NOTICE_CODE = "3";
	private static final String INTRANET_SITE_CODE_CD = "3";
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(Locale locale, Model model) {
		//logger.debug("Welcome home! The client locale is {}.", locale);
		//Date date = new Date();
		//DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		//String formattedDate = dateFormat.format(date);
		//model.addAttribute("serverTime", formattedDate );
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("site_code_cd", INTRANET_SITE_CODE_CD);
		params.put("board_code_cd", BOARD_NOTICE_CODE);
		params.put("use_yn", "Y");
		
		//메인 화면에 표출되는 공지목록 조회
		int count = mapper.Count(params);
		PageNavigation navigation = new PageNavigation(1, count, 5);
		params.put("startRow", ""+navigation.getStartRow());
		params.put("endRow", ""+navigation.getEndRow());
		model.addAttribute("noticeList", mapper.SelectMany(params));
		
		//팝업 여부가 Y인 값들을 최근 등록된 20건 가져온다.
		params.put("popup_yn", "Y");
		count = mapper.Count(params);
		navigation = new PageNavigation(1, count, 20);
		params.put("startRow", ""+navigation.getStartRow());
		params.put("endRow", ""+navigation.getEndRow());
		model.addAttribute("noticePopupList", mapper.SelectMany(params));
		
		return "/main/main";
	}
	
	
	@RequestMapping("notice_list.do")
	public void notice_list(ModelMap model, 
			@RequestParam Map<String, Object> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize) {
		
		BoardMapper mapper = sessionTemplate.getMapper(BoardMapper.class);
		requestParams.put("site_code_cd", INTRANET_SITE_CODE_CD);
		requestParams.put("board_code_cd", BOARD_NOTICE_CODE);
		requestParams.put("use_yn", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());

		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}
	
	
}


