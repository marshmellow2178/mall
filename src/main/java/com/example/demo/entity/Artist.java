package com.example.demo.entity;

import javax.persistence.*;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "artist")
public class Artist {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "artist_idx")
	private int idx;
	
	@Column(name = "artist_name")
	private String name;

	@Builder
	public Artist(int idx, String name) {
		super();
		this.idx = idx;
		this.name = name;
	}
}
