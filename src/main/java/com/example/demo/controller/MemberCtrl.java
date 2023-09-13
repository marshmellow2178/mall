package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.example.demo.dto.AdminDto;
import com.example.demo.dto.MemberInfoDto;
import com.example.demo.dto.PageInfo;
import com.example.demo.entity.MemberInfo;
import com.example.demo.service.MemberSvc;
import com.example.demo.vo.MemberUpdateVo;

@Controller
public class MemberCtrl {
	
	@Autowired
	private MemberSvc memberSvc;
	
	@RequestMapping(value = "/member_form_in", method = RequestMethod.GET)
	public String memberFormIn(HttpServletRequest request){
		HttpSession session = request.getSession();
		if(session.getAttribute("loginInfo")!=null) {
			return "login_form";
		}
		return "member/member_in";
	}
	
	@RequestMapping(value = "/chkID", method = RequestMethod.POST)
	@ResponseBody
	public boolean chkID(@RequestBody String id) {
		return memberSvc.chkID(id);
	}
	
	@RequestMapping(value = "/chkEmail", method = RequestMethod.POST)
	@ResponseBody
	public boolean chkEmail(@RequestBody String email) {
		return memberSvc.chkEmail(email);
	}

	@RequestMapping(value = "/member_proc_in", method = RequestMethod.POST)
	public String memberProcIn(MemberInfoDto mid) {
		memberSvc.insert(mid);
		return "redirect:isLogin";
	}
	
	@RequestMapping(value = "/member_proc_up", method = RequestMethod.POST)
	public String memberProcUp(
		MemberUpdateVo muv,
		HttpServletRequest request,
		Model model
		) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginInfo")==null) {
			return "login_form";
		}
		session.setAttribute("loginInfo", memberSvc.update(muv));
		return "mypage/myinfo_detail";
	}
	
	@RequestMapping(value = "/member_proc_del", method = RequestMethod.POST)
	public String memberProcDel(
			HttpServletRequest request,
			@RequestParam(value = "upw") String password
			) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi.getPw().equals(password)) {
			memberSvc.delete(mi);
		}
		session.invalidate();
		return "redirect:/index";
	}
	
	@RequestMapping(value = "/super_member_list")
	public String adminMemberList(
			@RequestParam(value = "key", required = false)String key,
			Model model, 
			@PageableDefault(size=10, sort="joindate", direction = Sort.Direction.DESC)Pageable pageable
			) {
		PageInfo pageInfo = new PageInfo();
		if(key==null){ key = ""; } 
		List<MemberInfo> memberList = memberSvc.getMemberList(key, pageable, pageInfo);
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/super_member_list";
	}
	
	@RequestMapping(value = "/super_member_update")
	public String adminMemberUpdate(
			@RequestParam(value = "idx")Integer idx,
			Model model,
			HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		
		MemberInfo mi = memberSvc.findByIdx(idx);
		model.addAttribute("memberInfo", mi);
		return "admin/super_member_update";
	}
	
	@RequestMapping(value = "/super_member_update_proc")
	public String adminMemberUpdateProc(
			@RequestParam(value = "idx")Integer idx,
			@RequestParam(value = "id")String id,
			@RequestParam(value = "point")Integer point,
			@RequestParam(value = "status")String status,
			RedirectAttributes ra
			) {
		memberSvc.adminMemberUpdate(idx, id, point, status);
		ra.addAttribute("idx", idx);
		return "redirect:/super_member_update";
	}
}
