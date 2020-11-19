package kr.co.indisystem.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 기본 컨트롤러
 * 
 *	Index, Http Error Page
 * 
 * */
@Controller
public class BasicController {
	
	/**
	 * 첫 페이지
	 * */
	@RequestMapping({"/", "/index"})
	public String index(ModelMap model){
		return "/monitor";
	}	
	
	@RequestMapping("/error/403")
	public String Error403(){
		return "error/403";
	}
	
	@RequestMapping("/error/404")
	public String Error404(){
		return "error/404";
	}
	
	@RequestMapping("/error/500")
	public String Error500(){
		return "error/500";
	}
	

}