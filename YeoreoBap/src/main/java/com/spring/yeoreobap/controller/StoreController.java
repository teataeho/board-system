package com.spring.yeoreobap.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.yeoreobap.command.StoreVO;
import com.spring.yeoreobap.command.StoreVO;
import com.spring.yeoreobap.store.service.IStoreService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RestController
@RequestMapping("/store")
public class StoreController {

	@Autowired
	@Autowired
	private IStoreService service;
	
	@GetMapping("/input")
	public void inputData() {
		service.readOpenStoresFromJson();
	@GetMapping("/input")
	public void inputData() {
		service.readOpenStoresFromJson();
	}
	
	@GetMapping("/getList/{uptaeNm}")
	public List<StoreVO> storeList(@PathVariable String uptaeNm) {
		System.out.println(uptaeNm);
		return service.getList(uptaeNm, "%(동교동)");
	}
	
}