package com.example.demo.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.EventInfo;

public interface EventRepo extends JpaRepository<EventInfo, Long> {
	Page<EventInfo> findByTitleContaining(String title, Pageable pageable);
	EventInfo findByIdx(int idx);
	List<EventInfo> findTop5ByOrderByEdateDesc();
}
