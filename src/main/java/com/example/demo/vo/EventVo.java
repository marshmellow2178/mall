package com.example.demo.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;

@Getter
public class EventVo {
	private int idx;
	private String title, img1Name, img2Name;
	private MultipartFile img1, img2;
	
	public void setImg1Name(String name) {
		this.img1Name = name;
	}
	public void setImg2Name(String name) {
		this.img2Name = name;
	}
	
	public EventVo(int idx, String title, MultipartFile img1, MultipartFile img2) {
		super();
		this.idx = idx;
		this.title = title;
		this.img1 = img1;
		this.img2 = img2;
		this.img1Name = img1.getOriginalFilename();
		this.img2Name = img2.getOriginalFilename();
	}
}
