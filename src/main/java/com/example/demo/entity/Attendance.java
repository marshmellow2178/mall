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
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "attendance")
public class Attendance {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idx")
	private int idx;
	
	@Column(name = "login")
	private LocalDateTime login;
	
	@Column(name = "user_idx")
	private int useridx;
	
	@Column(name = "consecutive")
	private int consecutive;

	@Builder
	public Attendance(LocalDateTime login, int useridx, int consecutive) {
		this.login = login;
		this.useridx = useridx;
		this.consecutive = consecutive;
	}
}
