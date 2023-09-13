package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.Artist;

public interface ArtistRepo extends JpaRepository<Artist, Long> {
	Page<Artist> findByNameContains(String key, Pageable pageable);
	Artist findByIdx(int idx);
}
