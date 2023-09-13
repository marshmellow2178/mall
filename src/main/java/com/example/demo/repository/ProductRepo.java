package com.example.demo.repository;

import java.util.List;

import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.ProductInfo;

public interface ProductRepo extends JpaRepository<ProductInfo, Long>{
	Page<ProductInfo> findByTypeContainsAndArtistContainsAndNameContainsAndIsviewNot(String type, String artist, 
			String name, String isview, Pageable pageable);
	
	Page<ProductInfo> findByTypeContainsAndArtistContainsAndNameContains(String type, String artist, 
			String name, Pageable pageable);
	
	ProductInfo findByIdxAndIsview(int idx, String isview);
	ProductInfo findByIdx(int idx);
	
	List<ProductInfo> findTop8ByIsviewNotOrderByDateDesc(String isview);
	List<ProductInfo> findTop8ByIsviewNotOrderByDcDesc(String isview);
}
