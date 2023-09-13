package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.OrderDetail;

public interface OrderDetailRepo extends JpaRepository<OrderDetail, Long>{
	List<OrderDetail> findByOiidx(int oiidx);
}
