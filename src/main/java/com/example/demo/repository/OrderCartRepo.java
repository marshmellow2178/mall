package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.OrderCart;

public interface OrderCartRepo extends JpaRepository<OrderCart, Long> {
	List<OrderCart> findByMiid(String miid);
	OrderCart findByMiidAndPiid(String miid, int piid);
	OrderCart findByIdx(int idx);
	int deleteByIdx(int idx);
}
