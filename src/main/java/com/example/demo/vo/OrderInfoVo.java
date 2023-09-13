package com.example.demo.vo;

import lombok.Getter;

@Getter
public class OrderInfoVo {
	private String miid, name, phone, addr1, addr2, payment, pay, upoint, spoint;
	
	public OrderInfoVo(String miid, String name, String phone, String addr1, String addr2, String payment, String pay,
			String upoint, String spoint) {
		super();
		this.miid = miid;
		this.name = name;
		this.phone = phone;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.payment = payment;
		this.pay = pay;
		this.upoint = upoint;
		this.spoint = spoint;
	}
	
	
}
