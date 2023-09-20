package com.example.demo.service;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.example.demo.dto.EventDto;
import com.example.demo.dto.PageInfo;
import com.example.demo.entity.Attendance;
import com.example.demo.entity.EventInfo;
import com.example.demo.repository.AttendanceRepo;
import com.example.demo.repository.EventRepo;
import com.example.demo.vo.EventVo;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class EventSvc {
	private final EventRepo eventRepo;
	private final AttendanceRepo attendanceRepo;
	
	public List<EventInfo> eventList(String title, Pageable pageable, PageInfo pageInfo) {
		Page<EventInfo> eventPage = eventRepo.findByTitleContaining(title, pageable);
		pageInfo.setPage(eventPage);
		List<EventInfo> eventList = eventPage.getContent();
		return eventList;
	}
	
	public EventDto eventView(int beidx) {
		return new EventDto(eventRepo.findByIdx(beidx)); 
	}
	
	public EventInfo getEvent(int idx) {
		return eventRepo.findByIdx(idx);
	}
	
	public List<Attendance> getAttendanceList(int idx){
		//년, 월 -> 년, 월, 1 ~ 년, 월, 월의 마지막 일
		LocalDateTime today = LocalDateTime.now();
		int year = today.getYear();
		int month = today.getMonthValue();
		int lastday = today.toLocalDate().lengthOfMonth();
		LocalDateTime sdate = LocalDateTime.of(year, month, 1, 0, 0, 0);
		LocalDateTime edate = LocalDateTime.of(year, month, lastday, 23, 59, 59);
		return attendanceRepo.findByUseridxAndLoginBetween(idx, sdate, edate);
	}
	
	public List<EventInfo> getAdminEventList(String title, Pageable pageable, PageInfo pageInfo){
		Page<EventInfo> eventPage = eventRepo.findByTitleContaining(title, pageable);
		pageInfo.setPage(eventPage);
		List<EventInfo> eventList = eventPage.getContent();
		return eventList;
	}
	
	public int eventRegister(EventVo ev, String uploadPath) {
		EventInfo ei = EventInfo.builder()
				.title(ev.getTitle())
				.img1(ev.getImg1Name())
				.img2(ev.getImg2Name())
				.date(LocalDateTime.now())
				.sdate(LocalDateTime.now())
				.build();
		try {
			if(ev.getImg1Name()!=null && !ev.getImg1Name().equals("")) {
				ev.getImg1().transferTo(new File(uploadPath, ev.getImg1Name()));
			}
			if(ev.getImg2Name()!=null && !ev.getImg2Name().equals("")) {
				ev.getImg2().transferTo(new File(uploadPath, ev.getImg2Name()));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return eventRepo.save(ei).getIdx();
	}
	
	public int eventUpdate(EventVo ev, String uploadPath) {
		EventInfo old = eventRepo.findByIdx(ev.getIdx());
		try {
			if(ev.getImg1Name()!=null && !ev.getImg1Name().equals("")) {
				ev.getImg1().transferTo(new File(uploadPath, ev.getImg1Name()));
			}else {
				ev.setImg1Name(old.getImg1());
			}
			if(ev.getImg2Name()!=null && !ev.getImg2Name().equals("")) {
				ev.getImg2().transferTo(new File(uploadPath, ev.getImg2Name()));
			}else {
				ev.setImg2Name(old.getImg2());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		EventInfo ei = EventInfo.builder()
				.idx(ev.getIdx())
				.title(ev.getTitle())
				.img1(ev.getImg1Name())
				.img2(ev.getImg2Name())
				.date(LocalDateTime.now())
				.sdate(LocalDateTime.now())
				.build();
		
		return eventRepo.save(ei).getIdx();
	}
}
