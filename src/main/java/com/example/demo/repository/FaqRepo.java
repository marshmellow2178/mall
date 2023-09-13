package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.Faq;

public interface FaqRepo extends JpaRepository<Faq, Long>{
	Page<Faq> findByCtgrContainingAndTitleContaining(String ctgr, String title, Pageable pageable);
	Faq findByIdx(int idx);
}
