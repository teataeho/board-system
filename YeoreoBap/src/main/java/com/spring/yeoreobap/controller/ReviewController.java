package com.spring.yeoreobap.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.review.service.IReviewService;
import com.spring.yeoreobap.util.PageCreator;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/review")
@Slf4j
public class ReviewController {

	@Autowired
	private IReviewService service;
	
	//후기게시판에 후기리스트를 불러오기
	@GetMapping("/reviewList")
	public void reviewList(PageVO vo, Model model) {
		PageCreator pc = new PageCreator(vo, service.getTotal(vo));
		log.info("getTotal : " + service.getTotal(vo));
		System.out.println("store: " + pc.toString());
		log.info(pc.toString());
		
		model.addAttribute("reviewList",service.getList(vo));
		model.addAttribute("pc", pc);
	}
	
	//메인화면에 후기리스트 일부 불러오기
	@GetMapping("/reviewList2")
	public void reviewList2(Model model) {
		model.addAttribute("reviewList",service.getList2());
	}
	
	//후기등록화면으로 보내기
	@GetMapping("/reviewRegist")
	public void regist() {
		
//		String userId = ((UserVO) session.getAttribute("userInfo")).getUserId();
//		
//		model.addAttribute("party" ,service.getResList1(userId));
//		model.addAttribute("attendedParty" ,service.getResList2(userId));
	}
	
	//후기등록하기
	@PostMapping("/regist")
	public String regist(ReviewVO vo) {
		service.regist(vo);
		return "redirect:/review/reviewList";
	}
	
	//후기상세보기
	@GetMapping("/content/{reviewNo}")
	public String getContent(@PathVariable int reviewNo, @ModelAttribute("p") PageVO vo
			, Model model) {
		model.addAttribute("article", service.getArticle(reviewNo));
		return "review/reviewDetail";
	}
	
	//후기수정화면으로 보내기
	@PostMapping("/modify")
	public String modify(ReviewVO vo, Model model) {
		log.info(vo.toString());
		model.addAttribute("article", service.getArticle(vo.getReviewNo()));
		return "review/reviewModify";
	}
	
	//후기수정하기
	@PostMapping("/update")
	public String update(ReviewVO vo) {
		service.update(vo);
		return "redirect:/review/content/" + vo.getReviewNo();
	}
	
	//후기삭제
	@PostMapping("/delete")
	public String delete(@ModelAttribute("article") ReviewVO vo) {
		int reviewNo = vo.getReviewNo();
		service.delete(reviewNo);
		return "redirect:/review/reviewList";
	}
	
	@ResponseBody
	@PostMapping("/checkPw")
	public int checkPw(@RequestBody ReviewVO vo) {
		log.info("checkPw : " + vo);
		return service.checkPw(vo);
	}
	
}