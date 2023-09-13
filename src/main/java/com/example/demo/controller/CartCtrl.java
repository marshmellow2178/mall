package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.MemberInfoDto;
import com.example.demo.dto.OrderCartDto;
import com.example.demo.service.CartSvc;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CartCtrl {

	private final CartSvc cartSvc;
	
	@RequestMapping(value = "/cart_proc_in", method = RequestMethod.POST)
	@ResponseBody
	public void CartProcIn(
			HttpServletRequest request,
			@RequestParam(value = "piid") Integer piid,
			@RequestParam(value = "cnt") Integer cnt
			){
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		cartSvc.cartInsert(mi.getId(), piid, cnt);
	}
	
	@RequestMapping(value = "/cart_proc_up", method = RequestMethod.POST)
	@ResponseBody
	public void CartProcUp(
			@RequestParam("ocidx") Integer oc_idx,
			@RequestParam("cnt") Integer cnt){
		cartSvc.cartUpdate(oc_idx, cnt);
	}
	
	@RequestMapping(value = "/cart_proc_del", method = RequestMethod.POST)
	@ResponseBody
	public void CartProcDel(@RequestParam("ocidx") String ocidx){
		cartSvc.cartDelete(ocidx);
	}
	
	@RequestMapping(value = "/cart_view", method = RequestMethod.GET)
	public String CartView(HttpServletRequest request, RedirectAttributes ra, Model model) {
		HttpSession session = request.getSession();
		MemberInfoDto mi = (MemberInfoDto) session.getAttribute("loginInfo");
		if(mi==null) {
			String url = request.getServletPath().substring(1);
			ra.addAttribute("url", url);
			return "redirect:/login_form";
		}
		
		List<OrderCartDto> cartList = cartSvc.cartView(mi.getId());
		model.addAttribute("cartList", cartList);
		return "order/cart_view";
	}
}
