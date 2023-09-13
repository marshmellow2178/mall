package com.example.demo.dto;

import java.time.LocalDateTime;

import com.example.demo.entity.ProductInfo;

import lombok.Getter;

@Getter
public class ProductInfoDto {
	private String  name, img, desc;
	private String isview, artist, type;
	private int price, dc, sale, idx;
	private LocalDateTime date;
	private int realprice;
	
	public ProductInfoDto(ProductInfo pi) {
		this.idx = pi.getIdx();
		this.name = pi.getName();
		this.price = pi.getPrice();
		this.dc = pi.getDc();
		this.img = pi.getImg();
		this.desc = pi.getDesc();
		this.isview = pi.getIsview();
		this.artist = pi.getArtist();
		this.type = pi.getType();
		this.date = pi.getDate();
		this.sale = pi.getSale();
		this.realprice = pi.getRealprice();
	}
}
