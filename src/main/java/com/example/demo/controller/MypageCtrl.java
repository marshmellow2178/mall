package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.MemberInfoDto;
import com.example.demo.dto.PageInfo;
import com.example.demo.entity.Domain;
import com.example.demo.entity.Point;
import com.example.demo.service.MemberSvc;
import com.example.demo.vo.ChangePwVo;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageCtrl {
	
	private final MemberSvc memberSvc;

	@RequestMapping(value = "/my_page", method = RequestMethod.GET)
	public String myPage(
		 HttpServletRequest request,
		 RedirectAttributes ra
	) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginInfo")==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		return "mypage/myinfo_detail";
	}
	
	@RequestMapping(value = "/check_pw_form")
	public String checkPw() {
		return "mypage/check_pw_form";
	}
	
	@RequestMapping(value = "/pw_form")
	public String pwForm(
		HttpServletRequest request,
		RedirectAttributes ra,
		@RequestParam("upw")String password,
		Model model
	) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		if(!password.equals(mi.getPw())) {
			return "check_pw_form";
		}
		List<Domain> domainList = memberSvc.getDomain();
		model.addAttribute("domainList", domainList);
		return "member/member_up"; 
	}
	
	@RequestMapping(value = "/change_pw_form")
	public String changePwForm(
			RedirectAttributes ra,
		HttpServletRequest request
		) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		return "mypage/change_pw_form";
	}
	
	@RequestMapping(value = "/change_pw",  method = RequestMethod.POST)
	@ResponseBody
	public int changePw(
		HttpServletRequest request,
		RedirectAttributes ra,
		@RequestBody ChangePwVo cpv
	) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			return -1;
		}
		if(!cpv.getOldPwd().equals(mi.getPw())) {
			return 0;	
		}
		String miid = mi.getId();
		memberSvc.pwChangeSvc(cpv.getNewPwd(), miid);
		session.invalidate();
		return 1;
	}
	
	@RequestMapping(value = "/point_list")
	public String pointList(
		@PageableDefault(size=10, sort="date", direction = Sort.Direction.DESC)Pageable pageable,
		HttpServletRequest request,
		RedirectAttributes ra,
		Model model
	) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		
		PageInfo pageInfo = new PageInfo();
		List<Point> pointList = memberSvc.pointList(mi.getId(), pageable, pageInfo);
		model.addAttribute("pointList", pointList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "mypage/point_list";
	}

	@RequestMapping(value = "/member_out")
	public String memberOut(RedirectAttributes ra, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		return "mypage/member_out";
	}
}
