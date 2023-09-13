package com.example.demo.dto;

import java.time.LocalDateTime;

import com.example.demo.entity.InquiryAnswer;

import lombok.Getter;

@Getter
public class InquiryAnswerDto {
	private int idx, bm;
	private String comment;
	private LocalDateTime date;
	
	public InquiryAnswerDto(InquiryAnswer ia) {
		this.idx = ia.getIdx();
		this.bm = ia.getBm();
		this.comment = ia.getComment();
		this.date = ia.getDate();
	}
}
