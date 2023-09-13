package com.example.demo.dto;

import java.time.LocalDateTime;
import com.example.demo.entity.Admin;
import lombok.Getter;

@Getter
public class AdminDto {
	private int idx;
	private String id, pw, name, use;
	private LocalDateTime date;
	
	//entity to dto
	public AdminDto(Admin ad) {
		this.idx = ad.getIdx();
		this.id = ad.getId();
		this.pw = ad.getPw();
		this.name = ad.getName();
		this.use = ad.getUse();
		this.date = ad.getDate();
	}
}
