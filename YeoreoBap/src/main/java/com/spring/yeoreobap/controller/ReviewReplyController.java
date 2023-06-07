package com.spring.yeoreobap.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.yeoreobap.command.ReviewReplyVO;
import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.reviewReply.service.IReviewReplyService;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/reply")
public class ReviewReplyController {

	@Autowired
	private IReviewReplyService service;

	// 댓글 등록
	@PostMapping("/regist")
	public String replyRegist(@RequestBody ReviewReplyVO vo) {
		service.replyRegist(vo);
		return "registSuccess";
	}

	// 댓글 목록
	@GetMapping("/getList/{reviewNo}/{pageNum}")
	public Map<String, Object> getList(@PathVariable int reviewNo, @PathVariable int pageNum) {
		List<ReviewReplyVO> list = service.getList(reviewNo, pageNum);
		int total = service.getTotal(reviewNo);

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("total", total);
		return map;
	}

	// 댓글 삭제
	@DeleteMapping("/delete/{replyNo}")
	public String delete(@PathVariable int replyNo, HttpSession session) {
		log.info("replyNo : " + replyNo);
		log.info("userId : " + ((UserVO) session.getAttribute("userInfo")).getUserId());
		System.out.println("delete 요청");		
		if (service.idCheck(replyNo, ((UserVO) session.getAttribute("userInfo")).getUserId())) {
			service.delete(replyNo);
			return "replyDeleteSuccess";
		} else
			return "replyDeleteFail";
	}

}