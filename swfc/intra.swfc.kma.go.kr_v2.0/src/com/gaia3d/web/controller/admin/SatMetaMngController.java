package com.gaia3d.web.controller.admin;

import java.io.UnsupportedEncodingException;
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
import com.gaia3d.web.dto.BandDTO;
import com.gaia3d.web.dto.BandGroupDTO;
import com.gaia3d.web.dto.CoverageCDTDTO;
import com.gaia3d.web.dto.CoverageDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.dto.SatDTO;
import com.gaia3d.web.dto.SatGroupDTO;
import com.gaia3d.web.dto.SatSensorMPDTO;
import com.gaia3d.web.dto.SchdDTO;
import com.gaia3d.web.dto.SensorBandDTO;
import com.gaia3d.web.dto.SensorDTO;
import com.gaia3d.web.exception.MetaInfoNotFoundException;
import com.gaia3d.web.mapper.BandGroupMapper;
import com.gaia3d.web.mapper.BandMapper;
import com.gaia3d.web.mapper.CoverageCDTMapper;
import com.gaia3d.web.mapper.CoverageMapper;
import com.gaia3d.web.mapper.SatGroupMapper;
import com.gaia3d.web.mapper.SatMapper;
import com.gaia3d.web.mapper.SatSensorMPMapper;
import com.gaia3d.web.mapper.SchdMapper;
import com.gaia3d.web.mapper.SensorBandMapper;
import com.gaia3d.web.mapper.SensorMapper;
import com.gaia3d.web.user.WebUser;
import com.gaia3d.web.util.Constants;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.WebUtil;

