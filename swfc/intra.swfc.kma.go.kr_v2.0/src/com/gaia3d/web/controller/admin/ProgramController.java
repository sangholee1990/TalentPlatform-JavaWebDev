package com.gaia3d.web.controller.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.service.ProgramService;

@Controller
@RequestMapping("/admin/program/")
public class ProgramController extends BaseController {
	
	@Autowired
	private ProgramService programService; 
	
	
	@RequestMapping("ctl_data_form.do")
	public String ctl_data_form(@RequestParam(value="clt_dta_seq_n", required=false) Integer clt_dta_seq_n, @RequestParam Map<String, Object> params, Model model){
		if(clt_dta_seq_n == null){
		}else{
			model.addAttribute("info", programService.selectCltData(params));
		}
		return "/admin/program/ctl_data_form";
	}
	
	@RequestMapping("mp_ctl_data_form.do")
	public String mp_ctl_data_form(@RequestParam(value="clt_dta_mstr_seq_n", required=true) Integer clt_dta_seq_n, @RequestParam Map<String, Object> params, Model model){
			model.addAttribute("info", programService.selectCltData(params));
			model.addAttribute("list", programService.listCltDataMappingInfo(params));
		return "/admin/program/mp_ctl_data_form";
	}
	
	@RequestMapping("ctl_data_submit.do")
	public String ctl_data_submit(@RequestParam Map<String, Object> params){
		programService.insertCltData(params);
		return "redirect:ctl_data_list.do";
	}
	
	@RequestMapping("ctl_prog_form.do")
	public String ctl_prog_form(@RequestParam(value="clt_prog_seq_n", required=false) Integer clt_prog_seq_n, @RequestParam Map<String, Object> params, Model model){
		if(clt_prog_seq_n == null){
		}else{
			model.addAttribute("info", programService.selectCltProg(params));
		}
		return "/admin/program/ctl_prog_form";
	}
	
	@RequestMapping("ctl_prog_submit.do")
	public String ctl_prog_submit(@RequestParam Map<String, Object> params){
		programService.insertCltProg(params);
		return "redirect:ctl_prog_list.do";
	}
	
	@RequestMapping("frct_prog_form.do")
	public String frct_prog_form(@RequestParam(value="frct_prog_seq_n", required=false) Integer frct_prog_seq_n, @RequestParam Map<String, Object> params, Model model){
		if(frct_prog_seq_n == null){
		}else{
			model.addAttribute("info", programService.selectFrctProg(params));
		}
		return "/admin/program/frct_prog_form";
	}
	
	@RequestMapping("mp_frct_prog_form.do")
	public String mp_frct_prog_form(@RequestParam(value="clt_dta_mstr_seq_n", required=true) Integer clt_dta_mstr_seq_n, @RequestParam Map<String, Object> params, Model model){
		model.addAttribute("info", programService.selectFrctProg(params));
		model.addAttribute("list", programService.listFrctProgMappingInfo(params));
		return "/admin/program/mp_frct_prog_form";
	}
	
	@RequestMapping("frct_prog_submit.do")
	public String frct_grog_submit(@RequestParam Map<String, Object> params){
		programService.insertFrctProg(params);
		return "redirect:frct_prog_list.do";
	}
	
	@RequestMapping("ctl_data_list.do")
	public String ctl_data_list(@RequestParam(value="page", defaultValue="1") int page, @RequestParam(value="pageSize", defaultValue="10") int pageSize, @RequestParam Map<String, Object> params ,Model model){
		
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		model.addAttribute("data", programService.listCltData(params));
		return "/admin/program/ctl_data_list";
	}
	
	@RequestMapping("mp_ctl_data_list.do")
	public String mp_ctl_data_list(@RequestParam(value="page", defaultValue="1") int page, @RequestParam(value="pageSize", defaultValue="10") int pageSize, @RequestParam Map<String, Object> params ,Model model){
		
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		model.addAttribute("data", programService.listCltData(params));
		return "/admin/program/mp_ctl_data_list";
	}
	
	@RequestMapping("ctl_prog_list.do")
	public String ctl_prog_list(@RequestParam(value="page", defaultValue="1") int page, @RequestParam(value="pageSize", defaultValue="10") int pageSize, @RequestParam Map<String, Object> params ,Model model){
		
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		model.addAttribute("data", programService.listCltProg(params));
		return "/admin/program/ctl_prog_list";
	}
	
