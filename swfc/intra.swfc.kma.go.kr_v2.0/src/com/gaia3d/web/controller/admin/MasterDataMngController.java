package com.gaia3d.web.controller.admin;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.hierarchicalroles.UserDetailsWrapper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.DataMasterDTO;
import com.gaia3d.web.dto.DomainDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.exception.MetaInfoNotFoundException;
import com.gaia3d.web.mapper.CoverageMapper;
import com.gaia3d.web.mapper.DataKindInsideMapper;
import com.gaia3d.web.mapper.DataKindMapper;
import com.gaia3d.web.mapper.DataMasterMapper;
import com.gaia3d.web.mapper.DomainLayerMapper;
import com.gaia3d.web.mapper.DomainMapper;
import com.gaia3d.web.mapper.DomainSubMapper;
import com.gaia3d.web.mapper.SatGroupMapper;
import com.gaia3d.web.mapper.SatMapper;
import com.gaia3d.web.user.WebUser;
import com.gaia3d.web.util.Constants;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.PageStatus;
import com.gaia3d.web.util.WebUtil;

@Controller
@RequestMapping("/admin/master")
public class MasterDataMngController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(MasterDataMngController.class);
	

	/******************************************************************************
	 * 
	 * 수집자료 마스터 정보
	 * 
	******************************************************************************/
	/**
	 * 수집자료 마스터 정보리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("datamaster_list.do")
	public void datamaster_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DataMasterMapper mapper = sessionTemplate.getMapper(DataMasterMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 수집자료 마스터 정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("datamaster_list_popup.do")
	public void datamaster_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DataMasterMapper mapper = sessionTemplate.getMapper(DataMasterMapper.class);
	
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 수집자료 마스터 정보등록
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("datamaster_form.do")
	public void datamaster_form(ModelMap model, 
			@RequestParam(value="view_clt_dta_mstr_seq_n", required=false) String clt_dta_mstr_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		DataMasterDTO dto = null;
		if(mode.equalsIgnoreCase("new") ) {
			dto = new DataMasterDTO();
			model.addAttribute("mode", "new");
			
		} else if (mode.equalsIgnoreCase("update") && clt_dta_mstr_seq_n != null){
			DataMasterMapper mapper = sessionTemplate.getMapper(DataMasterMapper.class);
			MapperParam params = new MapperParam();
			params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("수집자료 마스터 정보가  존재하지 않습니다.");
		}
		
		model.addAttribute("dataMasterDTO", dto);
		
	}

	/**
	 * 수집자료 마스터 정보조회
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("datamaster_view.do")
	public void datamaster_view(ModelMap model, 
			@RequestParam(value="view_clt_dta_mstr_seq_n", required=false) String clt_dta_mstr_seq_n ) throws Exception {
	
		DataMasterMapper mapper = sessionTemplate.getMapper(DataMasterMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
		HashMap dto = mapper.SelectOneAll(params);

		if(dto == null) {
			throw new Exception("수집자료 마스터 정보가  존재하지 않습니다.");
		}
		
		Set k = dto.keySet();
		
		//logger.debug("---" + k);
		//logger.debug("---" + dto.get("CLT_TAR_GRP_KOR_NM"));
		model.addAttribute("dataMasterDTO", dto);
		
	}
	
	
	/**
	 * 수집자료 마스터 정보삭제
	 * @param requestParams
	 * @param sat_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("datamaster_del.do")
	public String datamaster_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_clt_dta_mstr_seq_n", required=false) String clt_dta_mstr_seq_n) throws Exception {
	
		DataMasterMapper mapper = sessionTemplate.getMapper(DataMasterMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_dta_mstr_seq_n", clt_dta_mstr_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
	    params.put("mdf_k_seq_n", user.getDetail().getId());
	    params.put("mdf_ip", request.getRemoteAddr());
	    
		mapper.Delete(params);
		
		requestParams.remove("view_clt_dta_mstr_seq_n");
		return "redirect:datamaster_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 수집자료 마스터 정보등록 수정
	 * @param DomainDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="datamaster_submit.do", method=RequestMethod.POST)
	public String datamaster_submit(HttpServletRequest request,
			@ModelAttribute("dataMasterDTO") @Valid DataMasterDTO dataMasterDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/data/datamaster_form";
	
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
		
		
		DataMasterMapper mapper = sessionTemplate.getMapper(DataMasterMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			
			dataMasterDTO.setRg_ip(request.getRemoteAddr());
			dataMasterDTO.setRg_k_seq_n( user.getDetail().getId());
	
			mapper.Insert(dataMasterDTO);
			return "redirect:datamaster_list.do";
		}else if ( "update".equals(requestParams.get("mode")) ) {
			dataMasterDTO.setMdf_ip(request.getRemoteAddr());
			dataMasterDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			mapper.Update(dataMasterDTO);
			return "redirect:datamaster_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("수집자료 마스터 정보가  존재하지 않습니다.");
		}
	}


}
