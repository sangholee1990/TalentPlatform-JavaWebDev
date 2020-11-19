package kr.co.indisystem.web.user;


import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class UserController {

	@Autowired
	private UserServiceImpl userService;

	
	@RequestMapping("/user/manage/mypage")
	public String myPage(Model model){
		return "user/manage/mypage";
	}
	
	/**
	 * 로그인 페이지 이동
	 * */
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login(Model model, Principal principal){
		if(principal!=null){return "login/logout";}
		model.addAttribute("user", new User());
		return "login/login";
	}
	
	/**
	 * 로그인 페이지 이동
	 * */
	@RequestMapping(value="/login", method = RequestMethod.POST)
	public String loginUser(Model model, Principal principal){
		System.out.println("실행");
		return "/index";
	}

	/**
	 * 회원가입 페이지
	 * */
	@RequestMapping(value = "/sign", method = RequestMethod.GET)
	public String sign(Model model, Principal principal){
		if(principal!=null){return "login/logout";}
		model.addAttribute("user", new User());
		return "login/sign";
	}
	
	/**
	 *	회원 정보 저장 
	 * @throws Exception 
	 * */
	@RequestMapping(value = "/sign", method = RequestMethod.POST)
	public String signUser(@Valid User user, BindingResult result, Errors error){

		if(result.hasErrors()){
			return "login/sign";
		}
		userService.insertUser(user);
		return "redirect:/index";
	}

	@RequestMapping(value = "/signs")
	public String signs(Model model){
		model.addAttribute("user", new User());
		return "login/sign";
	}
	
}
