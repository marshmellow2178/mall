package com.example.demo.vo;

import lombok.Getter;

@Getter
public class MemberInsertVo {

	private String name, id, pw, phone, email, domain, addr1, addr2, agree;
	
	public MemberInsertVo(String name, String id, String pw, String phone, String email, String domain, String addr1,
			String addr2, String agree) {
		super();
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.phone = phone;
		this.email = email;
		this.domain = domain;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.agree = agree;
	}
}
