package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.Notice;

public interface NoticeRepo extends JpaRepository<Notice, Long>{
	Page<Notice> findByCtgrContainingAndTitleContaining(String ctgr, String key, Pageable pageable);
	Notice findByIdx(int idx);
}
