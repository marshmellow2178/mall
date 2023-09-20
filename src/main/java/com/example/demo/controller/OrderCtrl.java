package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.AdminDto;
import com.example.demo.dto.MemberInfoDto;
import com.example.demo.dto.OrderCartDto;
import com.example.demo.dto.PageInfo;
import com.example.demo.entity.OrderDetail;
import com.example.demo.entity.OrderInfo;
import com.example.demo.service.OrderSvc;
import com.example.demo.vo.OrderInfoVo;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class OrderCtrl {
	public final OrderSvc orderSvc;

	@RequestMapping(value = "/order_form")
	public String orderForm(
		HttpServletRequest request,
		RedirectAttributes ra,
		@RequestParam("kind")String kind,
		@RequestParam(value = "chk", required=false)String[] chk,
		@RequestParam(value = "piid", required = false) Integer piid,
		@RequestParam(value = "psidx", required = false) Integer psidx,
		@RequestParam(value = "cnt", required = false) Integer cnt,
		Model model
			) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		
		List<OrderCartDto> ocdList = new ArrayList<OrderCartDto>();
		if(kind.equals("c")) {
			ocdList = orderSvc.getProductList(chk);
		}else {
			ocdList.add(orderSvc.getProduct(0, mi.getId(), piid, cnt));
		} 
		model.addAttribute("ocdList", ocdList);
		model.addAttribute("kind", kind);
		return "order/order_form";
	}

	@RequestMapping(value = "/order_proc_in", method = RequestMethod.POST)
	public String orderProcIn(
			OrderInfoVo oiv,
			@RequestParam("ocidx") Integer[] ocidx,
			@RequestParam("piid") Integer[] piid,
			@RequestParam("cnt") Integer[] cnt,
			HttpServletRequest request,
			RedirectAttributes ra
		) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		List<OrderCartDto> ocdList = new ArrayList<OrderCartDto>();
		for(int i = 1;i<piid.length;i++) {
			OrderCartDto ocd = orderSvc.getProduct(ocidx[i], mi.getId(), piid[i], cnt[i]);
			ocdList.add(ocd);
		}
		int oiidx = orderSvc.orderInsert(oiv, ocdList);
		ra.addAttribute("oiidx", oiidx);
		return "redirect:order_detail";
	}
	
	@RequestMapping(value = "/order_detail")
	public String orderDetail(@RequestParam("oiidx") int oiidx, HttpServletRequest request, RedirectAttributes ra, Model model) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		OrderInfo oi = orderSvc.getOrderInfo(oiidx);
		List<OrderDetail> dl = orderSvc.getOrderDetail(oiidx);
		model.addAttribute("oi", oi);
		model.addAttribute("dl", dl);
		return "mypage/order_detail";
	}

	@RequestMapping(value = "/order_list")
	public String orderList(
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
		List<OrderInfo> orderlist = orderSvc.getOrderList(mi.getId(), pageable, pageInfo);
		model.addAttribute("orderlist", orderlist);
		model.addAttribute("pageInfo", pageInfo);
		return "mypage/order_list";
	}
	
	@RequestMapping(value = "/super_order_list")
	public String adminOrderList(
		@PageableDefault(size=10, sort="date", direction = Sort.Direction.DESC)Pageable pageable,	
		HttpServletRequest request,
		RedirectAttributes ra,
		Model model
		) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto) session.getAttribute("adminInfo");
		if(adminInfo==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/super_login";
		}
		
		PageInfo pageInfo = new PageInfo();
		List<OrderInfo> orderlist = orderSvc.getAdminOrderList(pageable, pageInfo);
		model.addAttribute("orderlist", orderlist);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/super_order_list";
	}
	
	@RequestMapping(value = "/super_order_update")
	public String adminOrderUpdate(
		@RequestParam(value = "idx") Integer idx,
		Model model
		){
		OrderInfo oi = orderSvc.getOrderInfo(idx);
		List<OrderDetail> odList = orderSvc.getOrderDetail(idx);
		
		model.addAttribute("oi", oi);
		model.addAttribute("odList", odList);
		return "admin/super_order_update";
	}
	
	@RequestMapping(value = "/super_order_update_proc")
	public String adminOrderProc(
			@RequestParam(value = "idx") Integer idx,
			@RequestParam(value = "status") String status,
			Model model
			) {
		orderSvc.setStatus(idx, status);
		return "redirect:/super_order_list";
	}
}
