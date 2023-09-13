package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.demo.entity.MemberInfo;

@Repository
public interface MemberRepo extends JpaRepository<MemberInfo, Long>{
	
	MemberInfo findByIdAndPw(String id, String pw);
	MemberInfo findById(String id);
	MemberInfo findByIdx(int idx);
	
	Long countById(String id);
	Long countByEmail(String email);
	
	Page<MemberInfo> findByIdContains(String id, Pageable pageable);
}
