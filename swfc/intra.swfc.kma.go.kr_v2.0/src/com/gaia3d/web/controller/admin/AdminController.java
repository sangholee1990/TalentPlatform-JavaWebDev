package com.gaia3d.web.controller.admin;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.dao.SaltSource;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.dto.MapperParam;
import com.gaia3d.web.dto.UserDTO;
import com.gaia3d.web.exception.UserNotFoundException;
import com.gaia3d.web.mapper.UserMapper;
import com.gaia3d.web.service.CodeService;
import com.gaia3d.web.service.SPCFService;
import com.gaia3d.web.util.PageNavigation;
import com.gaia3d.web.util.WebUtil;

@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	private static final String USER_GROUP_CODE_CD = "USER_GROUP_ID";
	
	private static final String USER_ROLE_CODE_CD = "USER_ROLE_CODE";
	
	@Autowired
	@Qualifier(value="userPasswordEncoder")
	private ShaPasswordEncoder passwordEncoder;
	
	@Autowired
	@Qualifier(value="userPasswordSaltSource")
	private SaltSource passwordSaltSource;
	
	@Autowired
	private CodeService codeService;

	/**
	 * 특정수용자용 컨텐츠 서비스
	 */
	@Autowired
	private SPCFService spcfService;
	
		
	@ModelAttribute("UserGroupList")
	public List<CodeDTO> user_group_list() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", USER_GROUP_CODE_CD);
		params.put("use_yn", "Y");
		
		return codeService.selectSubCodeList(params);
	}
	
	@ModelAttribute("roleList")
	public List<CodeDTO> user_role_list() {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", USER_ROLE_CODE_CD);
		params.put("use_yn", "Y");
		
		return codeService.selectSubCodeList(params);
	}
	
	@RequestMapping("user/user_list.do")
	public void user_list(ModelMap model, 
			@RequestParam(value="p", defaultValue="1") int page,
			@RequestParam(value="ps", defaultValue="10") int pageSize) {
		UserMapper mapper = sessionTemplate.getMapper(UserMapper.class);
		
		MapperParam params = new MapperParam();
		int count = mapper.Count(params);
		
		PageNavigation navigation = new PageNavigation(page, count, pageSize);
		params.put("startRow", navigation.getStartRow());
		params.put("endRow", navigation.getEndRow());
		
		model.addAttribute("list", mapper.SelectMany(params));
		model.addAttribute("pageNavigation", navigation);
	}
	
	@RequestMapping("user/user_form.do")
	public void user_form(ModelMap model, @RequestParam(value="id", required=false) String id) throws Exception {
		UserDTO dao = null;
		if(id == null) {
			dao = new UserDTO();
			model.addAttribute("mode", "new");
		} else {
			UserMapper mapper = sessionTemplate.getMapper(UserMapper.class);
			MapperParam params = new MapperParam();
			params.put("id", id);
			dao = mapper.SelectOne(params);
			model.addAttribute("mode", "update");
		}
		
		if(dao == null) {
			throw new Exception("사용자가 존재하지 않습니다.");
		}
		
		String phone = dao.getPhone();
		if(phone != null) {
			String[] phoneArr = phone.split("-");
			if(phoneArr.length >= 3)
				model.addAttribute("tel3", phoneArr[2]);
			if(phoneArr.length >= 2)
				model.addAttribute("tel2", phoneArr[1]);
			if(phoneArr.length >= 1)
				model.addAttribute("tel1", phoneArr[0]);
		}
		
		model.addAttribute("user", dao);
	}
	
	@RequestMapping("user/user_view.do")
	public void user_view(ModelMap model, @RequestParam(value="id", required=true) String id) throws Exception {
		UserMapper mapper = sessionTemplate.getMapper(UserMapper.class);
		MapperParam params = new MapperParam();
		params.put("id", id);
		UserDTO dao = mapper.SelectOne(params);
		
		if(dao == null) {
			throw new UserNotFoundException();
		}
		
		model.addAttribute("user", dao);
		
		/** 특정수요자용 컨텐츠 검색 start */
		/** 2014.09.26 김현철 추가 */
		params.put("user_seq_n", id);
		
		// 모델에 추가 
		model.addAttribute("spcf_list", spcfService.searchSPCFContents(params));
		/** 특정수용자용 컨텐츠 검색 end */
	}
	
	/**
	 * 특정수요자 회원의 특정수요자용 컨텐츠를 등록한다.
	 * 2014.09.26 김현철 추가
	 * @param params
	 * @return
	 */
	@RequestMapping(value="user/user_spcf_contents_insert.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> userSPCFContentsAdd(@RequestParam Map<String, Object> params, @RequestParam(value="spcf_seq_n", required=false) String[] spcf_seq_n) {
		params.put("user_seq_n", params.get("id"));
		params.put("spcf_seq_n", spcf_seq_n);
		
		if(spcf_seq_n.length < 1) params.put("spcf_seq_list", null);
		else params.put("spcf_seq_list", Arrays.asList(spcf_seq_n));
		
		// 특정수요자 회원의 특정수용자용 컨텐츠를 등록한다.
		int result = spcfService.insertSPCFContentsUserMapping(params);
		
		Map<String, Object> output = new HashMap<String, Object>();
		
		output.put("result", result);
		
		return output;
	}
	
	@RequestMapping("user/user_del.do")
	public String user_del(@RequestParam Map<String,String> requestParams, @RequestParam(value="id", required=true) String id) throws Exception {
		UserMapper mapper = sessionTemplate.getMapper(UserMapper.class);
		MapperParam params = new MapperParam();
		params.put("id", id);
		mapper.Delete(params);
		requestParams.remove("id");
		return "redirect:user_list.do?" + WebUtil.getQueryStringForMap(requestParams);
	}	
	
	@RequestMapping(value="user/user_submit.do", method=RequestMethod.POST)
	public String user_submit(@ModelAttribute("user") @Valid UserDTO user, BindingResult bindingResult, @RequestParam Map<String,String> requestParams,  @RequestParam(value="p", required=false) Integer page) throws UserNotFoundException {
		if(bindingResult.hasErrors())
			return "admin/user_form";
		
		if(StringUtils.isNotBlank(user.getPassword())) {
			user.setPassword(passwordEncoder.encodePassword(user.getPassword(), passwordSaltSource.getSalt(null)));
		}

		String tel1 = requestParams.get("tel1");
		String tel2 = requestParams.get("tel2");
		String tel3 = requestParams.get("tel3");
		
		if(StringUtils.isNotBlank(tel1) && StringUtils.isNotBlank(tel2) && StringUtils.isNotBlank(tel3))
			user.setPhone(String.format("%s-%s-%s", requestParams.get("tel1"), requestParams.get("tel2"), requestParams.get("tel3")));
		else {
			user.setPhone(null);
		}
		
		UserMapper mapper = sessionTemplate.getMapper(UserMapper.class);
		if("new".equals(requestParams.get("mode"))) {
			mapper.Insert(user);
			return "redirect:user_list.do";
		}
		else {
			mapper.Update(user);
			return "redirect:user_view.do?id=" + user.getId() + "&p=" + (page == null?"":page.toString());
		}
	}	
	
	@RequestMapping("stat_list.do")
	public void stat_list(ModelMap model) {
		
	}

}

