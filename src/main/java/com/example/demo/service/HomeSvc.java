package com.example.demo.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.example.demo.entity.EventInfo;
import com.example.demo.entity.ProductInfo;
import com.example.demo.repository.EventRepo;
import com.example.demo.repository.ProductRepo;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class HomeSvc {
	private final EventRepo eventRepo;
	private final ProductRepo productRepo;
	
	public List<EventInfo> getSliderList(){
		List<EventInfo> eventList = 
				eventRepo.findTop5ByOrderByEdateDesc();
		return eventList;
	}
	
	public List<ProductInfo> getNewList(){
		return productRepo.findTop8ByIsviewNotOrderByDateDesc("n");
	}
	
	public List<ProductInfo> getSaleList(){
		return productRepo.findTop8ByIsviewNotOrderByDcDesc("n");
	}
}
