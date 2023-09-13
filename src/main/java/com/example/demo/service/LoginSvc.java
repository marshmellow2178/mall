package com.example.demo.service;

import java.time.LocalDateTime;

import org.springframework.stereotype.Service;

import com.example.demo.dto.MemberInfoDto;
import com.example.demo.entity.MemberInfo;
import com.example.demo.repository.MemberRepo;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LoginSvc {
	
	private final MemberRepo memberRepo;
	
	public MemberInfoDto login(String id, String pw) {
		MemberInfo mi = memberRepo.findByIdAndPw(id, pw);
		if(mi==null) {
			return null;
		}
		mi.setLastlogin(LocalDateTime.now());
		memberRepo.save(mi);
		return new MemberInfoDto(mi);
	}
}
