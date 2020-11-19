package com.gaia3d.web.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.dto.CodeDTO;
import com.gaia3d.web.service.CodeService;
import com.gaia3d.web.service.GnssService;


/**
 * GNSS 지점 요청을 처리하는 클래스
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/gnss/")
public class GnssController extends BaseController {
	
	private static final String GNSS_ORG_CODE_CD ="GNSS_ORG_CODE_CD";
	
	
	@Autowired
	private CodeService codeService;
	
	@Autowired
	private GnssService gnssService;
	
	
	private List<CodeDTO> listCode(String code){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", code);
		params.put("use_yn", "Y");
		return codeService.selectSubCodeList(params);
	}
	
	/**
	 * SMS 사용자정보 페이지를 보여준다.
	 * @return
	 */
	@RequestMapping("gnss_station_list.do")
	public String smsUserList(
			@RequestParam(value="page", defaultValue="1") int page
			,@RequestParam(value="pageSize", defaultValue="10") int pageSize
			,@RequestParam Map<String, Object> params
			,Model model){
		
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		model.addAttribute("data", gnssService.listGnssStationWithPaging(params));
		return "/admin/gnss/gnss_station_list";
	}
	
	/**
	 * 글 등록 및 수정 요청을 처리한다.
	 * @param user_seq_n
	 * @param params
	 * @return
	 */
	@RequestMapping("gnss_station_form.do")
	public String gnssStationForm(@RequestParam(value="id", required=false) Integer id, @RequestParam Map<String, Object> params, Model model){
		if(id != null){
			model.addAttribute("gnss", gnssService.selectGnssStation(params));
		}
		
		model.addAttribute("gnssOrganzationList", listCode(GNSS_ORG_CODE_CD));
		model.addAttribute("gnssTypeList", gnssService.listGnssStationMappingInfo(params));
		return "/admin/gnss/gnss_station_form";
	}
	
	/**
	 * 지정정보를 등록 요청을 처리한다.
	 * @return
	 */
	@RequestMapping("gnss_station_submit.do")
	public String gnssStnAdd(@RequestParam Map<String, Object> params, @RequestParam(value="code", required=false) String[] code){
		params.put("code", code);
		gnssService.insertGnssStation(params);
		return "redirect:gnss_station_list.do";
	}
	
	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping("gnss_station_modify.do")
	public String smsUserModify(@RequestParam(value="id", defaultValue = "-1") Integer id,@RequestParam Map<String, Object> params, @RequestParam(value="code", required=false) String[] code){
		params.put("code", code);
		gnssService.updateGnssStation(params);
		return "redirect:gnss_station_form.do?id=" + id;
	}
	

	/**
	 * SMS 사용자를 등록한다.
	 * @return
	 */
	@RequestMapping(value="gnss_station_delete.do", method=RequestMethod.POST)
	public String deleteSmsUser(@RequestParam(value="user_seq_n", defaultValue = "-1", required=true) int user_seq_n, @RequestParam Map<String, Object> params){
		int result = gnssService.deleteGnssStation(params);
		return "redirect:gnss_station_list.do";
	}

}
