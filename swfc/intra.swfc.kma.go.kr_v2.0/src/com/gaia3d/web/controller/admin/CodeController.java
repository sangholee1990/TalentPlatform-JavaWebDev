package com.gaia3d.web.controller.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.service.CodeService;

/**
 * 코드 정보에 대한 요청을 처리
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/admin/code/")
public class CodeController extends BaseController{
	
	@Autowired
	private CodeService codeService;

	/**
	 * 코드 리스트 정보를 가져온다.
	 * @param model
	 * @return
	 */
	@RequestMapping("code_list.do")
	public String code_list(Model model){
		//model.addAttribute("list", codeService.listAllCode());
		return "admin/code/code_list";
	}
	
	@RequestMapping("code_insert_ajax.do")
	@ResponseBody
	public Map<String, Object> insertCode(@RequestParam Map<String, String> params, Model model){
		Integer result = codeService.insertCode(params);
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("result", result);
		output.put("code_seq_n", params.get("code_seq_n"));
		return output;
	}
	
	@RequestMapping("code_list_ajax.do")
	@ResponseBody
	public Map<String, Object> listCode(@RequestParam Map<String, String> params, Model model){
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("list", codeService.listAllCode());
		return output;
	}
	
	@RequestMapping("code_delete_ajax.do")
	@ResponseBody
	public Map<String, Object> deleteCode(@RequestParam Map<String, String> params, Model model){
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("result", codeService.deleteCode(params));
		return output;
	}
	
	@RequestMapping("code_update_ajax.do")
	@ResponseBody
	public Map<String, Object> updateCode(@RequestParam Map<String, String> params, Model model){
		Map<String, Object> output = new HashMap<String, Object>();
		output.put("result", codeService.updateCode(params));
		output.put("code_seq_n", params.get("code_seq_n"));
		return output;
	}
}
