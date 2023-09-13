package com.example.demo.dto;

import com.example.demo.entity.OrderDetail;
import lombok.Getter;

@Getter
public class OrderDetailDto {
	private int idx, order_idx, cnt, price;
	private String product, option, img;
	
	public OrderDetailDto(OrderDetail od) {
		this.idx = od.getIdx();
		this.order_idx = od.getOiidx();
		this.cnt = od.getCnt();
		this.price = od.getPrice();
		this.product = od.getProduct();
		this.option = od.getOption();
		this.img = od.getImg();
	}
}
