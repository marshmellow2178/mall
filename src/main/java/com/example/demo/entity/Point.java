package com.example.demo.entity;

import java.time.LocalDateTime;
import javax.persistence.*;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "t_member_point")
public class Point {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "mp_idx")
	private int idx;

	@Column(name = "mi_id")
	private String id;
	
	@Column(name = "mp_point")
	private int point;
	
	@Column(name = "mp_desc")
	private String desc;
	
	@Column(name = "mp_su")
	private String su;
	
	@Column(name = "mp_date")
	private LocalDateTime date;
	
	
	@Builder
	public Point(int idx, String id, int point, String desc, String su, LocalDateTime date) {
		this.idx = idx;
		this.id = id;
		this.point = point;
		this.desc = desc;
		this.su = su;
		this.date = date;
	}
}
