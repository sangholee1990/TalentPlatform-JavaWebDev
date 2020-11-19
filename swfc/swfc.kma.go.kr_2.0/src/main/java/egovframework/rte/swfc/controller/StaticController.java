package egovframework.rte.swfc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class StaticController extends BaseController{
	
	/**
	 * 우주기상 소개
	 * @param lang
	 * @param tab
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/{lang}/intro.do", method = RequestMethod.GET)
	public String intro(@PathVariable("lang") String lang, 
			@RequestParam(required=false, value="tab", defaultValue="sun") String tab, ModelMap model) {
		return getViewName(lang, "static/intro");
	}
	
	/**
	 * 탑제체 소개
	 * @param lang
	 * @param tab
	 * @param model 
	 * @return
	 */
	@RequestMapping(value = "/{lang}/ksem.do", method = RequestMethod.GET)
	public String ksem(@PathVariable("lang") String lang, 
			@RequestParam(required=false, value="tab", defaultValue="sun") String tab, ModelMap model) {
		return getViewName(lang, "static/ksem");
	}
	
	/**
	 * 해외 우주기상 소개
	 * @param lang
	 * @param tab
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/{lang}/links.do", method = RequestMethod.GET)
	public String links(@PathVariable("lang") String lang,
			@RequestParam(required=false, value="tab", defaultValue="sub1") String tab, ModelMap model) {
		return getViewName(lang, "static/links");
	}

}
