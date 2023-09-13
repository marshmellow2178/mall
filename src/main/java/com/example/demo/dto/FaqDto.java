package com.example.demo.dto;

import com.example.demo.entity.Faq;
import lombok.Getter;

@Getter
public class FaqDto {
	private int idx;
	private String ctgr, title, answer;
	
	public FaqDto(Faq faq) {
		this.idx = faq.getIdx();
		this.ctgr = faq.getCtgr();
		this.title = faq.getTitle();
		this.answer = faq.getAnswer();
	}
}
