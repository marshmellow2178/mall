package com.example.demo.controller;

import org.springframework.data.domain.*;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.dto.AdminDto;
import com.example.demo.dto.PageInfo;
import com.example.demo.entity.*;
import com.example.demo.global.Code_List;
import com.example.demo.service.ProductSvc;
import com.example.demo.vo.ProductInfoVo;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ProductCtrl {
	
	private final ProductSvc productSvc;

	@RequestMapping(value = "/product_list", method = RequestMethod.GET)
	public String productList(
			@RequestParam(value = "key", required = false)String key,
			@RequestParam(value = "artist", required = false)String artist,
			@RequestParam(value = "type", required = false)String type,
			Model model, 
			@PageableDefault(size=20, sort="date", direction = Sort.Direction.DESC)Pageable pageable) {
		
		PageInfo pageInfo = new PageInfo();
		if(artist==null){ artist = ""; } 
		if(type==null){ type = ""; } 
		if(key==null){ key = ""; } 
		List<ProductInfo> productList = productSvc.productList(type, artist, key, pageable, pageInfo);
		List<Artist> artistList = productSvc.artistList();
		List<Type> typeList = productSvc.typeList();
				
		model.addAttribute("productList", productList);
		model.addAttribute("artistList", artistList);
		model.addAttribute("typeList", typeList);
		model.addAttribute("pageInfo", pageInfo);

		return "product/product_list";
	}
	
	@RequestMapping(value = "/product_view", method = RequestMethod.GET)
	public String productView(
			@RequestParam(value = "piid")int idx,
			Model model
	) {
		ProductInfo pi = productSvc.getProduct(idx);

		model.addAttribute("pi", pi);
		return "product/product_view";
	}
	
	@RequestMapping(value = "/super_product_list")
	public String adminProductList(
			HttpServletRequest request, 
			Model model,
			@RequestParam(value = "key", required = false)String key,
			@RequestParam(value = "artist", required = false)String artist,
			@RequestParam(value = "type", required = false)String type,
			@PageableDefault(size=20, sort="date", direction = Sort.Direction.DESC)Pageable pageable
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		PageInfo pageInfo = new PageInfo();
		if(artist==null){ artist = ""; } 
		if(type==null){ type = ""; } 
		if(key==null){ key = ""; } 
		List<ProductInfo> productList = productSvc.adminProductList(type, artist, key, pageable, pageInfo);
		List<Artist> artistList = productSvc.artistList();
		List<Type> typeList = productSvc.typeList();
				
		model.addAttribute("productList", productList);
		model.addAttribute("artistList", artistList);
		model.addAttribute("typeList", typeList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/super_product_list";
	}
	
	@RequestMapping(value = "/super_product_view")
	public String adminProductView(
			HttpServletRequest request, 
			@RequestParam(value= "piid") int piid,
			Model model
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		ProductInfo pi = productSvc.adminGetProduct(piid);
		model.addAttribute("pi", pi);
		return "admin/super_product_view";
	}
	
	@RequestMapping(value = "/super_product_register")
	public String adminProductRegister(
			HttpServletRequest request,
			Model model
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		
		List<Artist> artistList = productSvc.artistList();
		List<Type> typeList = productSvc.typeList();
		model.addAttribute("artistList", artistList);
		model.addAttribute("typeList", typeList);
		return "admin/super_product_register";
	}
	
	@RequestMapping(value = "/super_product_proc")
	public String adminProductProc(
			HttpServletRequest request, 
			ProductInfoVo piv,
			RedirectAttributes ra
			) {
		String uploadPath = request.getSession().getServletContext().getRealPath("/");
		uploadPath = uploadPath.substring(0, uploadPath.length()-7)+Code_List.PRODUCT_IMG;
		int piid = productSvc.productRegister(piv, uploadPath);
		
		ra.addAttribute("piid", piid);
		return "redirect:/super_product_view";
	}
	
	@RequestMapping(value = "/super_product_update")
	public String adminProductUpdate(
			HttpServletRequest request, 
			@RequestParam(value= "piid") int piid,
			Model model
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		ProductInfo pi = productSvc.adminGetProduct(piid);
		List<Artist> artistList = productSvc.artistList();
		List<Type> typeList = productSvc.typeList();
		model.addAttribute("artistList", artistList);
		model.addAttribute("typeList", typeList);
		model.addAttribute("pi", pi);
		return "admin/super_product_update";
	}
	
	@RequestMapping(value = "/super_product_update_proc")
	public String adminProductUpdateProc(
			HttpServletRequest request, 
			ProductInfoVo piv,
			RedirectAttributes ra
			) {
		String uploadPath = request.getSession().getServletContext().getRealPath("/");
		uploadPath = uploadPath.substring(0, uploadPath.length()-7)+Code_List.PRODUCT_IMG;
		int piid = productSvc.productUpdate(piv, uploadPath);
		
		ra.addAttribute("piid", piid);
		return "redirect:/super_product_view";
	}
	
	@RequestMapping(value = "/super_artist_list")
	public String adminArtistList(
			Model model,
			@RequestParam(value = "key", required = false)String key,
			@PageableDefault(size=10, sort="idx", direction = Sort.Direction.DESC)Pageable pageable
			) {
		PageInfo pageInfo = new PageInfo();
		if(key==null){ key = ""; } 
		
		List<Artist> artistList = productSvc.adminArtistList(key, pageable, pageInfo);
		model.addAttribute("artistList", artistList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/super_artist_list";
	}
	
	@RequestMapping(value = "/super_artist_register")
	public String adminArtistRegister(
			HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		return "admin/super_artist_register";
	}
	
	@RequestMapping(value = "/super_artist_register_proc")
	public String adminArtistRegisterProc(
			@RequestParam(value = "name") String name
			) {
		productSvc.artistRegister(name);
		return "redirect:/super_artist_list";
	}
	
	@RequestMapping(value = "/super_artist_update")
	public String adminArtistUpdate(
			HttpServletRequest request,
			Model model,
			@RequestParam(value = "idx") Integer idx
			) {
		HttpSession session = request.getSession();
		AdminDto adminInfo = (AdminDto)session.getAttribute("adminInfo");
		if(adminInfo==null) {
			return "redirect:/super_login";
		}
		Artist a = productSvc.getArtist(idx);
		model.addAttribute("artist", a);
		return "admin/super_artist_update";
	}
	
	@RequestMapping(value = "/super_artist_update_proc")
	public String adminArtistUpdateProc(
			@RequestParam(value = "name") String name,
			@RequestParam(value = "idx") Integer idx
			) {
		productSvc.artistUpdate(name, idx);
		return "redirect:/super_artist_list";
	}
}
