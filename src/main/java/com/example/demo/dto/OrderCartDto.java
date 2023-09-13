package com.example.demo.dto;

import com.example.demo.entity.OrderCart;
import lombok.Builder;
import lombok.Getter;

@Getter
public class OrderCartDto {
	private int idx, cnt, pi_id;
	private String mi_id;
	
	private String pi_name, pi_img, artist_name;
	private int price, dc, realprice;

	//entity to dto
	public OrderCartDto(OrderCart oc) {
		this.idx = oc.getIdx();
		this.cnt = oc.getCnt();
		this.pi_id = oc.getPiid();
		this.mi_id = oc.getMiid();
	}

	@Builder
	public OrderCartDto(int idx, int cnt, int pi_id, String mi_id, String pi_name,
			String option_name, String pi_img, String artist_name, int price, int dc) {
		super();
		this.idx = idx;
		this.cnt = cnt;
		this.pi_id = pi_id;
		this.mi_id = mi_id;
		this.pi_name = pi_name;
		this.pi_img = pi_img;
		this.artist_name = artist_name;
		this.price = price;
		this.dc = dc;
		this.realprice = price * (100-dc)/100;
	}
}
