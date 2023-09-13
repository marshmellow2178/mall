package com.example.demo.entity;

import javax.persistence.*;

import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "t_order_detail")
public class OrderDetail {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "od_idx")
	private int idx;
	
	@Column(name = "oi_idx")
	private int oiidx;
	
	@Column(name = "od_name")
	private String product;
	
	@Column(name = "od_ps")
	private String option;
	
	@Column(name = "od_cnt")
	private int cnt;
	
	@Column(name = "od_price")
	private int price;
	
	@Column(name = "od_img")
	private String img;

	@Builder
	public OrderDetail(int idx, int oiidx, String product, String option, int cnt, int price, String img) {
		super();
		this.idx = idx;
		this.oiidx = oiidx;
		this.product = product;
		this.option = option;
		this.cnt = cnt;
		this.price = price;
		this.img = img;
	}
}
