package com.spring.yeoreobap.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.yeoreobap.command.StoreVO;
import com.spring.yeoreobap.store.service.IStoreService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/store")
@Slf4j
public class StoreController {

	@Autowired
	private IStoreService service;
	
	@GetMapping("/input")
	public void inputData() {
		service.readOpenStoresFromJson();
	}
	
	@GetMapping("/getList")
	public List<StoreVO> storeList() {
		return service.getList("%(동교동)");
	}
	
}