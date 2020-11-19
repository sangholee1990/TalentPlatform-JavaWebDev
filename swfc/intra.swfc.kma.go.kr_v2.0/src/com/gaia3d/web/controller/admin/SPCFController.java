package com.gaia3d.web.controller.admin;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gaia3d.web.controller.BaseController;
import com.gaia3d.web.service.SPCFService;
import com.itextpdf.text.log.SysoCounter;

@Controller
@RequestMapping("/admin/spcf/")
public class SPCFController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(SPCFController.class);
	
	/**
	 * 특정수요자용 컨텐츠 서비스
	 */
	@Autowired
	private SPCFService spcfService;
	
	/**
	 * 특정수요자용 컨텐츠 검색
	 * @param page
	 * @param pageSize
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("spcf_contents_list.do")
	public String spcfContentsList(
			@RequestParam(value="page", defaultValue="1") int page
			,@RequestParam(value="pageSize", defaultValue="10") int pageSize
			,@RequestParam Map<String, Object> params
			,Model model) {
		
		// 파라메터에 page, pageSize를 추가한다.
		params.put("page", page);
		params.put("pageSize", pageSize);
		
		// 모델에 검색결과를 추가한다.
		model.addAttribute("data", spcfService.listSPCFContents(params));
		
		return "/admin/spcf/spcf_contents_list";
	}
	
	/**
	 * 특정수요자용 컨텐츠 등록/수정 페이지로 이동한다.
	 * @param spcf_seq_n
	 * @param params
	 * @param model
	 * @return
	 */
	@RequestMapping("spcf_contents_form.do")
	public String spcfContentsForm(
			@RequestParam(value="spcf_seq_n", defaultValue="-1") int spcf_seq_n
			, @RequestParam Map<String, Object> params
			, @RequestParam(value="page", defaultValue="1") int page
			, Model model) {
		
		// 컨텐츠 수정인 경우
		if(spcf_seq_n != -1) {
			// 특정수요자용 컨텐츠 조회결과를 모델에 추가한다.
			model.addAttribute("data", spcfService.selectSPCFContents(params));
		}

		model.addAttribute("page", page);
		
		return "/admin/spcf/spcf_contents_form";
	}
	
	/**
	 * 특정수요자용 컨텐츠를 등록한다.
	 * @param params
	 * @return
	 */
	@RequestMapping("spcf_contents_submit.do")
	public String spcfContentsAdd(@RequestParam Map<String, Object> params) {
		
		// 특정수요자용 컨텐츠를 등록한다.
		spcfService.insertSPCFContents(params);
		
		// 목록으로 이동한다.
		return "redirect:spcf_contents_list.do";
	}
	
	/**
	 * 특정수요자용 컨텐츠를 수정한다.
	 * @param spcf_seq_n
	 * @param params
	 * @return
	 */
	@RequestMapping("spcf_contents_modify.do")
	public String spcfContentsModify(
			@RequestParam(value="spcf_seq_n", required=true) int spcf_seq_n
			, @RequestParam Map<String, Object> params) {
		
		// 특정수요자용 컨텐츠를 수정한다.
		spcfService.updateSPCFContents(params);
		
		// 등록/수정화면으로 이동한다.
		return "redirect:spcf_contents_form.do?spcf_seq_n=" + spcf_seq_n;
	}
	
	/**
	 * 특정수요자용 컨텐츠를 삭제한다.
	 * @param spcf_seq_n
	 * @param params
	 * @return
	 */
	@RequestMapping("spcf_contents_delete.do")
	public String deleteSPCFContents(
			@RequestParam(value="spcf_seq_n", required=true) int spcf_seq_n
			,@RequestParam Map<String, Object> params) {
		
		// 특정수요자용 컨텐츠를 삭제한다.
		spcfService.deleteSPCFContents(params);
		
		// 목록화면으로 이동한다.
		return "redirect:spcf_contents_list.do";
	}
}
