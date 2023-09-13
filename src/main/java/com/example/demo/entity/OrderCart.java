package com.example.demo.entity;

import javax.persistence.*;

import org.hibernate.annotations.DynamicUpdate;

import lombok.*;

@Entity
@Getter
@DynamicUpdate
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "t_order_cart")
public class OrderCart {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "oc_idx")
	private int idx;
	
	@Column(name = "mi_id")
	private String miid;
	
	@Column(name = "pi_id")
	private int piid;
	
	@Setter
	@Column(name = "oc_cnt")
	private int cnt;
	
	@Builder
	public OrderCart(int idx, String miid, int piid, int cnt) {
		super();
		this.idx = idx;
		this.miid = miid;
		this.piid = piid;
		this.cnt = cnt;
	}
}
