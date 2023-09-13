package com.example.demo.dto;

import java.time.LocalDateTime;
import com.example.demo.entity.MemberInfo;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MemberInfoDto {
	private String id, pw, name;
	private LocalDateTime lastlogin;
	private int point, idx;
	private String phone, email, domain, addr1, addr2;
	private String status;
	private LocalDateTime joindate;
	
	//entity to dto 
	public MemberInfoDto(MemberInfo mi) {
		this.idx = mi.getIdx();
		this.id = mi.getId();
		this.pw = mi.getPw();
		this.name = mi.getName();
		this.point = mi.getPoint();
		this.phone = mi.getPhone();
		this.email = mi.getEmail();
		this.domain = mi.getDomain();
		this.addr1 = mi.getAddr1();
		this.addr2 = mi.getAddr2();
		this.joindate = mi.getJoindate();
		this.status = mi.getStatus();
	}
}
