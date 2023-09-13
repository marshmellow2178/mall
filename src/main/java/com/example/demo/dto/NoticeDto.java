package com.example.demo.dto;

import java.time.LocalDateTime;

import com.example.demo.entity.Notice;

import lombok.Getter;

@Getter
public class NoticeDto {
	private int idx;
	private String ctgr, title, content;
	private LocalDateTime date;
	
	public Notice insertRequest() {
		return Notice.builder()
				.content(content)
				.ctgr(ctgr)
				.title(title)
				.date(LocalDateTime.now())
				.build();
	}

	public NoticeDto(Notice notice) {
		this.idx = notice.getIdx();
		this.ctgr = notice.getCtgr();
		this.title = notice.getTitle();
		this.content = notice.getContent();
		this.date = notice.getDate();
	}
}
