package com.spring.yeoreobap.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.spring.yeoreobap.reviewReply.service.IReviewReplyService;

@RestController
@RequestMapping("/reply")
public class ReviewReplyController {

	@Autowired
	private IReviewReplyService service;

	@PostMapping("/regist")
	public String replyRegist(@RequestBody ReviewReplyVO vo) {
		service.replyRegist(vo);
		return "registSuccess";
	}
	
	//댓글 목록
	@GetMapping("/getList/{reviewNo}/{pageNum}")
	public Map<String, Object> getList(@PathVariable int reviewNo, @PathVariable int pageNum) {
		List<ReviewReplyVO> list = service.getList(reviewNo, pageNum);
		int total = service.getTotal(reviewNo);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("total", total);
		return map;
	}
	
	//댓글 수정
	@PutMapping("/{replyNo}")
	public String update(@PathVariable int reviewNo, @RequestBody ReviewReplyVO vo) {
		vo.setReplyNo(reviewNo);
		if(service.pwCheck(vo)) {
			service.update(vo);
			return "replyUpdateSuccess";
		} else return "replyUpdateFail";
	}
	
	//댓글 삭제
	@DeleteMapping("/{replyNo}")
	public String delete(@PathVariable int replyNo, @RequestBody ReviewReplyVO vo) {
		vo.setReplyNo(replyNo);
		if(service.pwCheck(vo)) {
			service.delete(replyNo);
			return "replyDeleteSuccess";
		} else return "replyDeleteFail";
	}
	
	
}