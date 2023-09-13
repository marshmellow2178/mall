package com.example.demo.dto;

import com.example.demo.entity.Artist;
import lombok.Getter;

@Getter
public class ArtistDto {
	private int idx;
	private String name;
	
	//entity to dto
	public ArtistDto(Artist ac) {
		this.idx = ac.getIdx();
		this.name = ac.getName();
	}
}