	@RequestMapping("frct_prog_list.do")
	public String listFrctProg(@RequestParam(value="page", defaultValue="1") int page, @RequestParam(value="pageSize", defaultValue="10") int pageSize, @RequestParam Map<String, Object> params ,Model model){
		
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		model.addAttribute("data", programService.listFrctProg(params));
		return "/admin/program/frct_prog_list";
	}
	
	@RequestMapping("mp_frct_prog_list.do")
	public String mp_frct_prog_list(@RequestParam(value="page", defaultValue="1") int page, @RequestParam(value="pageSize", defaultValue="10") int pageSize, @RequestParam Map<String, Object> params ,Model model){
		
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		model.addAttribute("data", programService.listFrctProg(params));
		return "/admin/program/mp_frct_prog_list";
	}
	
	
	@RequestMapping("frct_prog_modify.do")
	public String frct_prog_modify(@RequestParam(value="frct_prog_seq_n", required=true) int frct_prog_seq_n, @RequestParam Map<String, Object> params){
		programService.updateFrctProg(params);
		return "redirect:frct_prog_form.do?frct_prog_seq_n=" + frct_prog_seq_n;
	}
	
	@RequestMapping("ctl_prog_modify.do")
	public String ctl_prog_modify(@RequestParam(value="clt_prog_seq_n", required=true) int clt_prog_seq_n, @RequestParam Map<String, Object> params){
		programService.updateCltProg(params);
		return "redirect:ctl_prog_form.do?clt_prog_seq_n=" + clt_prog_seq_n;
	}
	
	@RequestMapping("ctl_data_modify.do")
	public String ctl_data_modify(@RequestParam(value="clt_dta_seq_n", required=true) int clt_dta_seq_n, @RequestParam Map<String, Object> params){
		programService.updateCltData(params);
		return "redirect:ctl_data_form.do?clt_dta_seq_n=" + clt_dta_seq_n;
	}
	
	@RequestMapping(value="frct_prog_delete.do", method=RequestMethod.POST)
	public String frct_prog_delete(@RequestParam(value="frct_prog_seq_n", required=true) Integer frct_prog_seq_n, @RequestParam Map<String, Object> params){
		int result = programService.deleteFrctProg(params);
		return "redirect:frct_prog_list.do";
	}
	
	@RequestMapping(value="ctl_prog_delete.do", method=RequestMethod.POST)
	public String ctl_prog_delete(@RequestParam(value="clt_prog_seq_n", required=true) Integer clt_prog_seq_n, @RequestParam Map<String, Object> params){
		int result = programService.deleteCltProg(params);
		return "redirect:ctl_prog_list.do";
	}
	
	@RequestMapping(value="ctl_data_delete.do", method=RequestMethod.POST)
	public String ctl_data_delete(@RequestParam(value="clt_dta_seq_n", required=true) Integer clt_dta_seq_n, @RequestParam Map<String, Object> params){
		int result = programService.deleteCltData(params);
		return "redirect:ctl_data_list.do";
	}
	
	@RequestMapping(value="mp_ctl_data_status_change.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  mp_ctl_data_status_change(@RequestParam(value="clt_dta_seq_n", required=true) Integer clt_dta_seq_n, @RequestParam(value="clt_prog_seq_n", required=true) Integer clt_prog_seq_n, @RequestParam(value="flag", required=true) boolean flag, @RequestParam Map<String, Object> params){
		Map<String, Object> output = new HashMap<String, Object>();
		
		int result = -1;
		if(flag){ //등록할 건지 삭제할건지의 여부
			//등록
			programService.insertCltProgMapping(params);
			result = 1;
		}else{
			//삭제
			programService.deleteCltProgMapping(params);
			result = 1;
		}
		output.put("result", result);
		return output;
	}
	
	@RequestMapping(value="mp_frct_data_status_change", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  mp_frct_data_status_change(@RequestParam(value="clt_dta_seq_n", required=true) Integer clt_dta_seq_n, @RequestParam(value="frct_prog_seq_n", required=true) Integer frct_prog_seq_n, @RequestParam(value="flag", required=true) boolean flag, @RequestParam Map<String, Object> params){
		Map<String, Object> output = new HashMap<String, Object>();
		
		int result = -1;
		if(flag){ //등록할 건지 삭제할건지의 여부
			//등록
			programService.insertFrctProgMapping(params);
			result = 1;
		}else{
			//삭제
			programService.deleteFrctProgMapping(params);
			result = 1;
		}
		output.put("result", result);
		return output;
	}

}
