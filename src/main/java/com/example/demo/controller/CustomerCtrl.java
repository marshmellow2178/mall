package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.AdminDto;
import com.example.demo.dto.MemberInfoDto;
import com.example.demo.dto.PageInfo;
import com.example.demo.entity.Faq;
import com.example.demo.entity.Inquiry;
import com.example.demo.entity.InquiryAnswer;
import com.example.demo.entity.Notice;
import com.example.demo.service.CustomerSvc;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CustomerCtrl {
	private final CustomerSvc customerSvc;
	
	@RequestMapping(value = "/notice_list")
	public String noticeList(
		@RequestParam(value = "ctgr", required = false) String ctgr,
		@RequestParam(value = "key", required = false) String key,
		@PageableDefault(size=10, sort="date", direction = Sort.Direction.DESC)Pageable pageable,
		Model model
		) {
		if(ctgr==null) { ctgr = ""; }
		if(key == null) { key = "";}
		PageInfo pageInfo = new PageInfo();
		List<Notice> noticeList = customerSvc.getNoticeList(ctgr, key, pageable, pageInfo);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageInfo", pageInfo);
		return "customer/notice_list";
	}
	
	@RequestMapping(value = "/super_notice_list")
	public String adminNoticeList(
			@RequestParam(value = "ctgr", required = false) String ctgr,
			@RequestParam(value = "key", required = false) String key,
			@PageableDefault(size=10, sort="date", direction = Sort.Direction.DESC)Pageable pageable,
			Model model
			) {
			PageInfo pageInfo = new PageInfo();
			if(ctgr==null) { ctgr = ""; }
			if(key == null) { key = "";}
			List<Notice> noticeList = customerSvc.getNoticeList(ctgr, key, pageable, pageInfo);
			model.addAttribute("noticeList", noticeList);
			model.addAttribute("pageInfo", pageInfo);
			return "admin/super_notice_list";
		}
	
	@RequestMapping(value = "/super_notice_register")
	public String adminNoticeRegister(
			HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		
		return "admin/super_notice_register";
	}
	
	@RequestMapping(value = "/notice_proc_in")
	public String noticeRegister(
			@RequestParam(value = "ctgr") String ctgr,
			@RequestParam(value = "title") String title,
			@RequestParam(value = "content") String content
			) {
		customerSvc.noticeRegister(ctgr, title, content);
		return "redirect:/super_notice_list";
	}
	
	@RequestMapping(value = "/super_notice_update")
	public String noticeUpdate(
			@RequestParam(value = "idx")Integer idx,
			Model model
			) {
		Notice n = customerSvc.getNotice(idx);
		model.addAttribute("notice", n);
		return "admin/super_notice_update";
	}
	
	@RequestMapping(value = "/notice_update_proc")
	public String noticeUpdateProc(
			@RequestParam(value = "idx") Integer idx,
			@RequestParam(value = "ctgr") String ctgr,
			@RequestParam(value = "title") String title,
			@RequestParam(value = "content") String content
			) {
		customerSvc.noticeUpdate(idx, ctgr, title, content);
		return "redirect:/super_notice_list";
	}
	
	@RequestMapping(value = "/faq_list")
	public String faq(
			@RequestParam(value = "ctgr", required = false) String ctgr,
			@RequestParam(value = "key", required = false) String key,
			@PageableDefault(size=10, sort="date", direction = Sort.Direction.DESC)Pageable pageable,
			Model model
			) {
		PageInfo pageInfo = new PageInfo();
		if(ctgr==null) { ctgr = ""; }
		if(key == null) { key = "";}
		List<Faq> faqList = customerSvc.getFaqList(ctgr, key, pageable, pageInfo);
		model.addAttribute("faqList", faqList);
		model.addAttribute("pageInfo", pageInfo);
		return "customer/faq_list";
	}
	
	@RequestMapping(value = "/super_faq_list")
	public String adminFaqList(
			@RequestParam(value = "ctgr", required = false) String ctgr,
			@RequestParam(value = "key", required = false) String key,
			@PageableDefault(size=10, sort="date", direction = Sort.Direction.DESC)Pageable pageable,
			Model model
			) {
		PageInfo pageInfo = new PageInfo();
		if(ctgr==null) { ctgr = ""; }
		if(key == null) { key = "";}
		List<Faq> faqList = customerSvc.getFaqList(ctgr, key, pageable, pageInfo);
		model.addAttribute("faqList", faqList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/super_faq_list";
	}
	
	@RequestMapping(value = "/faq_view")
	public String faqView(
			@RequestParam(value = "idx")int idx,
			Model model
			) {
		Faq faq = customerSvc.getFaq(idx);
		model.addAttribute("faq", faq);
		return "mypage/faq_view";
	}
	
	@RequestMapping(value = "/super_faq_register")
	public String adminFaqRegister(
			HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		
		return "admin/super_faq_register";
	}
	
	@RequestMapping(value = "/faq_proc_in")
	public String adminFaqRegisterProc(
			@RequestParam(value = "ctgr") String ctgr,
			@RequestParam(value = "title") String title,
			@RequestParam(value = "content") String content) {
		customerSvc.faqInsert(ctgr, title, content);
		return "redirect:/super_faq_list";
	}

	@RequestMapping(value = "/super_faq_update")
	public String adminFaqUpdate(
			@RequestParam(value = "idx")int idx,
			Model model
			) {
		Faq faq = customerSvc.getFaq(idx);
		model.addAttribute("faq", faq);
		return "admin/super_faq_update";
	}
	
	@RequestMapping(value = "/faq_proc_up")
	public String adminFaqUpdateProc(
			@RequestParam(value = "idx")int idx,
			@RequestParam(value = "ctgr") String ctgr,
			@RequestParam(value = "title") String title,
			@RequestParam(value = "content") String content) {
		customerSvc.faqUpdate(idx, ctgr, title, content);
		return "redirect:/super_faq_list";
	}
	
	@RequestMapping(value = "/inquiry_form")
	public String inquiryFormIn(RedirectAttributes ra, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		return "customer/inquiry_form";
	}
	
	@RequestMapping(value = "/inquiry_proc_in")
	public String inquiryProcIn(
			HttpServletRequest request,
			@RequestParam(value = "ctgr") String ctgr,
			@RequestParam(value = "title") String title,
			@RequestParam(value = "content") String content
			) {
		HttpSession session = request.getSession();
		MemberInfoDto mid = (MemberInfoDto) session.getAttribute("loginInfo");
		String miid = mid.getId();
		customerSvc.inquiryProcIn(miid, ctgr, title, content);
		return "redirect:/inquiry_list";
	}
	
	@RequestMapping(value = "/inquiry_list")
	public String inquiryList(
			HttpServletRequest request,
			RedirectAttributes ra,
			@PageableDefault(size=10, sort="date", direction = Sort.Direction.DESC)Pageable pageable,
			@RequestParam(value = "ctgr", required = false) String ctgr,
			@RequestParam(value = "key", required = false) String key,
			Model model) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		PageInfo pageInfo = new PageInfo();
		if(ctgr==null) { ctgr = ""; }
		if(key==null) { key = ""; }
		List<Inquiry> iList = customerSvc.getInquiryList(ctgr, key, pageable, pageInfo);
		model.addAttribute("iList", iList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "mypage/inquiry_list";
	}
	
	@RequestMapping(value = "/inquiry_view")
	public String inquiryView(
			HttpServletRequest request,
			RedirectAttributes ra,
			@RequestParam(value = "idx")int idx,
			Model model
			) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		Inquiry id = customerSvc.getInquiry(idx);
		List<InquiryAnswer> ia = customerSvc.getInquiryAnswer(idx);
		model.addAttribute("id", id);
		model.addAttribute("aList", ia);		
		return "mypage/inquiry_view";
	}
	
	@RequestMapping(value = "/super_inquiry_list")
	public String adminInquiryList(
			@PageableDefault(size=10, sort="date", direction = Sort.Direction.DESC)Pageable pageable,
			@RequestParam(value = "ctgr", required = false) String ctgr,
			@RequestParam(value = "key", required = false) String key,
			Model model) {
		PageInfo pageInfo = new PageInfo();
		if(ctgr==null) { ctgr = ""; }
		if(key==null) { key = ""; }
		List<Inquiry> iList = customerSvc.getInquiryList(ctgr, key, pageable, pageInfo);
		model.addAttribute("iList", iList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/super_inquiry_list";
	}
	
	@RequestMapping(value = "/super_inquiry_answer")
	public String adminInquiryAnswer(
			HttpServletRequest request,
			Model model,
			@RequestParam(value = "idx") Integer idx) {
		HttpSession session = request.getSession();
		AdminDto ad = (AdminDto) session.getAttribute("adminInfo");
		if(ad==null) {
			return "redirect:/super_login";
		}
		Inquiry i = customerSvc.getInquiry(idx);
		model.addAttribute("inquiry", i);
		return "admin/super_inquiry_answer";
	}
	
	@RequestMapping(value = "/super_inquiry_proc")
	public String adminInquiryProc(
			@RequestParam(value = "idx") Integer idx,
			@RequestParam(value = "answer") String answer
			) {
		customerSvc.inquiryProcAnswer(idx, answer);
		return "redirect:/super_inquiry_list";
	}
}
