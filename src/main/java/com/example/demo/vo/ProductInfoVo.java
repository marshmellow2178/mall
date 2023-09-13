package com.example.demo.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;

@Getter
public class ProductInfoVo {
	private String name, artist, isview, type;
	private int idx, price, dc, stock;
	private MultipartFile img, desc;
	private String imgName, descName;
	
	public void setImgName(String name) {
		this.imgName = name;
	}
	public void setDescName(String name) {
		this.descName = name;
	}
	
	public ProductInfoVo(String type, int idx, String name, String artist, String isview, int price, int dc,
			int stock, MultipartFile img, MultipartFile desc) {
		super();
		this.type = type;
		this.idx = idx;
		this.name = name;
		this.artist = artist;
		this.isview = isview;
		this.price = price;
		this.dc = dc;
		this.stock = stock;
		this.img = img;
		this.desc = desc;
		this.imgName =img.getOriginalFilename();
		this.descName = desc.getOriginalFilename();
	}
}
