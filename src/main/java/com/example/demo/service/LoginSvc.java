package com.example.demo.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Random;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.dto.MemberInfoDto;
import com.example.demo.entity.Attendance;
import com.example.demo.entity.MemberInfo;
import com.example.demo.entity.Point;
import com.example.demo.global.Code_List;
import com.example.demo.global.GoodsUtil;
import com.example.demo.repository.AttendanceRepo;
import com.example.demo.repository.MemberRepo;
import com.example.demo.repository.PointRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginSvc {
	
	private final MemberRepo memberRepo;
	private final AttendanceRepo attendanceRepo;
	private final PointRepo pointRepo;
	
	@Transactional
	public MemberInfoDto login(String id, String pw) {
		MemberInfo mi = memberRepo.findByIdAndPw(id, pw);
		if(mi==null) {
			return null;
		}
	
		if(!mi.getLastlogin().toLocalDate().isEqual(LocalDate.now())) {
			Attendance ad = attendanceRepo.findTop1ByUseridxOrderByLoginDesc(mi.getIdx());
			Attendance new_ad;
			if(ad!=null && ad.getLogin().toLocalDate().isEqual(LocalDate.now().minusDays(1))) {
				new_ad = Attendance.builder()
						.useridx(mi.getIdx())
						.login(mi.getLastlogin())
						.consecutive(ad.getConsecutive()+1)
						.build();
			}else {
				new_ad = Attendance.builder()
						.useridx(mi.getIdx())
						.login(mi.getLastlogin())
						.consecutive(1)
						.build();
			}
			attendanceRepo.save(new_ad); 
			
			int point = new Random().nextInt(999)+1;
			point = GoodsUtil.point_calculate(point, new_ad.getConsecutive());
			
			Point p = Point.builder()
					.id(mi.getId())
					.point(point)
					.su(Code_List.SAVE)
					.desc(Code_List.ATTENDANCE)
					.date(LocalDateTime.now())
					.build();
			pointRepo.save(p);
			
			mi.givePoint(point);
		}
		
		mi.setLastlogin(LocalDateTime.now());
		memberRepo.save(mi);
		return new MemberInfoDto(mi);
	}
}
