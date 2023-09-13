package com.example.demo.entity;

import java.time.LocalDateTime;
import javax.persistence.*;

import org.hibernate.annotations.DynamicUpdate;

import lombok.*;

@Entity
@Getter
@DynamicUpdate
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "t_product_info")
public class ProductInfo {
	@Id
	@Column(name = "pi_idx")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idx;
	
	@Column(name = "artist_name")
	private String artist;
	
	@Column(name = "type_name")
	private String type;
	
	@Column(name = "pi_name")
	private String name;
	
	@Column(name = "pi_price")
	private int price;
	
	@Column(name = "pi_dc")
	private int dc;
	
	@Column(name = "pi_img")
	private String img;
	
	@Column(name = "pi_desc")
	private String desc;
	
	@Column(name = "pi_isview")
	private String isview;
	
	@Column(name = "pi_date")
	private LocalDateTime date;
	
	@Column(name = "pi_stock")
	private int stock;
	
	@Column(name = "pi_sale")
	private int sale;
	
	public int getRealprice() {
		return this.price * (100 - this.dc)/100;
	}
	
	public void setSale(int cnt) {
		this.sale +=cnt;
	}
	
	public void setStock(int cnt) {
		this.stock -= cnt;
	}

	@Builder
	public ProductInfo(int idx, String artist, String type, String name, int price, int dc, String img, String desc,
			String isview, LocalDateTime date, int stock) {
		super();
		this.idx = idx;
		this.artist = artist;
		this.type = type;
		this.name = name;
		this.price = price;
		this.dc = dc;
		this.img = img;
		this.desc = desc;
		this.isview = isview;
		this.date = date;
		this.stock = stock;
	}
}
