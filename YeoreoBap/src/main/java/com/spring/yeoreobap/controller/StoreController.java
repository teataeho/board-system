package com.spring.yeoreobap.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.yeoreobap.store.service.IStoreService;
import com.spring.yeoreobap.util.PageCreator;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/store")
@Slf4j
public class StoreController {

	private IStoreService service;
	
	//목록
	@GetMapping("/storeList")
	public void storeList(PageVO vo, Model model) {
		PageCreator pc = new PageCreator(vo, service.getTotal(vo));
		System.out.println("페이지: " + pc.toString());
		log.info(pc.toString());
		
		model.addAttribute("storeList",service.getList(vo));
		model.addAttribute("pc", pc);
	}
	
	//상세
	@GetMapping("/content/{sno}")
	public String getContent(@PathVariable int sno, @ModelAttribute("p") PageVO vo,
			Model model) {
		model.addAttribute("article", service.getContent(sno));
		return "store/storeDetail";
	}
	
	
}
