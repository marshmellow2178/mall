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
@Table(name = "t_bbs_notice")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Notice {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "bn_idx")
	private int idx;
	
	@Column(name = "bn_ctgr")
	private String ctgr;
	
	@Column(name = "bn_title")
	private String title;
	
	@Column(name = "bn_content")
	private String content;
	
	@Column(name = "bn_date")
	private LocalDateTime date;

	public void setCtgr(String ctgr) {
		this.ctgr = ctgr;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Builder
	public Notice(int idx, String ctgr, String title, String content, LocalDateTime date) {
		super();
		this.idx = idx;
		this.ctgr = ctgr;
		this.title = title;
		this.content = content;
		this.date = date;
	}
}
