package com.spring.yeoreobap.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.yeoreobap.command.LikeVO;
import com.spring.yeoreobap.like.service.ILikeService;

@RestController
@RequestMapping("/like")
public class LikeController {

	@Autowired
	private ILikeService service;
	
	@PostMapping("/partyLike")
	public String insertPartyLike(@RequestBody LikeVO vo) {
		service.insertPartyLike(vo);
		
		return "success";
	}
	
	@PostMapping("/deletePartyLike")
	public String deletePartyLike(@RequestBody LikeVO vo) {
		service.deletePartyLike(vo);
		
		return "success";
	}
	
}
