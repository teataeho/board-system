package com.spring.yeoreobap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {

	@GetMapping("/userLogin")
	public void login() {}
	
	@PostMapping("/userLogin")
	public void userLogin(String userId, String userPw) {
		
	}
	
	@GetMapping("/userJoin")
	public void join() {}
	
}
