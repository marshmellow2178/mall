package com.example.demo.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo.entity.Attendance;

public interface AttendanceRepo extends JpaRepository<Attendance, Long>{
	Attendance findTop1ByUseridxOrderByLoginDesc(int useridx);
	List<Attendance> findByUseridxAndLoginBetween(int useridx, LocalDateTime sdate, LocalDateTime edate);
}
