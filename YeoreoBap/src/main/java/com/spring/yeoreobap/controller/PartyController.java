package com.spring.yeoreobap.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.party.service.IPartyService;
import com.spring.yeoreobap.util.PageCreator;
import com.spring.yeoreobap.util.PageVO;

@Controller
@RequestMapping("/party")
public class PartyController {
	
	@Autowired
	private IPartyService service;

	@GetMapping("/map")
	public void map() {}
	
	@GetMapping("/partyList")
	public void partyList(PageVO vo, Model model) {
		PageCreator pc = new PageCreator(vo, service.getTotal());
		
		model.addAttribute("list", service.getList(vo));
		model.addAttribute(pc);
	}
	
	@GetMapping("/partyRegist")
	public void regist() {}
	
	@PostMapping("/partyRegist")
	public String regist(PartyVO vo) {
		service.regist(vo);
		return "redirect:/party/partyList";
	}
	
	@GetMapping("/content/{bno}")
	public String freeContent(@PathVariable int partyNo
			, @ModelAttribute("p") PageVO paging
			, Model model) {
		model.addAttribute("article", service.getArticle(partyNo));
		return "party/partyDetail";
	}
	
	//글 수정 페이지 이동 처리
	@PostMapping("/modify")
	public String modify(@ModelAttribute("article") PartyVO vo) {
		return "party/partyModify";
	}
	
	//글 수정 처리
	@PostMapping("/update")
	public String update(PartyVO vo) {
		service.update(vo);
		return "redirect:/party/content/" + vo.getPartyNo();
	}
	
	@PostMapping("/delete")
	public String delete(int partyNo) {
		service.delete(partyNo);
		return "redirect:/party/partyList";
	}
	
	//참가시 유저아이디와 글번호를 모두 가져와야함 가져오는 방식은 미정
	@ResponseBody
	@PostMapping("/attend")
	public void attend(String userId, int partyNo) {
		service.attend(userId, partyNo);
	}
	
}