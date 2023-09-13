package com.example.demo.controller;

import javax.servlet.http.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.demo.dto.MemberInfoDto;
import com.example.demo.service.LoginSvc;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class LoginCtrl {
	private final LoginSvc loginSvc;
	
	@RequestMapping(value = "/login_form")
    public String isLogin(HttpServletRequest request, 
    		Model model,
    		@RequestParam(value = "url", required = false) String url){
		if(url==null || url.equals("")) { url = "index"; }
		model.addAttribute("url", request.getHeader("referer"));
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginInfo")!=null) {
			return "redirect:/"+url;
		}
		return "login_form";
    }
	
	@RequestMapping(value = "/login_proc", method = RequestMethod.POST)
	public String login(HttpServletRequest request) {
		String id = request.getParameter("uid");
		String pw = request.getParameter("pwd");
		String url = request.getParameter("url").replaceAll(".jsp", "");
		HttpSession session = request.getSession();
		MemberInfoDto loginInfo = loginSvc.login(id, pw);
		
		if(loginInfo == null) {
			return "login_form";
		}
		session.setAttribute("loginInfo", loginInfo);
		return "redirect:/"+url;
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/index";
	}
}
