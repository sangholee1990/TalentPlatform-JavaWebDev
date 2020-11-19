package com.gaia3d.web.controller.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.access.hierarchicalroles.UserDetailsWrapper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.DataKindDTO;
import com.gaia3d.web.dto.DataKindInsideDTO;
import com.gaia3d.web.dto.DomainDTO;
import com.gaia3d.web.dto.DomainDataMappingDTO;
import com.gaia3d.web.dto.DomainLayerDTO;
import com.gaia3d.web.dto.DomainSubDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.exception.MetaInfoNotFoundException;
import com.gaia3d.web.mapper.DataKindInsideMapper;
import com.gaia3d.web.mapper.DataKindMapper;
import com.gaia3d.web.mapper.DomainDataMappingMapper;
import com.gaia3d.web.mapper.DomainLayerMapper;
import com.gaia3d.web.mapper.DomainMapper;
import com.gaia3d.web.mapper.DomainSubMapper;
import com.gaia3d.web.user.WebUser;
import com.gaia3d.web.util.Constants;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.WebUtil;

@Controller
@RequestMapping("/admin/data")
public class DataMetaController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(DataMetaController.class);
	
	/******************************************************************************
	 * 
	 * 도메인 정보
	 * 
	******************************************************************************/
	/**
	 * 도메인 정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("domain_list.do")
	public void domain_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DomainMapper mapper = sessionTemplate.getMapper(DomainMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 도메인 정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("domain_list_popup.do")
	public void domain_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DomainMapper mapper = sessionTemplate.getMapper(DomainMapper.class);
		
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 도메인 정보 등록
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("domain_form.do")
	public void domain_form(ModelMap model, 
			@RequestParam(value="view_dmn_seq_n", required=false) String dmn_seq_n ,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		DomainDTO dto = null;
		if( mode.equalsIgnoreCase("new") ) {
			dto = new DomainDTO();
			model.addAttribute("mode", "new");
		} else if(mode.equalsIgnoreCase("update") && dmn_seq_n != null) {
			DomainMapper mapper = sessionTemplate.getMapper(DomainMapper.class);
			MapperParam params = new MapperParam();
			params.put("dmn_seq_n", dmn_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("도메인 정보가  존재하지 않습니다.");
		}
		
		model.addAttribute("domainDTO", dto);
		
	}

	/**
	 * 도메인 정보 조회
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("domain_view.do")
	public void domain_view(ModelMap model, 
			@RequestParam(value="view_dmn_seq_n", required=false) String dmn_seq_n ) throws Exception {
	
		DomainMapper mapper = sessionTemplate.getMapper(DomainMapper.class);
		MapperParam params = new MapperParam();
		params.put("dmn_seq_n", dmn_seq_n);
		DomainDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new MetaInfoNotFoundException();
		}
		model.addAttribute("domainDTO", dto);
		
	}
	
	
	/**
	 * 도메인 정보 삭제
	 * @param requestParams
	 * @param sat_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("domain_del.do")
	public String domain_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_dmn_seq_n", required=false) String dmn_seq_n ) throws Exception {
	
		DomainMapper mapper = sessionTemplate.getMapper(DomainMapper.class);
		MapperParam params = new MapperParam();
		params.put("dmn_seq_n", dmn_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
	    params.put("mdf_k_seq_n", user.getDetail().getId());
	    params.put("mdf_ip", request.getRemoteAddr());
	    
		mapper.Delete(params);
		requestParams.remove("view_dmn_seq_n");
		return "redirect:domain_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 도메인 정보 등록 수정
	 * @param DomainDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="domain_submit.do", method=RequestMethod.POST)
	public String domain_submit(HttpServletRequest request,
			@ModelAttribute("DomainDTO") @Valid DomainDTO domainDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/data/domain_form";
	
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
		
		DomainMapper mapper = sessionTemplate.getMapper(DomainMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			
			domainDTO.setRg_ip(request.getRemoteAddr());
			domainDTO.setRg_k_seq_n( user.getDetail().getId());
	
			mapper.Insert(domainDTO);
			return "redirect:domain_list.do";
		}else if("update".equals(requestParams.get("mode"))) {
			domainDTO.setMdf_ip(request.getRemoteAddr());
			domainDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			mapper.Update(domainDTO);
			return "redirect:domain_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("도메인 정보가  존재하지 않습니다.");
		}
	}

	/******************************************************************************
	 * 
	 * 도메인 서브 정보
	 * 
	******************************************************************************/
	/**
	 * 도메인서브  정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("domainsub_list.do")
	public void domainsub_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DomainSubMapper mapper = sessionTemplate.getMapper(DomainSubMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 도메인 서브 정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("domainsub_list_popup.do")
	public void domainsub_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DomainSubMapper mapper = sessionTemplate.getMapper(DomainSubMapper.class);
	
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 도메인 서브 정보 등록
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("domainsub_form.do")
	public void domainsub_form(ModelMap model, 
			@RequestParam(value="view_dmn_sub_seq_n", required=false) String dmn_sub_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		DomainSubDTO dto = null;
		if( mode.equalsIgnoreCase("new") ) {
			dto = new DomainSubDTO();
			model.addAttribute("mode", "new");
		} else if( mode.equalsIgnoreCase("update") && dmn_sub_seq_n != null) {
			DomainSubMapper mapper = sessionTemplate.getMapper(DomainSubMapper.class);
			MapperParam params = new MapperParam();
			params.put("dmn_sub_seq_n", dmn_sub_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("도메인 서브 정보가  존재하지 않습니다.");
		}
		
		model.addAttribute("domainSubDTO", dto);
		
	}

	/**
	 * 도메인 서브 정보 조회
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("domainsub_view.do")
	public void domainsub_view(ModelMap model, 
			@RequestParam(value="view_dmn_sub_seq_n", required=false) String dmn_sub_seq_n ) throws Exception {
	
		DomainSubMapper mapper = sessionTemplate.getMapper(DomainSubMapper.class);
		MapperParam params = new MapperParam();
		params.put("dmn_sub_seq_n", dmn_sub_seq_n);
		DomainSubDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("도메인 서브 정보가  존재하지 않습니다.");
		}
		model.addAttribute("domainSubDTO", dto);
		
	}
	
	
	/**
	 * 도메인 서브 정보 삭제
	 * @param requestParams
	 * @param sat_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("domainsub_del.do")
	public String domainsub_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_dmn_sub_seq_n", required=false) String dmn_sub_seq_n) throws Exception {
	
		DomainSubMapper mapper = sessionTemplate.getMapper(DomainSubMapper.class);
		MapperParam params = new MapperParam();
		params.put("dmn_sub_seq_n", dmn_sub_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
	    params.put("mdf_k_seq_n", user.getDetail().getId());
	    params.put("mdf_ip", request.getRemoteAddr());
	    
		mapper.Delete(params);
		requestParams.remove("view_dmn_sub_seq_n");
		return "redirect:domainsub_list.do?" +  WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 도메인서브  정보 등록 수정
	 * @param DomainDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="domainsub_submit.do", method=RequestMethod.POST)
	public String domainsub_submit(HttpServletRequest request,
			@ModelAttribute("DomainSubDTO") @Valid DomainSubDTO domainSubDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/data/domainsub_form";
	
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
		
		
		DomainSubMapper mapper = sessionTemplate.getMapper(DomainSubMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			
			domainSubDTO.setRg_ip(request.getRemoteAddr());
			domainSubDTO.setRg_k_seq_n( user.getDetail().getId());
			
			mapper.Insert(domainSubDTO);
			return "redirect:domainsub_list.do";
		}
		else if("update".equals(requestParams.get("mode"))) {
			domainSubDTO.setMdf_ip(request.getRemoteAddr());
			domainSubDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			mapper.Update(domainSubDTO);
			return "redirect:domainsub_view.do?" +  WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("도메인 서브 정보가  존재하지 않습니다.");
		}
	}

	
	/******************************************************************************
	 * 
	 * 자료종류 정보
	 * 
	******************************************************************************/
	/**
	 * 자료종류 정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("datakind_list.do")
	public void datakind_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DataKindMapper mapper = sessionTemplate.getMapper(DataKindMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 자료종류 정보리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("datakind_list_popup.do")
	public void datakind_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DataKindMapper mapper = sessionTemplate.getMapper(DataKindMapper.class);

		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 자료종류 정보 등록
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("datakind_form.do")
	public void datakind_form(ModelMap model, 
			@RequestParam(value="view_dta_knd_seq_n", required=false) String dta_knd_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		DataKindDTO dto = null;
		if( mode.equalsIgnoreCase("new") ) {

			dto = new DataKindDTO();
			model.addAttribute("mode", "new");

		} else if( mode.equalsIgnoreCase("update") && dta_knd_seq_n != null ) {
			DataKindMapper mapper = sessionTemplate.getMapper(DataKindMapper.class);
			MapperParam params = new MapperParam();
			params.put("dta_knd_seq_n", dta_knd_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("자료종류 정보가 존재하지 않습니다.");
		}
		
		model.addAttribute("dataKindDTO", dto);
		
	}

	/**
	 * 자료종류 정보조회
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("datakind_view.do")
	public void datakind_view(ModelMap model, 
			@RequestParam(value="view_dta_knd_seq_n", required=false) String dta_knd_seq_n ) throws Exception {
	
		DataKindMapper mapper = sessionTemplate.getMapper(DataKindMapper.class);
		MapperParam params = new MapperParam();
		params.put("dta_knd_seq_n", dta_knd_seq_n);
		DataKindDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("자료종류 정보가 존재하지 않습니다.");
		}
		model.addAttribute("dataKindDTO", dto);
		
	}
	
	
	/**
	 * 자료종류 정보 삭제
	 * @param requestParams
	 * @param sat_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("datakind_del.do")
	public String datakind_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_dta_knd_seq_n", required=false) String dta_knd_seq_n) throws Exception {
	
		DataKindMapper mapper = sessionTemplate.getMapper(DataKindMapper.class);
		MapperParam params = new MapperParam();
		params.put("dta_knd_seq_n", dta_knd_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
	    params.put("mdf_k_seq_n", user.getDetail().getId());
	    params.put("mdf_ip", request.getRemoteAddr());
	    
		mapper.Delete(params);
		requestParams.remove("view_dta_knd_seq_n");
		return "redirect:datakind_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 자료종류 정보 등록 수정
	 * @param DomainDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="datakind_submit.do", method=RequestMethod.POST)
	public String datakind_submit(HttpServletRequest request,
			@ModelAttribute("dataKindDTO") @Valid DataKindDTO dataKindDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/data/datakind_form";
	
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
		
		
		DataKindMapper mapper = sessionTemplate.getMapper(DataKindMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			
			dataKindDTO.setRg_ip(request.getRemoteAddr());
			dataKindDTO.setRg_k_seq_n( user.getDetail().getId());
			
			mapper.Insert(dataKindDTO);
			return "redirect:datakind_list.do";
		}
		else if("update".equals(requestParams.get("mode"))) {
			dataKindDTO.setMdf_ip(request.getRemoteAddr());
			dataKindDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			mapper.Update(dataKindDTO);
			return "redirect:datakind_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("자료종류 정보가 존재하지 않습니다.");
		}
	}

	
	
	/******************************************************************************
	 * 
	 * 자료종류내부 정보
	 * 
	******************************************************************************/
	/**
	 * 자료종류 내부 정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("datakindinside_list.do")
	public void datakindinside_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DataKindInsideMapper mapper = sessionTemplate.getMapper(DataKindInsideMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 자료종류내부  정보리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("datakindinside_list_popup.do")
	public void datakindinside_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DataKindInsideMapper mapper = sessionTemplate.getMapper(DataKindInsideMapper.class);
		
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 자료종류내부  정보 등록
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("datakindinside_form.do")
	public void datakindinside_form(ModelMap model, 
			@RequestParam(value="view_dta_knd_inside_seq_n", required=false) String dta_knd_inside_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		DataKindInsideDTO dto = null;
		if( mode.equalsIgnoreCase("new") ) {
			dto = new DataKindInsideDTO();
			model.addAttribute("mode", "new");
		} else if( mode.equalsIgnoreCase("update") && dta_knd_inside_seq_n != null ) {
			DataKindInsideMapper mapper = sessionTemplate.getMapper(DataKindInsideMapper.class);
			MapperParam params = new MapperParam();
			params.put("dta_knd_inside_seq_n", dta_knd_inside_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("자료종류내부  정보가 존재하지 않습니다.");
		}
		
		model.addAttribute("dataKindInsideDTO", dto);
		
	}

	/**
	 * 자료종류 내부 정보조회
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("datakindinside_view.do")
	public void datakindinside_view(ModelMap model, 
			@RequestParam(value="view_dta_knd_inside_seq_n", required=false) String dta_knd_inside_seq_n ) throws Exception {
	
		DataKindInsideMapper mapper = sessionTemplate.getMapper(DataKindInsideMapper.class);
		MapperParam params = new MapperParam();
		params.put("dta_knd_inside_seq_n", dta_knd_inside_seq_n);
		DataKindInsideDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("자료종류내부  정보가 존재하지 않습니다.");
		}
		model.addAttribute("dataKindInsideDTO", dto);
		
	}
	
	
	/**
	 * 자료종류내부  정보 삭제
	 * @param requestParams
	 * @param sat_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("datakindinside_del.do")
	public String datakindinside_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_dta_knd_inside_seq_n", required=false) String dta_knd_inside_seq_n ) throws Exception {
	
		DataKindInsideMapper mapper = sessionTemplate.getMapper(DataKindInsideMapper.class);
		MapperParam params = new MapperParam();
		params.put("dta_knd_inside_seq_n", dta_knd_inside_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
	    params.put("mdf_k_seq_n", user.getDetail().getId());
	    params.put("mdf_ip", request.getRemoteAddr());
	    
		mapper.Delete(params);
		requestParams.remove("view_dta_knd_inside_seq_n");
		return "redirect:datakindinside_list.do?" +  WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 자료종류 내부 정보 등록 수정
	 * @param DomainDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="datakindinside_submit.do", method=RequestMethod.POST)
	public String datakindinside_submit(HttpServletRequest request,
			@ModelAttribute("dataKindInsideDTO") @Valid DataKindInsideDTO dataKindInsideDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams ) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/data/datakindinside_form";
	
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
		
		
		DataKindInsideMapper mapper = sessionTemplate.getMapper(DataKindInsideMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			
			dataKindInsideDTO.setRg_ip(request.getRemoteAddr());
			dataKindInsideDTO.setRg_k_seq_n( user.getDetail().getId());
			
			mapper.Insert(dataKindInsideDTO);
			return "redirect:datakindinside_list.do";

		}else if("update".equals(requestParams.get("mode"))) {
			dataKindInsideDTO.setMdf_ip(request.getRemoteAddr());
			dataKindInsideDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			mapper.Update(dataKindInsideDTO);
			return "redirect:datakindinside_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("자료종류내부  정보가 존재하지 않습니다.");
		}
	}
	
	
	/******************************************************************************
	 * 
	 * 도메인 레이어 정보
	 * 
	******************************************************************************/
	/**
	 * 도메인레이어   정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("domainlayer_list.do")
	public void domainlayer_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DomainLayerMapper mapper = sessionTemplate.getMapper(DomainLayerMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 도메인 레이어 정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("domainlayer_list_popup.do")
	public void domainlayer_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DomainLayerMapper mapper = sessionTemplate.getMapper(DomainLayerMapper.class);
		
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 도메인 레이어 정보 등록
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("domainlayer_form.do")
	public void domainlayer_form(ModelMap model, 
			@RequestParam(value="view_dmn_layer_seq_n", required=false) String dmn_layer_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		DomainLayerDTO dto = null;
		
		if( mode.equalsIgnoreCase("new") ) {
			dto = new DomainLayerDTO();
			model.addAttribute("mode", "new");
		} else if( mode.equalsIgnoreCase("update") && dmn_layer_seq_n != null) {
			DomainLayerMapper mapper = sessionTemplate.getMapper(DomainLayerMapper.class);
			MapperParam params = new MapperParam();
			params.put("dmn_layer_seq_n", dmn_layer_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("도메인 레이어 정보가 존재하지 않습니다.");
		}
		
		model.addAttribute("domainLayerDTO", dto);
		
	}

	/**
	 * 도메인 레이어  정보 조회
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("domainlayer_view.do")
	public void domainlayer_view(ModelMap model, 
			@RequestParam(value="view_dmn_layer_seq_n", required=false) String dmn_layer_seq_n ) throws Exception {
	
		DomainLayerMapper mapper = sessionTemplate.getMapper(DomainLayerMapper.class);
		MapperParam params = new MapperParam();
		params.put("dmn_layer_seq_n", dmn_layer_seq_n);
		DomainLayerDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("도메인 레이어 정보가 존재하지 않습니다.");
		}
		model.addAttribute("domainLayerDTO", dto);
		
	}
	
	
	/**
	 * 도메인 레이어  정보 삭제
	 * @param requestParams
	 * @param sat_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("domainlayer_del.do")
	public String domainlayer_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_dmn_layer_seq_n", required=false) String dmn_layer_seq_n ) throws Exception {
	
		DomainLayerMapper mapper = sessionTemplate.getMapper(DomainLayerMapper.class);
		MapperParam params = new MapperParam();
		params.put("dmn_layer_seq_n", dmn_layer_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
	    params.put("mdf_k_seq_n", user.getDetail().getId());
	    params.put("mdf_ip", request.getRemoteAddr());
	    
		mapper.Delete(params);
		requestParams.remove("dmn_layer_seq_n");
		return "redirect:domainlayer_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 도메인레이어   정보 등록 수정
	 * @param DomainDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="domainlayer_submit.do", method=RequestMethod.POST)
	public String domainlayer_submit(HttpServletRequest request,
			@ModelAttribute("domainLayerDTO") @Valid DomainLayerDTO domainLayerDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams ) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/data/domainlayer_form";
	
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
		
		
		DomainLayerMapper mapper = sessionTemplate.getMapper(DomainLayerMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			
			domainLayerDTO.setRg_ip(request.getRemoteAddr());
			domainLayerDTO.setRg_k_seq_n( user.getDetail().getId());
			
			mapper.Insert(domainLayerDTO);
			return "redirect:domainlayer_list.do";
			
		} else if("update".equals(requestParams.get("mode"))) {
			domainLayerDTO.setMdf_ip(request.getRemoteAddr());
			domainLayerDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			mapper.Update(domainLayerDTO);
			return "redirect:domainlayer_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("도메인 레이어 정보가 존재하지 않습니다.");
		}
	}

	
	

	/******************************************************************************
	 * 
	 * 도메인 레이어 자료종류 매핑 정보
	 * 
	******************************************************************************/
	/**
	 * 도메인 레이어 자료종류 매핑 정보리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("domaindatamapping_list.do")
	public void domaindatamapping_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DomainDataMappingMapper mapper = sessionTemplate.getMapper(DomainDataMappingMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}

	/**
	 * 도메인 레이어 자료종류 매핑 정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("domaindatamapping_list_popup.do")
	public void domaindatamapping_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		DomainDataMappingMapper mapper = sessionTemplate.getMapper(DomainDataMappingMapper.class);
		
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 도메인 레이어 자료종류 매핑 정보 등록
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("domaindatamapping_form.do")
	public void domaindatamapping_form(ModelMap model, 
			@RequestParam(value="view_dta_knd_inside_seq_n", required=false) String dta_knd_inside_seq_n,
			@RequestParam(value="view_dta_knd_seq_n", required=false) String dta_knd_seq_n,
			@RequestParam(value="view_dmn_sub_seq_n", required=false) String dmn_sub_seq_n,
			@RequestParam(value="view_dmn_seq_n", required=false) String dmn_seq_n,
			@RequestParam(value="view_dmn_layer_seq_n", required=false) String dmn_layer_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		DomainDataMappingDTO dto = null;
		if( mode.equalsIgnoreCase("new")) {
			dto = new DomainDataMappingDTO();
			model.addAttribute("mode", "new");
		}else if(mode.equalsIgnoreCase("update") 
				&& dta_knd_inside_seq_n != null 
				&& dta_knd_seq_n != null  
				&& dmn_sub_seq_n != null  
				&& dmn_seq_n != null  
				&& dmn_layer_seq_n != null  
				) {
			DomainDataMappingMapper mapper = sessionTemplate.getMapper(DomainDataMappingMapper.class);
			MapperParam params = new MapperParam();
			params.put("dta_knd_inside_seq_n", dta_knd_inside_seq_n);
			params.put("dta_knd_seq_n", dta_knd_seq_n);
			params.put("dmn_sub_seq_n", dmn_sub_seq_n);
			params.put("dmn_seq_n", dmn_seq_n);
			params.put("dmn_layer_seq_n", dmn_layer_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("도메인 레이어 자료종류 매핑 정보가 존재하지 않습니다.");
		}
		
		model.addAttribute("domainDataMappingDTO", dto);
		
	}

	/**
	 * 도메인 레이어 자료종류 매핑 정보 조회
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("domaindatamapping_view.do")
	public void domaindatamapping_view(ModelMap model, 
			@RequestParam(value="view_dta_knd_inside_seq_n", required=false) String dta_knd_inside_seq_n,
			@RequestParam(value="view_dta_knd_seq_n", required=false) String dta_knd_seq_n,
			@RequestParam(value="view_dmn_sub_seq_n", required=false) String dmn_sub_seq_n,
			@RequestParam(value="view_dmn_seq_n", required=false) String dmn_seq_n,
			@RequestParam(value="view_dmn_layer_seq_n", required=false) String dmn_layer_seq_n) throws Exception {
	
		DomainDataMappingMapper mapper = sessionTemplate.getMapper(DomainDataMappingMapper.class);
		MapperParam params = new MapperParam();
		params.put("dta_knd_inside_seq_n", dta_knd_inside_seq_n);
		params.put("dta_knd_seq_n", dta_knd_seq_n);
		params.put("dmn_sub_seq_n", dmn_sub_seq_n);
		params.put("dmn_seq_n", dmn_seq_n);
		params.put("dmn_layer_seq_n", dmn_layer_seq_n);
		DomainDataMappingDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("도메인 레이어 자료종류 매핑 정보가 존재하지 않습니다.");
		}
		model.addAttribute("domainDataMappingDTO", dto);
		
	}
	
	
	/**
	 * 도메인 레이어 자료종류 매핑 정보 삭제
	 * @param requestParams
	 * @param sat_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("domaindatamapping_del.do")
	public String domaindatamapping_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_dta_knd_inside_seq_n", required=false) String dta_knd_inside_seq_n,
			@RequestParam(value="view_dta_knd_seq_n", required=false) String dta_knd_seq_n,
			@RequestParam(value="view_dmn_sub_seq_n", required=false) String dmn_sub_seq_n,
			@RequestParam(value="view_dmn_seq_n", required=false) String dmn_seq_n,
			@RequestParam(value="view_dmn_layer_seq_n", required=false) String dmn_layer_seq_n) throws Exception {
	
		DomainDataMappingMapper mapper = sessionTemplate.getMapper(DomainDataMappingMapper.class);
		MapperParam params = new MapperParam();
		params.put("dta_knd_inside_seq_n", dta_knd_inside_seq_n);
		params.put("dta_knd_seq_n", dta_knd_seq_n);
		params.put("dmn_sub_seq_n", dmn_sub_seq_n);
		params.put("dmn_seq_n", dmn_seq_n);
		params.put("dmn_layer_seq_n", dmn_layer_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
	    params.put("mdf_k_seq_n", user.getDetail().getId());
	    params.put("mdf_ip", request.getRemoteAddr());
		mapper.Delete(params);
		
		
		requestParams.remove("view_dta_knd_inside_seq_n");
		requestParams.remove("view_dta_knd_seq_n");
		requestParams.remove("view_dmn_sub_seq_n");
		requestParams.remove("view_dmn_seq_n");
		requestParams.remove("view_dmn_layer_seq_n");
		
		return "redirect:domaindatamapping_list.do?" +  WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 도메인 레이어 자료종류 매핑 정보등록 수정
	 * @param DomainDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="domaindatamapping_submit.do", method=RequestMethod.POST)
	public String domaindatamapping_submit(HttpServletRequest request,
			ModelMap model,
			@ModelAttribute("domainDataMappingDTO") @Valid DomainDataMappingDTO domainDataMappingDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/data/domaindatamapping_form";

		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
		
		
		DomainDataMappingMapper mapper = sessionTemplate.getMapper(DomainDataMappingMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			
			domainDataMappingDTO.setRg_ip(request.getRemoteAddr());
			domainDataMappingDTO.setRg_k_seq_n( user.getDetail().getId());
			
			
			String[] multiDomainLayer = request.getParameterValues("multi_dmn_layer_seq_n");
			
			if ( multiDomainLayer.length > 0 ) {
				logger.debug("------------------------->" + multiDomainLayer[0]);
			
					try{
						for( String layerSeq : multiDomainLayer){
							
							domainDataMappingDTO.setDmn_layer_seq_n( Integer.parseInt(layerSeq) ); 
							mapper.Insert(domainDataMappingDTO);
						}
					
					}catch(DuplicateKeyException e){
						ObjectError error = new ObjectError("error","도메인 레이어 자료종류 매핑 정보 에러입니다.");
						bindingResult.addError(error);
						
						model.addAttribute("domainDataMappingDTO", domainDataMappingDTO);
						model.addAttribute("mode", "new");	
						return "admin/data/domaindatamapping_form";
					}catch(Exception e2){
						logger.debug("ERROR");
					}
				
			}else{
				
				//logger.debug("no layer ");
				ObjectError error = new ObjectError("error","도메인 레이어 자료종류 매핑 정보 에러입니다.");
				bindingResult.addError(error);
				
				model.addAttribute("domainDataMappingDTO", domainDataMappingDTO);
				model.addAttribute("mode", "new");	
				return "admin/data/domaindatamapping_form";
			}
			
			return "redirect:domaindatamapping_list.do";
		}else if("update".equals(requestParams.get("mode"))) {
			domainDataMappingDTO.setMdf_ip(request.getRemoteAddr());
			domainDataMappingDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			try{
				mapper.Update(domainDataMappingDTO);
				
			}catch(DuplicateKeyException e){
				ObjectError error = new ObjectError("error","도메인 레이어 자료종류 매핑 정보 에러입니다.");
				bindingResult.addError(error);
				
				model.addAttribute("domainDataMappingDTO", domainDataMappingDTO);
				model.addAttribute("mode", "update");	
				return "admin/data/domaindatamapping_form";
			}
		
			return "redirect:domaindatamapping_list.do?" + WebUtil.getQueryStringForMap(requestParams);
			
		}else{
			throw new Exception("도메인 레이어 자료종류 매핑 정보가 존재하지 않습니다.");
		}
	}
	
	
	/**
	 * 도메인 레이어 자료종류 매핑 정보 중복 체크
	 * @param checkDTO
	 * @return
	 */
	@RequestMapping(value = "domaindatamapping_mapping_check_ajax.do" , method = RequestMethod.POST)
	public @ResponseBody DomainDataMappingDTO domaindatamapping_mapping_check_ajax(@RequestBody DomainDataMappingDTO checkDTO) {

		DomainDataMappingDTO dto = null; 
		DataKindInsideMapper dataKindInsideMapper = sessionTemplate.getMapper(DataKindInsideMapper.class);
		DataKindInsideDTO dataKindInsideDTO = null;
		
		MapperParam params = new MapperParam();
		params.put("dta_knd_inside_seq_n", checkDTO.getDta_knd_inside_seq_n());
		dataKindInsideDTO = dataKindInsideMapper.SelectOne(params);
	
		//자료종류 내부 정보 조회 실패
		if ( dataKindInsideDTO == null ){
			return dto;
		}

		checkDTO.setDmn_seq_n(dataKindInsideDTO.getDmn_seq_n());
		checkDTO.setDmn_sub_seq_n(dataKindInsideDTO.getDmn_sub_seq_n() );
		checkDTO.setDta_knd_seq_n(dataKindInsideDTO.getDta_knd_seq_n() );

		if(  checkDTO.getDta_knd_inside_seq_n() != null 
				&& checkDTO.getDta_knd_seq_n() != null  
				&& checkDTO.getDmn_sub_seq_n() != null  
				&& checkDTO.getDmn_seq_n() != null  
				&& checkDTO.getDmn_layer_seq_n() != null  
		) {
			DomainDataMappingMapper mapper = sessionTemplate.getMapper(DomainDataMappingMapper.class);
			dto= mapper.SelectOne(checkDTO); 
		}

	   return dto;
	}
	
	
}
