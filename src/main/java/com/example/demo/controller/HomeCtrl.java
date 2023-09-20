package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.demo.entity.EventInfo;
import com.example.demo.entity.ProductInfo;
import com.example.demo.service.HomeSvc;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeCtrl {
	
	private final HomeSvc homeSvc; 
	
	@RequestMapping(value = {"/", "/index"}, method = RequestMethod.GET)
    public String home(
    		Model model
    		) {
		List<EventInfo> el = homeSvc.getSliderList();
		List<ProductInfo> newList = homeSvc.getNewList();
		List<ProductInfo> saleList = homeSvc.getSaleList();

		model.addAttribute("el", el);
		model.addAttribute("newList", newList);
		model.addAttribute("saleList", saleList);
        return "index";
    }
}
