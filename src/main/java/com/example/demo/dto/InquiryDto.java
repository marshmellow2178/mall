package com.example.demo.dto;

import java.time.LocalDateTime;
import com.example.demo.entity.Inquiry;
import lombok.Getter;

@Getter
public class InquiryDto {
	private int idx;
	private String miid, ctgr, title, content, isend;
	private LocalDateTime date;
	
	public InquiryDto(Inquiry i) {
		this.idx = i.getIdx();
		this.miid = i.getMiid();
		this.ctgr = i.getCtgr();
		this.title = i.getTitle();
		this.content = i.getContent();
		this.isend = i.getIsend();
		this.date = i.getDate();
	}
}
