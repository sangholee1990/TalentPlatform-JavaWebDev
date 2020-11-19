package com.gaia3d.web.controller.admin;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.DbInfoDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.mapper.DbinfoMapper;
import com.gaia3d.web.util.Constants;
import com.gaia3d.web.util.PageNavigation;

@Controller
@RequestMapping("/admin/system/")
public class DbinfoController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(DbinfoController.class);
	
	@Autowired(required=true)
	@Resource(name = "sqlSessionTemplateSys")
	private SqlSession sessionTemplateSys;
	
	@RequestMapping("dbinfo_list.do")
	public void dbinfo_list (ModelMap model, 
			@RequestParam Map<String, Object> requestParams,
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize) {
		
		
		//TODO 컨넥션이 새로 생성될시 시스템 컨넥션에 연결해야함
		/*
		DbInfoDTO tablespaceInfo = new DbInfoDTO();
		tablespaceInfo.setFile_Name("/data/oracle/oradata/orcl/SWPCDATA.dbf");
		tablespaceInfo.setTablespace_Name("SWPCDATA");
		tablespaceInfo.setTotal(1100);
		tablespaceInfo.setUsed(991);
		tablespaceInfo.setFree(109);
		*/
		DbinfoMapper mapper = sessionTemplate.getMapper(DbinfoMapper.class);
		DbinfoMapper mapperSys = sessionTemplateSys.getMapper(DbinfoMapper.class);

		int count = mapper.Count(requestParams);
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		requestParams.put("startRow", navigation.getStartRow());
		requestParams.put("endRow", navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		//model.addAttribute("tableSpaceInfo", tablespaceInfo);
		
		//DbInfoDTO dto = mapperSys.SelectOne(requestParams);
		//model.addAttribute("tableSpaceInfo", dto);
		model.addAttribute("tableSpaceInfoList", mapperSys.SelectTableSpaceInfo(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}
}
