package com.example.demo.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.demo.entity.Domain;

public interface DomainRepo extends JpaRepository<Domain, Long> {

}
