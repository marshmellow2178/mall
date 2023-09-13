package com.example.demo.dto;

import org.springframework.data.domain.Page;
import lombok.*;

@Getter
public class PageInfo {
	private int cpage, psize, bsize, pcnt, spage; 
	private long rcnt;
	//현재페이지, 페이지당 레코드수, 블록당 페이지수, 전체레코드수, 페이지수, 블록 시작페이지
	
	public <T> void setPage(Page<T> page) {
		this.cpage = page.getNumber()+1;
		this.psize = page.getSize();
		this.bsize = 10;
		this.pcnt = page.getTotalPages();
		this.rcnt = page.getTotalElements();
		this.spage = ((cpage -1)/bsize * bsize+1);
	}
}
