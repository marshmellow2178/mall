package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dto.AdminDto;
import com.example.demo.entity.Admin;
import com.example.demo.repository.AdminRepo;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AdminSvc {

	private final AdminRepo adminRepo;
	
	public AdminDto getAdmin(String id, String pw) {
		Admin admin = adminRepo.findByIdAndPw(id, pw);
		return new AdminDto(admin);
	}
}
