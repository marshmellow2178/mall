package com.example.demo.entity;

import java.time.LocalDateTime;
import javax.persistence.*;
import org.hibernate.annotations.DynamicUpdate;
import lombok.*;

@Entity
@Getter
@DynamicUpdate
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "t_member_info")
public class MemberInfo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "mi_idx")
	private int idx;
	
	@Setter
	@Column(name = "mi_id")
	private String id;
	
	@Setter
	@Column(name = "mi_pw")
	private String pw;

	@Column(name = "mi_name")
	private String name;
	
	@Setter
	@Column(name = "mi_phone")
	private String phone;
	
	@Setter
	@Column(name = "mi_email")
	private String email;
	
	@Setter
	@Column(name = "mi_domain")
	private String domain;
	
	@Setter
	@Column(name = "mi_addr1")
	private String addr1;
	
	@Setter
	@Column(name = "mi_addr2")
	private String addr2;
	
	@Setter
	@Column(name = "mi_status")
	private String status;
	
	@Setter
	@Column(name = "mi_point")
	private int point;
	
	@Column(name = "mi_joindate")
	private LocalDateTime joindate;
	
	@Setter
	@Column(name = "mi_lastlogin")
	private LocalDateTime lastlogin;
	
	public void givePoint(int point) {
		this.point += point;
		System.out.println(this.point);
	}
	
	@Builder
	public MemberInfo(int idx, String id, String pw, String name, String phone, String email, String domain,
			String addr1, String addr2, String status, int point, LocalDateTime joindate, LocalDateTime lastlogin) {
		super();
		this.idx = idx;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.domain = domain;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.status = status;
		this.point = point;
		this.joindate = joindate;
		this.lastlogin = lastlogin;
	}
}
