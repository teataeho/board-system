package com.spring.yeoreobap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/party")
public class PartyController {

	@GetMapping("/map")
	public void kakaoMap() {}
	
}
