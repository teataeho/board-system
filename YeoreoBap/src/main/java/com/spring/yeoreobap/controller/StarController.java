package com.spring.yeoreobap.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.yeoreobap.command.StarVO;
import com.spring.yeoreobap.star.service.IStarService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/star")
public class StarController {

	@Autowired
	private IStarService service;
	
	@PostMapping("/insertStar")
	public String insertStar(@RequestBody StarVO vo) {
		System.out.println("sno: " + vo.getSno());
		System.out.println("userId: " + vo.getUserId());
		System.out.println("starRate: " + vo.getStarRate());
		service.insertStar(vo);
		
		return "success";
	}
	
}
