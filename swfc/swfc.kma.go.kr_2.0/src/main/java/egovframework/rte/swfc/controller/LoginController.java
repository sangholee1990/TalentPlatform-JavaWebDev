package egovframework.rte.swfc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.dao.SaltSource;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.view.RedirectView;

import egovframework.rte.swfc.common.Key;
import egovframework.rte.swfc.dto.MapperParam;
import egovframework.rte.swfc.dto.UserDTO;
import egovframework.rte.swfc.exception.UserNotFoundException;
import egovframework.rte.swfc.service.UserService;

/**
 * 로그인, 로그아웃을 담담하는 콘트롤러 클래스
 * @author Administrator
 *
 */
@Controller
public class LoginController extends BaseController{
	
	/*
	 * 사용자 비지니스 로직 객체
	 */
	@Autowired
	private UserService userService;
	
	/*
	 * 비밀번호 암호화 객체
	 */
	@Autowired(required=true)
	@Qualifier(value="userPasswordEncoder")
	private ShaPasswordEncoder passwordEncoder;
	
	/*
	 * 비밀번호 조합키 객체 
	 */
	@Autowired
	@Qualifier(value="userPasswordSaltSource")
	private SaltSource passwordSaltSource;
	
	/**
	 * 로그인 요청을 처리한다.
	 * @param lang 언어
	 * @param request 요청값
	 * @param response 응답값
	 * @return
	 * @throws UserNotFoundException
	 */
	@RequestMapping("/{lang}/login.do")
	public String loginForm(@PathVariable("lang") String lang, HttpServletRequest request, HttpServletResponse response, Model model) throws UserNotFoundException{
		
		if("get".equals(request.getMethod().toLowerCase())){
			return getViewName(lang, "login");
		}else{
			MapperParam param = getParams(request);
			//String userid = param.getString("userid");
			String passwd = param.getString("user_pw");
			if(StringUtils.isNotBlank(passwd)){
				passwd = (passwordEncoder.encodePassword(passwd, passwordSaltSource.getSalt(null)));
			}
			param.put("user_pw", passwd);
			
			UserDTO user = userService.selectUser(param);
			if(user == null){
				model.addAttribute("result","로그인 정보가 일치하지 않습니다.");
				return getViewName(lang, "login");
			}
			
			HttpSession session = getSession();
			session.setAttribute(Key.User.USER_ID, user.getUserId());
			session.setAttribute(Key.User.USER_NAME, user.getName());
			session.setAttribute(Key.User.USER_ROLE, user.getRole());
		}
		return "redirect:/";
	}
	
	/**
	 * 로그아웃 요청을 처리한다.
	 * @param lang
	 * @return
	 */
	@RequestMapping("/{lang}/logout.do")
	public RedirectView logout(@PathVariable("lang") String lang, HttpServletRequest request){
		request.getSession().invalidate();
		return new RedirectView("/"+lang+"/login.do", true);
	}
}
