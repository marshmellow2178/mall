package com.example.demo.vo;

import lombok.Getter;

@Getter
public class MemberUpdateVo {

	private String id, phone, email, domain, addr1, addr2, agree;

	public MemberUpdateVo(String id, String phone, String email, String domain, String addr1, String addr2, String agree) {
		super();
		this.id = id;
		this.phone = phone;
		this.email = email;
		this.domain = domain;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.agree = agree;
	}
}
