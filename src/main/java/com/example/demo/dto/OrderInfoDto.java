package com.example.demo.dto;

import java.time.LocalDateTime;

import com.example.demo.entity.OrderInfo;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor //폼 데이터 바로 받을때
public class OrderInfoDto {
	private String miid, name, phone, addr1, addr2, payment, status;
	private int idx, pay, upoint, spoint;
	private LocalDateTime date;
	
	//entity to dto
	public OrderInfoDto(OrderInfo oi) {
		this.idx = oi.getIdx();
		this.miid = oi.getMiid();
		this.name = oi.getName();
		this.phone = oi.getPhone();
		this.addr1 = oi.getAddr1();
		this.addr2 = oi.getAddr2();
		this.payment = oi.getPayment();
		this.status = oi.getStatus();
		this.pay = oi.getPay();
		this.upoint = oi.getUpoint();
		this.spoint = oi.getSpoint();
		this.date = oi.getDate();
	}
}
