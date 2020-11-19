/**
 * 
 */
package egovframework.rte.swfc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringEscapeUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.swfc.common.Key;
import egovframework.rte.swfc.dto.MapperParam;
import egovframework.rte.swfc.service.SpecificUserContentService;

/**
 * 특정 수요자를 위한 컨텐츠 정보를 보여준다.
 * @author Administrator
 *
 */
@Controller
public class SpecificUserContentController extends BaseController  {
	
	/**
	 * 	특정수요자용 서비스
	 *
	 **/
	@Autowired
	private SpecificUserContentService spcfService;

	
	/**
	 * 	특정수요자용 페이지
	 *	@return
	 **/
	@RequestMapping("/{lang}/specificContent/specific.do")
	public String specific (@PathVariable("lang") String lang,Model model, HttpServletRequest request){
     	if(request.getAttribute("message") != null){
     		model.addAttribute("message", request.getAttribute("message"));
     		return getViewName(lang, "specificContent/specific_error");
     	}
     	
     	HttpSession session = request.getSession(false);
 		String userId = (String)session.getAttribute(Key.User.USER_ID);
     	
		MapperParam params = new MapperParam();
		params.put("userId", userId);
		//tx
		//spcfService.insertNewContent(params);
		
		model.addAttribute("contentList", spcfService.selectContent(params));
     	
		return getViewName(lang, "specificContent/specific");
	}
	
	/**
	 * 	특정수요자 수정 사항 적용
	 *  @param updateData
	 *	@return
	 **/
	@RequestMapping("/{lang}/specificContent/updateUserMapping.do")
	public String updateUserMapping(
			@RequestParam(value="updateData", required=true) String updateData,
			@PathVariable("lang") String lang, 
			Model model, HttpServletRequest request) throws Exception{

		MapperParam params = new MapperParam();
		HttpSession session = request.getSession(false);
		
     	String userId = (String)session.getAttribute(Key.User.USER_ID);
    	params.put("userId", userId);
    	
     	List<Map<String, String>> updateList = null;
     	Map<String, String> infoMap = null;
     	
     	if(updateData.equals("")||updateData !=null){
     		ObjectMapper om = new ObjectMapper();
     		String jsonString = StringEscapeUtils.unescapeHtml(updateData);//HTML 코드 변환
     		JsonNode root = om.readTree(jsonString);	//String을 Json형태로 paser
    		JsonNode data = root.path("updateData");	//배열 접근
    		if(data.size() > 0){
    			updateList = new ArrayList<Map<String, String>>();	
    			for (int i = 0; i < data.size(); i++) {
    				infoMap = new HashMap<String, String>();
    				JsonNode info = data.get(i);
    				infoMap.put("spcfSeq", info.findValue("spcfSeq").getTextValue());
    				infoMap.put("cssInfo", info.findValue("cssInfo").getTextValue());
    				infoMap.put("userUse", info.findValue("userUse").getTextValue());
    				infoMap.put("orderNum", info.findValue("orderNum").getTextValue());
    				updateList.add(infoMap);
    			}
    			params.put("updateData", updateList);
    		}
     	}
     	spcfService.updateContents(params);
     	return "jsonView";
	}
	
	/**
	 * 특정수요자용 콘텐츠 페이지
	 * @param lang
	 * @param tab
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/{lang}/specificContent/specificContent.do", method = RequestMethod.GET)
	public String intro(@PathVariable("lang") String lang, @RequestParam(required=true, value="menu", defaultValue="main") String menu, ModelMap model) {
		return getViewName(lang, "specificContent/contents/" + menu);
	}
	
}//class end
