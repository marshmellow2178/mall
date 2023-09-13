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
@Table(name = "t_admin_info")
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Admin {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "ai_idx")
	private int idx;
	
	@Column(name = "ai_id")
	private String id;
	
	@Column(name = "ai_pw")
	private String pw;
	
	@Column(name = "ai_name")
	private String name;
	
	@Column(name = "ai_use")
	private String use;
	
	@Column(name = "ai_date")
	private LocalDateTime date;

	@Builder
	public Admin(int idx, String id, String pw, String name, String use, LocalDateTime date) {
		super();
		this.idx = idx;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.use = use;
		this.date = date;
	}

}
