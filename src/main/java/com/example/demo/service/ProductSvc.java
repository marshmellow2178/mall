package com.example.demo.service;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import com.example.demo.dto.PageInfo;
import com.example.demo.entity.Artist;
import com.example.demo.entity.ProductInfo;
import com.example.demo.entity.Type;
import com.example.demo.repository.ArtistRepo;
import com.example.demo.repository.ProductRepo;
import com.example.demo.repository.TypeRepo;
import com.example.demo.vo.ProductInfoVo;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ProductSvc {
	private final ProductRepo productRepo;
	private final ArtistRepo artistRepo;
	private final TypeRepo typeRepo;
	
	public List<Artist> artistList() {
		return artistRepo.findAll();
	}
	
	public List<Type> typeList() {
		return typeRepo.findAll();
	}
	
	public List<ProductInfo> productList(String type, String artist, String key, Pageable pageable, PageInfo pageInfo ) {
		Page<ProductInfo> productPage = productRepo.findByTypeContainsAndArtistContainsAndNameContainsAndIsviewNot(type, artist, 
				key, "n", pageable);
		pageInfo.setPage(productPage);
		List<ProductInfo> productList = productPage.getContent();
		return productList;
	}
	
	public List<ProductInfo> adminProductList(String type, String artist, String key, Pageable pageable, PageInfo pageInfo ) {
		Page<ProductInfo> productPage = productRepo.findByTypeContainsAndArtistContainsAndNameContains(type, artist, 
				key, pageable);
		pageInfo.setPage(productPage);
		List<ProductInfo> productList = productPage.getContent();
		return productList;
	}
	
	public ProductInfo getProduct(int idx) {
		return productRepo.findByIdxAndIsview(idx, "y");
	}
	
	public ProductInfo adminGetProduct(int idx) {
		return productRepo.findByIdx(idx);
	}
	
	public int productRegister(ProductInfoVo piv, String uploadPath) {
		ProductInfo pi = ProductInfo.builder()
				.name(piv.getName())
				.img(piv.getImgName())
				.desc(piv.getDescName())
				.artist(piv.getArtist())
				.type(piv.getType())
				.price(piv.getPrice())
				.dc(piv.getDc())
				.stock(piv.getStock())
				.isview(piv.getIsview())
				.date(LocalDateTime.now())
				.build();
		
		try {
			if(piv.getImgName()!=null && !piv.getImgName().equals("")) {
				piv.getImg().transferTo(new File(uploadPath, piv.getImgName()));
			}
			if(piv.getDesc()!=null && !piv.getDescName().equals("")) {
				piv.getDesc().transferTo(new File(uploadPath, piv.getDescName()));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		int idx = productRepo.save(pi).getIdx();
		return idx;
	}
	
	public int productUpdate(ProductInfoVo piv, String uploadPath) {
		ProductInfo old = productRepo.findByIdx(piv.getIdx());
		try {
			if(piv.getImgName()!=null && !piv.getImgName().equals("")) {
				piv.getImg().transferTo(new File(uploadPath, piv.getImgName()));
			}else {
				piv.setImgName(old.getImg());
			}
			if(piv.getDescName()!=null && !piv.getDescName().equals("")) {
				piv.getDesc().transferTo(new File(uploadPath, piv.getDescName()));
			}else {
				piv.setDescName(old.getDesc());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		ProductInfo pi = ProductInfo.builder()
				.idx(piv.getIdx())
				.name(piv.getName())
				.img(piv.getImgName())
				.desc(piv.getDescName())
				.artist(piv.getArtist())
				.type(piv.getType())
				.price(piv.getPrice())
				.dc(piv.getDc())
				.stock(piv.getStock())
				.isview(piv.getIsview())
				.date(LocalDateTime.now())
				.build();
		
		int idx = productRepo.save(pi).getIdx();
		return idx;
	}
	
	public List<Artist> adminArtistList(String key, Pageable pageable, PageInfo pageInfo){
		Page<Artist> artistPage =  artistRepo.findByNameContains(key, pageable);
		pageInfo.setPage(artistPage);
		return artistPage.getContent();
	}
	
	public void artistRegister(String name) {
		Artist a = Artist.builder()
				.name(name)
				.build();
		artistRepo.save(a);
	}
	
	public Artist getArtist(int idx) {
		return artistRepo.findByIdx(idx);
	}
	
	public void artistUpdate(String name, int idx) {
		Artist a = Artist.builder()
				.idx(idx)
				.name(name)
				.build();
		artistRepo.save(a);
	}
}
