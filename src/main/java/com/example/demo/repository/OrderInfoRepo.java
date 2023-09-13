package com.example.demo.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.example.demo.entity.OrderInfo;

public interface OrderInfoRepo extends PagingAndSortingRepository<OrderInfo, Long>{
	OrderInfo findByIdx(int idx);
	Page<OrderInfo> findByMiid(Pageable pageable, String miid);
}
