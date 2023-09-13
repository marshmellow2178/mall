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
@Table(name = "t_bbs_faq")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Faq {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "bf_idx")
	private int idx;
	
	@Column(name = "bf_ctgr")
	private String ctgr;
	
	@Column(name = "bf_content")
	private String title;
	
	@Column(name = "bf_answer")
	private String answer;

	@Column(name = "bf_date")
	private LocalDateTime date;
	
	public void setCtgr(String ctgr) {
		this.ctgr = ctgr;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Builder
	public Faq(int idx, String ctgr, String title, String content, String answer, LocalDateTime date) {
		super();
		this.idx = idx;
		this.ctgr = ctgr;
		this.title = title;
		this.answer = answer;
		this.date = date;
	}
}
