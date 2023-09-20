package com.example.demo.entity;

import java.time.LocalDateTime;
import javax.persistence.*;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "t_bbs_event")
public class EventInfo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "be_idx")
	private int idx;
	
	@Column(name = "be_title")
	private String title;
	
	@Column(name = "be_img1")
	private String img1;
	
	@Column(name = "be_img2")
	private String img2;
	
	@Column(name = "be_date")
	private LocalDateTime date;
	
	@Column(name = "be_sdate")
	private LocalDateTime sdate;
	
	@Column(name = "be_edate")
	private LocalDateTime edate;
	
	@Column(name = "be_status")
	private String status;
	
	@Column(name = "admin")
	private int admin;
	
	@Column(name = "content")
	private String content;
	
	@Column(name = "type")
	private String type;

	@Builder
	public EventInfo(int idx, String title, String img1, String img2, LocalDateTime date,
			LocalDateTime sdate, LocalDateTime edate, String status, int admin, String content, String type) {
		this.idx = idx;
		this.title = title;
		this.img1 = img1;
		this.img2 = img2;
		this.date = date;
		this.sdate = sdate;
		this.edate = edate;
		this.status = status;
		this.admin = admin;
		this.content = content;
		this.type = type;
	}

}
