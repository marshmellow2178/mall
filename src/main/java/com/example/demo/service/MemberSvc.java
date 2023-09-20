package com.example.demo.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.entity.Domain;
import com.example.demo.entity.MemberInfo;
import com.example.demo.entity.Point;
import com.example.demo.global.Code_List;
import com.example.demo.dto.MemberInfoDto;
import com.example.demo.dto.PageInfo;
import com.example.demo.repository.DomainRepo;
import com.example.demo.repository.MemberRepo;
import com.example.demo.repository.PointRepo;
import com.example.demo.vo.MemberInsertVo;
import com.example.demo.vo.MemberUpdateVo;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberSvc {
	
	private final MemberRepo memberRepo;
	private final PointRepo pointRepo;
	private final DomainRepo domainRepo;
	
	public boolean chkID(String id) {
		if(memberRepo.countById(id)!=0) { return true; }
		return false;
	}
	
	@Transactional
	public void insert(MemberInsertVo miv) {
		MemberInfo mi = MemberInfo.builder()
				.id(miv.getId())
				.pw(miv.getPw())
				.name(miv.getName())
				.point(Code_List.REGISTER_POINT)
				.phone(miv.getPhone())
				.email(miv.getEmail())
				.domain(miv.getDomain())
				.addr1(miv.getAddr1())
				.addr2(miv.getAddr2())
				.status("n") 
				.joindate(LocalDateTime.now())
				.build();
		memberRepo.save(mi);
		
		Point p = Point.builder()
				.id(miv.getId())
				.point(Code_List.REGISTER_POINT)
				.su("s")
				.desc(Code_List.JOIN)
				.date(LocalDateTime.now())
				.build();
		pointRepo.save(p);
	}
	
	@Transactional
	public MemberInfoDto update(MemberUpdateVo mid) {
		MemberInfo mi = memberRepo.findById(mid.getId());
		mi.setId(mid.getId());
		mi.setPhone(mid.getPhone());
		mi.setEmail(mid.getEmail());
		mi.setDomain(mid.getDomain());
		mi.setAddr1(mid.getAddr1());
		mi.setAddr2(mid.getAddr2());
		mi.setAgree(mid.getAgree());
		memberRepo.save(mi);
		return new MemberInfoDto(mi);
	}
	
	public void pwChangeSvc(String newPwd, String miid) {
		MemberInfo mi = memberRepo.findById(miid);
		mi.setPw(newPwd);
		memberRepo.save(mi);
	}
	
	public List<Point> pointList(String id, Pageable pageable, PageInfo pageInfo) {
		Page<Point> pointPage = pointRepo.findById(id, pageable);
		pageInfo.setPage(pointPage);
		return pointPage.getContent();
	}
	
	public void delete(MemberInfoDto mid) {
		MemberInfo mi = memberRepo.findById(mid.getId());
		mi.setStatus(Code_List.DELETE_USER);
		memberRepo.save(mi);
	}
	
	public List<Domain> getDomain(){
		return domainRepo.findAll();
	}
	
	public List<MemberInfo> getMemberList(String key, Pageable pageable, PageInfo pageInfo){
		Page<MemberInfo> memberPage = memberRepo.findByIdContains(key, pageable);
		pageInfo.setPage(memberPage);
		return memberPage.getContent();
	}
	
	public MemberInfo findByIdx(int idx) {
		return memberRepo.findByIdx(idx);
	}
	
	@Transactional
	public void adminMemberUpdate(int idx, String id, int point, String status) {
		MemberInfo mi = memberRepo.findByIdx(idx);
		mi.setId(id);
		mi.givePoint(point);
		mi.setStatus(status);
		memberRepo.save(mi);
		
		Point p = Point.builder()
				.id(mi.getId())
				.point(point)
				.date(LocalDateTime.now())
				.su("s")
				.desc(Code_List.ADMIN)
				.build();
		pointRepo.save(p);
	}
}
