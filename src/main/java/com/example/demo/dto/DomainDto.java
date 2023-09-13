package com.example.demo.dto;

import com.example.demo.entity.Domain;
import lombok.Getter;

@Getter
public class DomainDto {
	private int idx;
	private String id;
	
	public DomainDto(Domain d) {
		this.idx = d.getIdx();
		this.id = d.getId();
	}
}
