package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.Inquiry;

public interface InquiryRepo extends JpaRepository<Inquiry, Long>{
	Page<Inquiry> findByMiidAndCtgrContainsAndTitleContains(String miid, String ctgr, String title, Pageable pageable);
	Page<Inquiry> findByCtgrContainsAndTitleContains(String ctgr, String title, Pageable pageable);
	Inquiry findByIdx(int idx);
}