/**
 * 수집대상 메타정보 관리 
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/meta")
public class SatMetaMngController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(SatMetaMngController.class);

	
	/******************************************************************************
	 * 
	 * 수집대상그룹  관리  
	 * 
	******************************************************************************/
	/**
	 * 수집대상 그룹 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("sat_grp_list.do")
	public void sat_grp_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		SatGroupMapper mapper = sessionTemplate.getMapper(SatGroupMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 수집대상 그룹 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("sat_grp_list_popup.do")
	public void sat_grp_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		SatGroupMapper mapper = sessionTemplate.getMapper(SatGroupMapper.class);
	
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 수집대상 그룹 등록
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sat_grp_form.do")
	public void sat_grp_form(ModelMap model, 
			@RequestParam(value="view_clt_tar_grp_seq_n", required=false) String clt_tar_grp_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		SatGroupDTO dto = null;
		if( mode.equalsIgnoreCase("new") ) {
			dto = new SatGroupDTO();
			model.addAttribute("mode", "new");
		} else if(mode.equalsIgnoreCase("update") && clt_tar_grp_seq_n != null) {
			SatGroupMapper mapper = sessionTemplate.getMapper(SatGroupMapper.class);
			MapperParam params = new MapperParam();
			params.put("clt_tar_grp_seq_n", clt_tar_grp_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("수집대상 그룹이  존재하지 않습니다.");
		}
		
		model.addAttribute("satGroupDTO", dto);
		
	}

	/**
	 * 수집대상그룹 조회
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sat_grp_view.do")
	public void sat_grp_view(ModelMap model, 
			@RequestParam(value="view_clt_tar_grp_seq_n", required=false) String clt_tar_grp_seq_n ) throws Exception {
	
		SatGroupMapper mapper = sessionTemplate.getMapper(SatGroupMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_grp_seq_n", clt_tar_grp_seq_n);
		SatGroupDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("수집대상 그룹이  존재하지 않습니다.");
		}
		model.addAttribute("satGroupDTO", dto);
		
	}
	
	
	/**
	 * 수집대상그룹 삭제
	 * @param requestParams
	 * @param sat_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("sat_grp_del.do")
	public String sat_grp_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_clt_tar_grp_seq_n", required=false) String clt_tar_grp_seq_n) throws Exception {
	
		SatGroupMapper mapper = sessionTemplate.getMapper(SatGroupMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_grp_seq_n", clt_tar_grp_seq_n);

//		RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
	    params.put("mdf_k_seq_n", user.getDetail().getId());
	    params.put("mdf_ip", request.getRemoteAddr());
	    


		mapper.Delete(params);
		requestParams.remove("clt_tar_grp_seq_n");
		return "redirect:sat_grp_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 수집대상 그룹 등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="sat_grp_submit.do", method=RequestMethod.POST)
	public String sat_grp_submit(HttpServletRequest request,
			@ModelAttribute("satGroupDTO") @Valid SatGroupDTO satGroupDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/sat_grp_form";
	
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
		
		
		SatGroupMapper mapper = sessionTemplate.getMapper(SatGroupMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			satGroupDTO.setRg_ip(request.getRemoteAddr());
			satGroupDTO.setRg_k_seq_n( user.getDetail().getId());
	
			mapper.Insert(satGroupDTO);
			return "redirect:sat_grp_list.do";
		}
		else if("update".equals(requestParams.get("mode"))) {
			satGroupDTO.setMdf_ip(request.getRemoteAddr());
			satGroupDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			mapper.Update(satGroupDTO);
			return "redirect:sat_grp_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("수집대상 그룹 정보가 없습니다.");
		}
	}
		

	/******************************************************************************
	 * 
	 * 수집대상정보 관리  
	 * 
	 ******************************************************************************/

	/**
	 * 수집대상 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("sat_list.do")
	public void sat_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		SatMapper mapper = sessionTemplate.getMapper(SatMapper.class);

		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 수집대상 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("sat_list_popup.do")
	public void sat_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		SatMapper mapper = sessionTemplate.getMapper(SatMapper.class);

		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 수집대상  등록
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sat_form.do")
	public void sat_form(ModelMap model, 
			@RequestParam(value="view_clt_tar_seq_n", required=false) String clt_tar_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
	
		SatDTO dto = null;

		if(mode.equalsIgnoreCase("new" )) {
			dto = new SatDTO();
			model.addAttribute("mode", mode);

		} else if(mode.equalsIgnoreCase("update" ) 
					&& clt_tar_seq_n != null 
					&& clt_tar_seq_n != "") {

			SatMapper mapper = sessionTemplate.getMapper(SatMapper.class);
			MapperParam params = new MapperParam();
			params.put("clt_tar_seq_n", clt_tar_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", mode);
		}
		
		if(dto == null) {
			throw new Exception("수집 대상이  존재하지 않습니다.");
		}
		
		model.addAttribute("satDTO", dto);
		
	}

	/**
	 * 수집대상 조회
	 * @param model
	 * @param sat_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sat_view.do")
	public void sat_view(ModelMap model, 
			@RequestParam(value="view_clt_tar_seq_n", required=false) String clt_tar_seq_n ) throws Exception {
	
		SatMapper mapper = sessionTemplate.getMapper(SatMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_seq_n", clt_tar_seq_n);
		SatDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new MetaInfoNotFoundException();
		}
		model.addAttribute("satDTO", dto);
		
		SchdMapper mapper2 = sessionTemplate.getMapper(SchdMapper.class);
		params.put("startRow", 1);
		params.put("endRow", 1000);
		params.put("search_del", "N");
		
		model.addAttribute("list", mapper2.SelectMany(params));
		
	}
	
	
	/**
	 * 수집대상 삭제
	 * @param requestParams
	 * @param sat_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("sat_del.do")
	public String sat_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_clt_tar_seq_n", required=false) String clt_tar_seq_n ) throws Exception {
	
		SatMapper mapper = sessionTemplate.getMapper(SatMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_seq_n", clt_tar_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		params.put("mdf_k_seq_n", user.getDetail().getId());
		params.put("mdf_ip", request.getRemoteAddr());
    
		mapper.Delete(params);
		return "redirect:sat_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 수집대상  등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="sat_submit.do", method=RequestMethod.POST)
	public String sat_submit(HttpServletRequest request,
			@ModelAttribute("satDTO") @Valid SatDTO satDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams ) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/sat_form";
	
	  	@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 

		SatMapper mapper = sessionTemplate.getMapper(SatMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			satDTO.setRg_ip(request.getRemoteAddr());
			satDTO.setRg_k_seq_n( user.getDetail().getId());
			mapper.Insert(satDTO);
			return "redirect:sat_list.do";
		}
		else if("update".equals(requestParams.get("mode"))) {
			satDTO.setMdf_ip(request.getRemoteAddr());
			satDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			mapper.Update(satDTO);
			return "redirect:sat_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("수집대상 정보가 없습니다.");
		}
	
	}
		
	/******************************************************************************
	 * 
	 * 수집대상 수신 스케쥴 관리  
	 * 
	 ******************************************************************************/

	/**
	 * 수집대상 스케쥴 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("sat_schd_list.do")
	public void sat_schd_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		SchdMapper mapper = sessionTemplate.getMapper(SchdMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	
	/**
	 * 수집대상 스케쥴  등록
	 * @param model
	 * @param schd_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sat_schd_form.do")
	public void sat_schd_form(ModelMap model, 
			@RequestParam(value="view_clt_tar_sch_seq_n", required=false) String clt_tar_sch_seq_n,
			@RequestParam(value="view_clt_tar_seq_n", required=false) Integer clt_tar_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		SchdDTO dto = null;
		if( "new".equals(mode) ) {
			dto = new SchdDTO();
			dto.setClt_tar_seq_n(clt_tar_seq_n);
			model.addAttribute("mode", "new");
		} else if( "update".equals( mode ) && clt_tar_sch_seq_n != null && clt_tar_seq_n != null ) {
			SchdMapper mapper = sessionTemplate.getMapper(SchdMapper.class);
			MapperParam params = new MapperParam();
			params.put("clt_tar_sch_seq_n", clt_tar_sch_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("스케쥴이  존재하지 않습니다.");
		}
		model.addAttribute("schdDTO", dto);
	}

	/**
	 * 수집대상 스케쥴 조회
	 * @param model
	 * @param schd_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sat_schd_view.do")
	public void sat_schd_view(ModelMap model, 
			@RequestParam(value="view_clt_tar_sch_seq_n", required=false) String clt_tar_sch_seq_n ) throws Exception {
	
		SchdMapper mapper = sessionTemplate.getMapper(SchdMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_sch_seq_n", clt_tar_sch_seq_n);
		SchdDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new MetaInfoNotFoundException();
		}
		model.addAttribute("schdDTO", dto);
		
	}
	
	
	/**
	 * 수집대상 스케쥴 삭제
	 * @param requestParams
	 * @param schd_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("sat_schd_del.do")
	public String sat_schd_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_clt_tar_sch_seq_n", required=false) String clt_tar_sch_seq_n ) throws Exception {
	
		SchdMapper mapper = sessionTemplate.getMapper(SchdMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_sch_seq_n", clt_tar_sch_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		params.put("mdf_k_seq_n", user.getDetail().getId());
		params.put("mdf_ip", request.getRemoteAddr());
    
		mapper.Delete(params);
		requestParams.remove("clt_tar_sch_seq_n");
		return "redirect:sat_view.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 수집대상 스케쥴 등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping(value="sat_schd_submit.do", method=RequestMethod.POST )
	public String sat_schd_submit(HttpServletRequest request,
			@ModelAttribute("schdDTO") @Valid SchdDTO schdDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/sat_schd_form";
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 

		
		SchdMapper mapper = sessionTemplate.getMapper(SchdMapper.class);
		if("new".equals(requestParams.get("mode"))) {

			schdDTO.setRg_ip(request.getRemoteAddr());
			schdDTO.setRg_k_seq_n( user.getDetail().getId());
			mapper.Insert(schdDTO);
			return "redirect:sat_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}
		else if("update".equals(requestParams.get("mode"))) {
			schdDTO.setMdf_ip(request.getRemoteAddr());
			schdDTO.setMdf_k_seq_n( user.getDetail().getId() );
			
			mapper.Update(schdDTO);

			return "redirect:sat_schd_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("수집대상 스케줄 정보가 없습니다.");
		}
	}
	
	
	
	/******************************************************************************
	 * 
	 * 센서 정보  관리  
	 * 
	 ******************************************************************************/

	/**
	 * 센서 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("sensor_list.do")
	public void sensor_list(ModelMap model,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		SensorMapper mapper = sessionTemplate.getMapper(SensorMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 센서 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("sensor_list_popup.do")
	public void sensor_list_popup(ModelMap model,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		SensorMapper mapper = sessionTemplate.getMapper(SensorMapper.class);
		
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		
		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}
	
	
	/**
	 * 센서  등록
	 * @param model
	 * @param sensor_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sensor_form.do")
	public void sensor_form(ModelMap model, 
			@RequestParam(value="view_clt_tar_sensor_seq_n", required=false) String clt_tar_sensor_seq_n ,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		SensorDTO dto = null;
		if(mode.equalsIgnoreCase("new") ) {
			dto = new SensorDTO();
			model.addAttribute("mode", "new");
		} else if(mode.equalsIgnoreCase("update") && clt_tar_sensor_seq_n != null) {
			SensorMapper mapper = sessionTemplate.getMapper(SensorMapper.class);
			MapperParam params = new MapperParam();
			params.put("clt_tar_sensor_seq_n", clt_tar_sensor_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("센서정보가  존재하지 않습니다.");
		}
		
		model.addAttribute("sensorDTO", dto);
		
	}

	/**
	 * 센서 조회
	 * @param model
	 * @param sensor_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sensor_view.do")
	public void sensor_view(ModelMap model, 
			@RequestParam(value="view_clt_tar_sensor_seq_n", required=false) String clt_tar_sensor_seq_n ) throws Exception {
	
		SensorMapper mapper = sessionTemplate.getMapper(SensorMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_sensor_seq_n", clt_tar_sensor_seq_n);
		SensorDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("센서정보가  존재하지 않습니다.");
		}
		model.addAttribute("sensorDTO", dto);
		
	}
	
	
	/**
	 * 센서삭제
	 * @param requestParams
	 * @param sensor_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("sensor_del.do")
	public String sensor_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_clt_tar_sensor_seq_n", required=false) String clt_tar_sensor_seq_n ) throws Exception {
	
		SensorMapper mapper = sessionTemplate.getMapper(SensorMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_sensor_seq_n", clt_tar_sensor_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		params.put("mdf_k_seq_n", user.getDetail().getId());
		params.put("mdf_ip", request.getRemoteAddr());
    
		mapper.Delete(params);
		requestParams.remove("view_clt_tar_sensor_seq_n");
		return "redirect:sensor_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 센서 등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="sensor_submit.do", method=RequestMethod.POST)
	public String sensor_submit(HttpServletRequest request,
			@ModelAttribute("sensorDTO") @Valid SensorDTO sensorDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/sensor_form";
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
		
		SensorMapper mapper = sessionTemplate.getMapper(SensorMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			sensorDTO.setRg_ip(request.getRemoteAddr());
			sensorDTO.setRg_k_seq_n( user.getDetail().getId());
			mapper.Insert(sensorDTO);
			return "redirect:sensor_list.do";
		}
		else if("update".equals(requestParams.get("mode"))) { 
			sensorDTO.setMdf_ip(request.getRemoteAddr());
			sensorDTO.setMdf_k_seq_n( user.getDetail().getId() );
			mapper.Update(sensorDTO);
			return "redirect:sensor_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("센서정보가  존재하지 않습니다.");
		}
	
	}
	
	
	
	/******************************************************************************
	 * 
	 * 밴드 정보  관리  
	 * 
	 ******************************************************************************/
	
	/**
	 * 밴드리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("band_list.do")
	public void band_list(ModelMap model,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		BandMapper mapper = sessionTemplate.getMapper(BandMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 밴드리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("band_list_popup.do")
	public void band_list_popup(ModelMap model,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		BandMapper mapper = sessionTemplate.getMapper(BandMapper.class);
		
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	
	/**
	 * 밴드 등록
	 * @param model
	 * @param band_group_seq
	 * @throws Exception
	 */
	@RequestMapping("band_form.do")
	public void band_form(ModelMap model, 
			@RequestParam(value="view_clt_tar_band_seq_n", required=false) String clt_tar_band_seq_n,
			@RequestParam(value="mode", required=false) String mode  ) throws Exception {
	
		BandDTO dto = null;
		if( mode.equalsIgnoreCase("new") ) {
			dto = new BandDTO();
			model.addAttribute("mode", "new");
		} else if( mode.equalsIgnoreCase("update")  && clt_tar_band_seq_n != null) {
			BandMapper mapper = sessionTemplate.getMapper(BandMapper.class);
			MapperParam params = new MapperParam();
			params.put("clt_tar_band_seq_n", clt_tar_band_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("수집대상 밴드정보가  존재하지 않습니다.");
		}
		
		model.addAttribute("bandDTO", dto);
		
	}

	/**
	 * 밴드조회
	 * @param model
	 * @param band_group_seq
	 * @throws Exception
	 */
	@RequestMapping("band_view.do")
	public void band_view(ModelMap model, 
			@RequestParam(value="view_clt_tar_band_seq_n", required=false) String clt_tar_band_seq_n ) throws Exception {
	
		BandMapper mapper = sessionTemplate.getMapper(BandMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_band_seq_n", clt_tar_band_seq_n);
		BandDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("수집대상 밴드정보가  존재하지 않습니다.");
		}
		model.addAttribute("bandDTO", dto);
		
	}
	
	
	/**
	 * 밴드 삭제
	 * @param requestParams
	 * @param band_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("band_del.do")
	public String band_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_clt_tar_band_seq_n", required=false) String clt_tar_band_seq_n ) throws Exception {
	
		BandMapper mapper = sessionTemplate.getMapper(BandMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_band_seq_n", clt_tar_band_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		params.put("mdf_k_seq_n", user.getDetail().getId());
		params.put("mdf_ip", request.getRemoteAddr());
    
		mapper.Delete(params);
		requestParams.remove("view_clt_tar_band_seq_n");
		return "redirect:band_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 밴드등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="band_submit.do", method=RequestMethod.POST)
	public String band_submit(HttpServletRequest request,
			@ModelAttribute("bandDTO") @Valid BandDTO bandDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/band_form";
		
	  	@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 

		BandMapper mapper = sessionTemplate.getMapper(BandMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			bandDTO.setRg_ip(request.getRemoteAddr());
			bandDTO.setRg_k_seq_n( user.getDetail().getId());
			mapper.Insert(bandDTO);
			return "redirect:band_list.do";
		}
		else if("update".equals(requestParams.get("mode"))) {

			bandDTO.setMdf_ip(request.getRemoteAddr());
			bandDTO.setMdf_k_seq_n( user.getDetail().getId() );
			mapper.Update(bandDTO);
			return "redirect:band_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("수집대상 밴드정보가  존재하지 않습니다.");
		}
	
	}

	/******************************************************************************
	 * 
	 * 밴드 그룹 정보  관리  
	 * 
	 ******************************************************************************/
	/**
	 * 밴드 그룹리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("band_grp_list.do")
	public void band_grp_list(ModelMap model,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		BandGroupMapper mapper = sessionTemplate.getMapper(BandGroupMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 밴드 그룹리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("band_grp_list_popup.do")
	public void band_grp_list_popup(ModelMap model,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		BandGroupMapper mapper = sessionTemplate.getMapper(BandGroupMapper.class);

		
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	
	/**
	 * 밴드 그룹 등록
	 * @param model
	 * @param band_grp_group_seq
	 * @throws Exception
	 */
	@RequestMapping("band_grp_form.do")
	public void band_grp_form(ModelMap model, 
			@RequestParam(value="view_clt_tar_band_grp_seq_n", required=false) String clt_tar_band_grp_seq_n ,
			@RequestParam(value="mode", required=false) String mode) throws Exception {
	
		BandGroupDTO dto = null;
		if( mode.equalsIgnoreCase("new") ) {
			dto = new BandGroupDTO();
			model.addAttribute("mode", "new");
		} else if(mode.equalsIgnoreCase("update")  && clt_tar_band_grp_seq_n != null) {
			BandGroupMapper mapper = sessionTemplate.getMapper(BandGroupMapper.class);
			MapperParam params = new MapperParam();
			params.put("clt_tar_band_grp_seq_n", clt_tar_band_grp_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("수집대상 밴드그룹이  존재하지 않습니다.");
		}
		
		model.addAttribute("bandGroupDTO", dto);
		
	}

	/**
	 * 밴드 그룹조회
	 * @param model
	 * @param band_grp_group_seq
	 * @throws Exception
	 */
	@RequestMapping("band_grp_view.do")
	public void band_grp_view(ModelMap model, 
			@RequestParam(value="view_clt_tar_band_grp_seq_n", required=false) String clt_tar_band_grp_seq_n ) throws Exception {
	
		BandGroupMapper mapper = sessionTemplate.getMapper(BandGroupMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_band_grp_seq_n", clt_tar_band_grp_seq_n);
		BandGroupDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("수집대상 밴드그룹이  존재하지 않습니다.");
		}
		model.addAttribute("bandGroupDTO", dto);
		
	}
	
	
	/**
	 * 밴드 그룹 삭제
	 * @param requestParams
	 * @param band_grp_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("band_grp_del.do")
	public String band_grp_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_clt_tar_band_grp_seq_n", required=false) String clt_tar_band_grp_seq_n ) throws Exception {
	
		BandGroupMapper mapper = sessionTemplate.getMapper(BandGroupMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_band_grp_seq_n", clt_tar_band_grp_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		params.put("mdf_k_seq_n", user.getDetail().getId());
		params.put("mdf_ip", request.getRemoteAddr());
    
		mapper.Delete(params);
		requestParams.remove("clt_tar_band_grp_seq_n");
		return "redirect:band_grp_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 밴드 그룹등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="band_grp_submit.do", method=RequestMethod.POST)
	public String band_grp_submit(HttpServletRequest request,
			@ModelAttribute("bandGroupDTO") @Valid BandGroupDTO bandGroupDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/band_grp_form";
		
	  	@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 
	  	
		BandGroupMapper mapper = sessionTemplate.getMapper(BandGroupMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			
			bandGroupDTO.setRg_ip(request.getRemoteAddr());
			bandGroupDTO.setRg_k_seq_n( user.getDetail().getId());
			
			mapper.Insert(bandGroupDTO);
			return "redirect:band_grp_list.do";
		}
		else if("update".equals(requestParams.get("mode"))) {

			bandGroupDTO.setMdf_ip(request.getRemoteAddr());
			bandGroupDTO.setMdf_k_seq_n( user.getDetail().getId() );
			mapper.Update(bandGroupDTO);
			return "redirect:band_grp_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("수집대상 밴드그룹이  존재하지 않습니다.");
		}
	}
	
	/******************************************************************************
	 * 
	 * 수집대상 센서  매핑 정보  관리  
	 * 
	 ******************************************************************************/
	/**
	 * 수집대상 센서 매핑 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("satsensor_mapping_list.do")
	public void satsensor_mapping_list(ModelMap model,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		SatSensorMPMapper mapper = sessionTemplate.getMapper(SatSensorMPMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	/**
	 * 수집대상 센서  매핑  등록
	 * @param model
	 * @param sat_sensor_mapping_group_seq
	 * @throws Exception
	 */
	@RequestMapping("satsensor_mapping_form.do")
	public void satsensor_mapping_form(ModelMap model, 
			@RequestParam(value="view_clt_tar_sensor_seq_n", required=false) String clt_tar_sensor_seq_n,
			@RequestParam(value="view_clt_tar_seq_n", required=false) String clt_tar_seq_n ,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
		
		SatSensorMPDTO dto = null;
		if(mode.equalsIgnoreCase("new")) {
			dto = new SatSensorMPDTO();
			model.addAttribute("mode", "new");
		} else if( mode.equalsIgnoreCase("update") && clt_tar_sensor_seq_n != null || clt_tar_seq_n != null) {
			dto = new SatSensorMPDTO();
			SatSensorMPMapper mapper = sessionTemplate.getMapper(SatSensorMPMapper.class);
			MapperParam params = new MapperParam();
			
			params.put("clt_tar_seq_n", clt_tar_seq_n);
			params.put("clt_tar_sensor_seq_n", clt_tar_sensor_seq_n);
			
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("수집대상 센서  매핑 정보가 존재하지 않습니다.");
		}
		
		model.addAttribute("satSensorMPDTO", dto);
	}

	/**
	 * 수집대상 센서  매핑 조회
	 * @param model
	 * @param sat_sensor_mapping_group_seq
	 * @throws Exception
	 */
	@RequestMapping("satsensor_mapping_view.do")
	public void satsensor_mapping_view(ModelMap model, 
			@RequestParam(value="view_clt_tar_sensor_seq_n", required=false) String clt_tar_sensor_seq_n,
			@RequestParam(value="view_clt_tar_seq_n", required=false) String clt_tar_seq_n  ) throws Exception {
	
		SatSensorMPMapper mapper = sessionTemplate.getMapper(SatSensorMPMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_seq_n", clt_tar_seq_n);
		params.put("clt_tar_sensor_seq_n", clt_tar_sensor_seq_n);
		SatSensorMPDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("수집대상 센서  매핑 정보가 존재하지 않습니다.");
		}
		model.addAttribute("satSensorMPDTO", dto);
		
	}
	
	
	/**
	 * 수집대상 센서  매핑 삭제
	 * @param requestParams
	 * @param sat_sensor_mapping_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("satsensor_mapping_del.do")
	public String satsensor_mapping_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_clt_tar_sensor_seq_n", required=false) String clt_tar_sensor_seq_n,
			@RequestParam(value="view_clt_tar_seq_n", required=false) String clt_tar_seq_n  ) throws Exception {
	
		SatSensorMPMapper mapper = sessionTemplate.getMapper(SatSensorMPMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_seq_n", clt_tar_seq_n);
		params.put("clt_tar_sensor_seq_n", clt_tar_sensor_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		params.put("mdf_k_seq_n", user.getDetail().getId());
		params.put("mdf_ip", request.getRemoteAddr());
    
		mapper.Delete(params);
		requestParams.remove("view_clt_tar_sensor_seq_n");
		requestParams.remove("view_clt_tar_seq_n");
		return "redirect:satsensor_mapping_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 수집대상 센서  매핑 등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="satsensor_mapping_submit.do", method=RequestMethod.POST)
	public String satsensor_mapping_submit(HttpServletRequest request,
			ModelMap model, 
			@ModelAttribute("satSensorMPDTO") @Valid SatSensorMPDTO satSensorMPDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/satsensor_mapping_form";

	  	@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 

		SatSensorMPMapper mapper = sessionTemplate.getMapper(SatSensorMPMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			
			satSensorMPDTO.setRg_ip(request.getRemoteAddr());
			satSensorMPDTO.setRg_k_seq_n( user.getDetail().getId());
			try{
				mapper.Insert(satSensorMPDTO);
			}catch(DuplicateKeyException e){
				ObjectError error = new ObjectError("error","수집대상 센서 매핑 정보 중복 에러입니다.");
				bindingResult.addError(error);
				
				model.addAttribute("satSensorMPDTO", satSensorMPDTO);
				model.addAttribute("clt_tar_sensor_seq_n_old", requestParams.get("clt_tar_sensor_seq_n_old"));
				model.addAttribute("clt_tar_seq_n_old", requestParams.get("clt_tar_seq_n_old") );
				model.addAttribute("mode", "new");	
				return "adminmetamng/satsensor_mapping_form";
			}
			
			return "redirect:satsensor_mapping_list.do";
		}
		else if("update".equals(requestParams.get("mode"))) {
			MapperParam params = new MapperParam();
			params.put("clt_tar_seq_n", requestParams.get("clt_tar_seq_n") );
			params.put("clt_tar_sensor_seq_n", requestParams.get("clt_tar_sensor_seq_n"));
			params.put("view_clt_tar_seq_n", requestParams.get("view_clt_tar_seq_n") );
			params.put("view_clt_tar_sensor_seq_n", requestParams.get("view_clt_tar_sensor_seq_n") );
			params.put("use_f_cd", requestParams.get("use_f_cd") );
			try{
			    params.put("mdf_k_seq_n", user.getDetail().getId());
			    params.put("mdf_ip", request.getRemoteAddr());
			    
				mapper.Delete(params);
			}catch(DuplicateKeyException e){
				ObjectError error = new ObjectError("error","수집대상 센서 매핑 정보 중복 에러입니다.");
				bindingResult.addError(error);
				
				model.addAttribute("satSensorMPDTO", satSensorMPDTO);
				model.addAttribute("clt_tar_sensor_seq_n_old", requestParams.get("clt_tar_sensor_seq_n_old"));
				model.addAttribute("clt_tar_seq_n_old", requestParams.get("clt_tar_seq_n_old") );
				model.addAttribute("mode", "update");	
				return "adminmetamng/satsensor_mapping_form";
			}
			
			requestParams.remove("view_clt_tar_sensor_seq_n");
			requestParams.remove("view_clt_tar_seq_n");
			return "redirect:satsensor_mapping_list.do?"  + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("수집대상 센서  매핑 정보가 존재하지 않습니다.");
		}
	}
	
	
	/**
	 * 수집대상, 센서 매핑 중복 체크
	 * @param checkDTO
	 * @return
	 */
	@RequestMapping(value = "satsensor_mapping_check_ajax.do" , method = RequestMethod.POST)
	public @ResponseBody SatSensorMPDTO satsensor_mapping_check_ajax(@RequestBody SatSensorMPDTO checkDTO) {
		SatSensorMPDTO dto = null; 
		SatSensorMPMapper mapper = sessionTemplate.getMapper(SatSensorMPMapper.class);
		
		if ( checkDTO.getClt_tar_sensor_seq_n() != null || checkDTO.getClt_tar_seq_n() != null ) {
			dto= mapper.SelectOne(checkDTO); 
		}

	   return dto;
	}
	

	/******************************************************************************
	 * 
	 * 센서 밴드 매핑 정보  관리  
	 * 
	 ******************************************************************************/
	/**
	 * 센서 밴드 매핑 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("sensorband_mapping_list.do")
	public void sensorband_mapping_list(ModelMap model,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		SensorBandMapper mapper = sessionTemplate.getMapper(SensorBandMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}


	/**
	 * 센서 밴드 매핑 등록
	 * @param model
	 * @param sensorband_mapping_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sensorband_mapping_form.do")
	public void sensorband_mapping_form(ModelMap model, 
			@RequestParam(value="view_clt_tar_sensor_seq_n", required=false) String clt_tar_sensor_seq_n,
			@RequestParam(value="view_clt_tar_band_seq_n", required=false) String clt_tar_band_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		SensorBandDTO dto = null;
		if( mode.equalsIgnoreCase("new") ) {
			dto = new SensorBandDTO();
			model.addAttribute("mode", "new");
		} else if(mode.equalsIgnoreCase("update")  && clt_tar_sensor_seq_n != null || clt_tar_band_seq_n != null ) {
			SensorBandMapper mapper = sessionTemplate.getMapper(SensorBandMapper.class);
			MapperParam params = new MapperParam();
			params.put("clt_tar_sensor_seq_n", clt_tar_sensor_seq_n);
			params.put("clt_tar_band_seq_n", clt_tar_band_seq_n);
			
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("센서 밴드 매핑 정보가  존재하지 않습니다.");
		}
		
		model.addAttribute("sensorBandDTO", dto);
		
	}

	/**
	 * 센서 밴드 매핑조회
	 * @param model
	 * @param sensor_band_mapping_group_seq
	 * @throws Exception
	 */
	@RequestMapping("sensorband_mapping_view.do")
	public void sensorband_mapping_view(ModelMap model, 
			@RequestParam(value="view_clt_tar_sensor_seq_n", required=false) String clt_tar_sensor_seq_n,
			@RequestParam(value="view_clt_tar_band_seq_n", required=false) String clt_tar_band_seq_n ) throws Exception {
	
		SensorBandMapper mapper = sessionTemplate.getMapper(SensorBandMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_sensor_seq_n", clt_tar_sensor_seq_n);
		params.put("clt_tar_band_seq_n", clt_tar_band_seq_n);
		SensorBandDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("센서 밴드 매핑 정보가  존재하지 않습니다.");
		}
		model.addAttribute("sensorBandDTO", dto);
		
	}
	
	
	/**
	 * 센서 밴드 매핑 삭제
	 * @param requestParams
	 * @param sensor_band_mapping_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("sensorband_mapping_del.do")
	public String sensorband_mapping_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_clt_tar_sensor_seq_n", required=false) String clt_tar_sensor_seq_n,
			@RequestParam(value="view_clt_tar_band_seq_n", required=false) String clt_tar_band_seq_n ) throws Exception {
	
		SensorBandMapper mapper = sessionTemplate.getMapper(SensorBandMapper.class);
		MapperParam params = new MapperParam();
		params.put("clt_tar_sensor_seq_n", clt_tar_sensor_seq_n);
		params.put("clt_tar_band_seq_n", clt_tar_band_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		params.put("mdf_k_seq_n", user.getDetail().getId());
		params.put("mdf_ip", request.getRemoteAddr());
    
		mapper.Delete(params);
		requestParams.remove("view_clt_tar_sensor_seq_n");
		requestParams.remove("view_clt_tar_band_seq_n");
		return "redirect:sensorband_mapping_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 센서 밴드 매핑등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="sensorband_mapping_submit.do", method=RequestMethod.POST)
	public String sensorband_mapping_submit(
			HttpServletRequest request,
			ModelMap model, 
			@ModelAttribute("sensorBandDTO") @Valid SensorBandDTO sensorBandDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/sensorband_mapping_form";
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 

		SensorBandMapper mapper = sessionTemplate.getMapper(SensorBandMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			sensorBandDTO.setRg_ip(request.getRemoteAddr());
			sensorBandDTO.setRg_k_seq_n( user.getDetail().getId());
			
			try{
				mapper.Insert(sensorBandDTO);
				
			}catch(DuplicateKeyException e){
				ObjectError error = new ObjectError("error","수집대상 센서 밴드 매핑 정보 중복 에러입니다.");
				bindingResult.addError(error);
				
				model.addAttribute("sensorBandDTO", sensorBandDTO);
				model.addAttribute("mode", "new");	
				return "adminmetamng/sensorband_mapping_form";
			}
		
			return "redirect:sensorband_mapping_list.do";
		}
		else {
			MapperParam params = new MapperParam();
			params.put("clt_tar_sensor_seq_n", requestParams.get("clt_tar_sensor_seq_n"));
			params.put("clt_tar_band_seq_n", requestParams.get("clt_tar_band_seq_n") );
			params.put("view_clt_tar_sensor_seq_n", requestParams.get("view_clt_tar_sensor_seq_n") );
			params.put("view_clt_tar_band_seq_n", requestParams.get("view_clt_tar_band_seq_n") );
			params.put("use_f_cd", requestParams.get("use_f_cd") );
			try{
			    params.put("mdf_k_seq_n", user.getDetail().getId());
			    params.put("mdf_ip", request.getRemoteAddr());
				mapper.Delete(params);
			}catch(DuplicateKeyException e){
				ObjectError error = new ObjectError("error","수집대상 센서 밴드 매핑 정보 중복 에러입니다.");
				bindingResult.addError(error);
				
				model.addAttribute("sensorBandDTO", sensorBandDTO);
				model.addAttribute("mode", "update");	
				return "adminmetamng/sensorband_mapping_form";
			}
			
			requestParams.remove("view_clt_tar_sensor_seq_n");
			requestParams.remove("view_clt_tar_band_seq_n");
			return "redirect:sensorband_mapping_list.do?" + WebUtil.getQueryStringForMap(requestParams);
		}
	}

	
	/**
	 * 센서 밴드 매핑 중복 체크
	 * @param checkDTO
	 * @return
	 */
	@RequestMapping(value = "sensorband_mapping_check_ajax.do" , method = RequestMethod.POST)
	public @ResponseBody SensorBandDTO sensorband_mapping_check_ajax(@RequestBody SensorBandDTO checkDTO) {
		SensorBandDTO dto = null; 
		SensorBandMapper mapper = sessionTemplate.getMapper(SensorBandMapper.class);
		
		if ( checkDTO.getClt_tar_sensor_seq_n() != null || checkDTO.getClt_tar_band_seq_n() != null ) {
			dto= mapper.SelectOne(checkDTO); 
		}

	   return dto;
	}
	

	/******************************************************************************
	 * 
	 * 범위 정보  관리  
	 * 
	 ******************************************************************************/
	/**
	 * 범위정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("coverage_list.do")
	public void coverage_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		CoverageMapper mapper = sessionTemplate.getMapper(CoverageMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}

	/**
	 * 범위정보 리스트 팝업
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("coverage_list_popup.do")
	public void coverage_list_popup(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		CoverageMapper mapper = sessionTemplate.getMapper(CoverageMapper.class);
		
		requestParams.put("search_use", "Y");
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
	}
	
	/**
	 * 범위정보  등록
	 * @param model
	 * @param coverage_group_seq
	 * @throws Exception
	 */
	@RequestMapping("coverage_form.do")
	public void coverage_form(ModelMap model, 
			@RequestParam(value="view_coverage_seq_n", required=false) String coverage_seq_n,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		CoverageDTO dto = null;
		if( mode.equalsIgnoreCase("new") ) {
			dto = new CoverageDTO();
			model.addAttribute("mode", "new");
		} else if( mode.equalsIgnoreCase("update") &&  coverage_seq_n != null) {
			CoverageMapper mapper = sessionTemplate.getMapper(CoverageMapper.class);
			MapperParam params = new MapperParam();
			params.put("coverage_seq_n", coverage_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("범위정보가  존재하지 않습니다.");
		}
		
		model.addAttribute("coverageDTO", dto);
		
	}

	/**
	 * 범위정보 조회
	 * @param model
	 * @param coverage_group_seq
	 * @throws Exception
	 */
	@RequestMapping("coverage_view.do")
	public void coverage_view(ModelMap model, 
			@RequestParam(value="view_coverage_seq_n", required=false) String coverage_seq_n ) throws Exception {
	
		CoverageMapper mapper = sessionTemplate.getMapper(CoverageMapper.class);
		MapperParam params = new MapperParam();
		params.put("coverage_seq_n", coverage_seq_n);
		CoverageDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("범위정보가  존재하지 않습니다.");
		}
		model.addAttribute("coverageDTO", dto);
		
		CoverageCDTMapper mapper2 = sessionTemplate.getMapper(CoverageCDTMapper.class);
		params.put("startRow", 1);
		params.put("endRow", 1000);
		
		model.addAttribute("list", mapper2.SelectMany(params));
		
	}
	
	
	/**
	 * 범위정보 삭제
	 * @param requestParams
	 * @param coverage_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("coverage_del.do")
	public String coverage_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_coverage_seq_n", required=false) String coverage_seq_n ) throws Exception {
	
		CoverageMapper mapper = sessionTemplate.getMapper(CoverageMapper.class);
		MapperParam params = new MapperParam();
		params.put("coverage_seq_n", coverage_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		params.put("mdf_k_seq_n", user.getDetail().getId());
		params.put("mdf_ip", request.getRemoteAddr());
    
		mapper.Delete(params);
		requestParams.remove("view_coverage_seq_n");
		return "redirect:coverage_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 범위정보  등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="coverage_submit.do", method=RequestMethod.POST)
	public String coverage_submit(HttpServletRequest request,
			@ModelAttribute("coverageDTO") @Valid CoverageDTO coverageDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/coverage_form";
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 

		
		CoverageMapper mapper = sessionTemplate.getMapper(CoverageMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			coverageDTO.setRg_ip(request.getRemoteAddr());
			coverageDTO.setRg_k_seq_n( user.getDetail().getId());
			mapper.Insert(coverageDTO);
			return "redirect:coverage_list.do";
		}
		else if ("update".equals(requestParams.get("mode"))) {
			coverageDTO.setMdf_ip(request.getRemoteAddr());
			coverageDTO.setMdf_k_seq_n( user.getDetail().getId() );
			mapper.Update(coverageDTO);
			return "redirect:coverage_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("범위정보가  존재하지 않습니다.");
		}
	
	}
	
	/******************************************************************************
	 * 
	 * 범위 좌표 정보 관리  
	 * 
	 ******************************************************************************/

	/**
	 * 범위 좌표 정보 리스트
	 * @param model
	 * @param page
	 * @param pageSize
	 */
	@RequestMapping("coverage_cdt_list.do")
	public void coverage_cdt_list(ModelMap model, 
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="iPage", defaultValue="1") int page,
			@RequestParam(value="iPageSize", defaultValue=Constants.PAGE_SIZE) int pageSize ) {
		
		CoverageCDTMapper mapper = sessionTemplate.getMapper(CoverageCDTMapper.class);
		
		int count = mapper.Count(requestParams);

		PageNavigation navigation = new PageNavigation(page, count, pageSize);

		requestParams.put("startRow", ""+navigation.getStartRow());
		requestParams.put("endRow", ""+navigation.getEndRow());
		
	
		model.addAttribute("list", mapper.SelectMany(requestParams));
		model.addAttribute("pageNavigation", navigation);
		
	}
	
	
	/**
	 * 범위 좌표 정보  등록
	 * @param model
	 * @param coverage_cdt_group_seq
	 * @throws Exception
	 */
	@RequestMapping("coverage_cdt_form.do")
	public void coverage_cdt_form(ModelMap model, 
			@RequestParam(value="view_coverage_cdt_seq_n", required=false) Integer coverage_cdt_seq_n,
			@RequestParam(value="view_coverage_seq_n", required=false) Integer  coverage_seq_n ,
			@RequestParam(value="mode", required=false) String mode ) throws Exception {
	
		CoverageCDTDTO dto = null;
		if(  mode.equalsIgnoreCase("new") && coverage_seq_n != null) {
			dto = new CoverageCDTDTO();
			dto.setCoverage_seq_n(coverage_seq_n);
			model.addAttribute("mode", "new");
		} else if( mode.equalsIgnoreCase("update") && coverage_cdt_seq_n != null && coverage_seq_n != null) {
			CoverageCDTMapper mapper = sessionTemplate.getMapper(CoverageCDTMapper.class);
			MapperParam params = new MapperParam();
			params.put("coverage_cdt_seq_n", coverage_cdt_seq_n);
			dto = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dto == null) {
			throw new Exception("범위좌표정보가  존재하지 않습니다.");
		}
		model.addAttribute("coverageCDTDTO", dto);
	}

	/**
	 * 범위 좌표 정보 조회
	 * @param model
	 * @param coverage_cdt_group_seq
	 * @throws Exception
	 */
	@RequestMapping("coverage_cdt_view.do")
	public void coverage_cdt_view(ModelMap model, 
			@RequestParam(value="view_coverage_cdt_seq_n", required=false) String coverage_cdt_seq_n ) throws Exception {
	
		CoverageCDTMapper mapper = sessionTemplate.getMapper(CoverageCDTMapper.class);
		MapperParam params = new MapperParam();
		params.put("coverage_cdt_seq_n", coverage_cdt_seq_n);
		CoverageCDTDTO dto = mapper.SelectOne(params);

		if(dto == null) {
			throw new Exception("범위좌표정보가  존재하지 않습니다.");
		}
		model.addAttribute("coverageCDTDTO", dto);
		
	}
	
	
	/**
	 * 범위 좌표 정보 삭제
	 * @param requestParams
	 * @param coverage_cdt_group_seq
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("coverage_cdt_del.do")
	public String coverage_cdt_del(HttpServletRequest request,
			@RequestParam Map<String,String> requestParams, 
			@RequestParam(value="view_coverage_cdt_seq_n", required=false) String coverage_cdt_seq_n ) throws Exception {
	
		CoverageCDTMapper mapper = sessionTemplate.getMapper(CoverageCDTMapper.class);
		MapperParam params = new MapperParam();
		params.put("coverage_cdt_seq_n", coverage_cdt_seq_n);
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails());
		params.put("mdf_k_seq_n", user.getDetail().getId());
		params.put("mdf_ip", request.getRemoteAddr());
    
		mapper.Delete(params);
		requestParams.remove("view_coverage_cdt_seq_n");
		return "redirect:coverage_view.do?" + WebUtil.getQueryStringForMap(requestParams);
	}
	
	
	
	/**
	 * 범위 좌표 정보 등록 수정
	 * @param satGroupDTO
	 * @param bindingResult
	 * @param requestParams
	 * @param page
	 * @return
	 * @throws MetaInfoNotFoundException
	 */
	@RequestMapping(value="coverage_cdt_submit.do", method=RequestMethod.POST)
	public String coverage_cdt_submit(HttpServletRequest request,
			@ModelAttribute("CoverageCDTDTO") @Valid CoverageCDTDTO coverageCDTDTO, 
			BindingResult bindingResult, 
			@RequestParam Map<String,String> requestParams ) throws Exception {

		if(bindingResult.hasErrors())
			return "admin/meta/coverage_cdt_form";
		
		@SuppressWarnings("deprecation")
		WebUser user = (WebUser)(((UserDetailsWrapper) SecurityContextHolder.getContext().getAuthentication().getPrincipal()).getUnwrappedUserDetails()); 

		CoverageCDTMapper mapper = sessionTemplate.getMapper(CoverageCDTMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			coverageCDTDTO.setRg_ip(request.getRemoteAddr());
			coverageCDTDTO.setRg_k_seq_n( user.getDetail().getId());
			
			mapper.Insert(coverageCDTDTO);
			
			requestParams.remove("view_coverage_cdt_seq_n");
			return "redirect:coverage_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}
		else if("update".equals(requestParams.get("mode"))) {
			coverageCDTDTO.setMdf_ip(request.getRemoteAddr());
			coverageCDTDTO.setMdf_k_seq_n( user.getDetail().getId() );
			mapper.Update(coverageCDTDTO);
			
			return "redirect:coverage_cdt_view.do?" + WebUtil.getQueryStringForMap(requestParams);
		}else{
			throw new Exception("범위좌표정보가  존재하지 않습니다.");
		}
	
	}
	
	
	
}
