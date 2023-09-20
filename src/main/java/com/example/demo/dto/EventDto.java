package com.example.demo.dto;

import java.time.LocalDateTime;
import com.example.demo.entity.EventInfo;
import lombok.Getter;

@Getter
public class EventDto {
	private int idx;
	private String title, img1, img2, status, type;
	private LocalDateTime date, sdate, edate;
	
	//entity to dto
	public EventDto(EventInfo ei) {
		this.idx = ei.getIdx();
		this.title = ei.getTitle();
		this.img1 = ei.getImg1();
		this.img2 = ei.getImg2();
		this.status = ei.getStatus();
		this.date = ei.getDate();
		this.sdate = ei.getSdate();
		this.edate = ei.getEdate();
		this.type = ei.getType();
	}

}
