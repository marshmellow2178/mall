package com.example.demo.entity;

import java.time.LocalDateTime;
import javax.persistence.*;

import org.hibernate.annotations.DynamicUpdate;

import lombok.*;

@Entity
@Getter
@DynamicUpdate
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "t_order_info")
public class OrderInfo {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "oi_idx")
	private int idx;
	
	@Column(name = "mi_id")
	private String miid;
	
	@Column(name = "oi_name")
	private String name;
	
	@Column(name = "oi_phone")
	private String phone;
	
	@Column(name = "oi_addr1")
	private String addr1;
	
	@Column(name = "oi_addr2")
	private String addr2;
	
	@Column(name = "oi_payment")
	private String payment;
	
	@Column(name = "oi_pay")
	private int pay;
	
	@Column(name = "oi_upoint")
	private int upoint;
	
	@Column(name = "oi_spoint")
	private int spoint;

	@Column(name = "oi_status")
	private String status;
	
	@Column(name = "oi_date")
	private LocalDateTime date;

	public void setStatus(String status) {
		this.status = status;
	}
	
	@Builder
	public OrderInfo(int idx, String miid, String name, String phone, String addr1, String addr2, String payment,
			int pay, int upoint, int spoint, String status, LocalDateTime date) {
		super();
		this.idx = idx;
		this.miid = miid;
		this.name = name;
		this.phone = phone;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.payment = payment;
		this.pay = pay;
		this.upoint = upoint;
		this.spoint = spoint;
		this.status = status;
		this.date = date;
	}
}
