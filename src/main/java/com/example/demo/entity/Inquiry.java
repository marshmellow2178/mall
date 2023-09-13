package com.example.demo.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.DynamicUpdate;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@DynamicUpdate
@Table(name = "t_bbs_mantoman")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Inquiry {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "bm_idx")
	private int idx;
	
	@Column(name = "mi_id")
	private String miid;
	
	@Column(name = "bm_ctgr")
	private String ctgr;
	
	@Column(name = "bm_title")
	private String title;
	
	@Column(name = "bm_content")
	private String content;
	
	@Column(name = "bm_date")
	private LocalDateTime date;
	
	@Column(name = "bf_isend")
	private String isend;
	
	public void setIsend(String isend) {
		this.isend = isend;
	}

	@Builder
	public Inquiry(int idx, String miid, String ctgr, String title, String content, 
			LocalDateTime date, String isend) {
		super();
		this.idx = idx;
		this.miid = miid;
		this.ctgr = ctgr;
		this.title = title;
		this.content = content;
		this.date = date;
		this.isend = isend;
	}
}
