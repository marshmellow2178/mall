package com.example.demo.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.AdminDto;
import com.example.demo.service.AdminSvc;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminCtrl {
	
	private final AdminSvc adminSvc;
	
	@RequestMapping(value = "/super", method = RequestMethod.GET)
	public String adminHome(HttpServletRequest request){
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		return "admin/super_index";
	}
	
	@RequestMapping(value = "/super_login", method = RequestMethod.GET)
	public String adminLoginForm(HttpServletRequest request) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo!=null) {
			return "admin/super_index";
		}
		return "admin/super_login";
	}

	@RequestMapping(value = "/super_login_proc", method = RequestMethod.POST)
	public String adminLogin(
			HttpServletRequest request,
			@RequestParam("id") String id,
			@RequestParam("pw") String pw
			) {
		AdminDto dto = adminSvc.getAdmin(id, pw);
		if(dto==null) {
			return "redirect:/super_login";
		}
		HttpSession session = request.getSession();
		session.setAttribute("adminInfo", dto);
		return "redirect:/super";
	}
	
	@RequestMapping(value = "/super_logout")
	public String adminLogout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/super_login";
	}
}
