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
import com.example.demo.dto.EventDto;
import com.example.demo.dto.PageInfo;
import com.example.demo.entity.EventInfo;
import com.example.demo.global.Code_List;
import com.example.demo.service.EventSvc;
import com.example.demo.vo.EventVo;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EventCtrl {
	
	private final EventSvc eventSvc;
	@RequestMapping(value = "/event_list")
	public String eventList(
		@RequestParam(value = "key", required = false)String key,
		@PageableDefault(size=12, sort="edate", direction = Sort.Direction.DESC)Pageable pageable,
		Model model
		) {
		if(key==null) {key = "";}
		PageInfo pageInfo = new PageInfo();
		List<EventInfo> eventList = eventSvc.eventList(key, pageable, pageInfo);
		model.addAttribute("eventList", eventList);
		model.addAttribute("pageInfo", pageInfo);
		return "event/event_list";
	}
	
	@RequestMapping(value = "/event_view")
	public String eventView(
		@RequestParam("beidx") int beidx,
		Model model
		) {
		EventDto ei = eventSvc.eventView(beidx);
		model.addAttribute("el", ei);
		return "event/event_view";
	}
	
	@RequestMapping(value = "/super_event_list")
	public String adminEventList(
			@RequestParam(value = "key", required = false)String key,
			@PageableDefault(size=10, sort="date", direction = Sort.Direction.DESC)Pageable pageable,
			Model model
			) {
		if(key==null) {key = "";}
		PageInfo pageInfo = new PageInfo();
		List<EventInfo> eventList = eventSvc.getAdminEventList(key, pageable, pageInfo);
		model.addAttribute("eventList", eventList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/super_event_list";
	}
	
	@RequestMapping(value = "/super_event_register")
	public String adminEventRegister(
			HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		
		return "admin/super_event_register";
	}
	
	@RequestMapping(value = "/super_event_register_proc")
	public String adminEventRegisterProc(
			HttpServletRequest request,
			RedirectAttributes ra,
			EventVo ev
			) {
		String uploadPath = request.getSession().getServletContext().getRealPath("/");
		uploadPath = uploadPath.substring(0, uploadPath.length()-7)+Code_List.EVENT_IMG;
		int idx = eventSvc.eventRegister(ev, uploadPath);
		ra.addAttribute("idx", idx);
		return "redirect:/super_event_view";
	}
	
	@RequestMapping(value = "/super_event_view")
	public String adminEventView(
			@RequestParam("idx") Integer idx,
			Model model
			) {
		EventInfo ei = eventSvc.getEvent(idx);
		model.addAttribute("event", ei);
		return "admin/super_event_view";
	}
	
	@RequestMapping(value = "/super_event_update")
	public String adminEventUpdate(
			HttpServletRequest request,
			@RequestParam("idx") Integer idx,
			Model model
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		EventInfo ei = eventSvc.getEvent(idx);
		model.addAttribute("event", ei);
		return "admin/super_event_update";
	}
	
	@RequestMapping(value = "/super_event_update_proc")
	public String adminEventUpdateProc(
			HttpServletRequest request,
			RedirectAttributes ra,
			EventVo ev
			) {
		String uploadPath = request.getSession().getServletContext().getRealPath("/");
		uploadPath = uploadPath.substring(0, uploadPath.length()-7)+Code_List.EVENT_IMG;
		int idx = eventSvc.eventUpdate(ev, uploadPath);
		ra.addAttribute("idx", idx);
		return "redirect:/super_event_view";
	}
}
