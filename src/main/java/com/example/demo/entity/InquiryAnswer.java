package com.example.demo.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Table(name = "t_bbs_mantoman_answer")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class InquiryAnswer {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "bma_idx")
	private int idx;
	
	@Column(name = "bm_idx")
	private int bm;
	
	@Column(name = "bma_coment")
	private String comment;
	
	@Column(name = "bma_date")
	private LocalDateTime date;

	@Builder
	public InquiryAnswer(int idx, int bm, String comment, LocalDateTime date) {
		super();
		this.idx = idx;
		this.bm = bm;
		this.comment = comment;
		this.date = date;
	}
}
