package com.example.demo.dto;

import java.time.LocalDateTime;
import com.example.demo.entity.Point;
import lombok.Getter;

@Getter
public class PointDto {
	private String id, desc, su;
	private int idx, point;
	private LocalDateTime date;
	
	public PointDto(Point p) {
		this.idx = p.getIdx();
		this.id = p.getId();
		this.point = p.getPoint();
		this.su = p.getSu();
		this.desc = p.getDesc();
		this.date = p.getDate();
	}

}
