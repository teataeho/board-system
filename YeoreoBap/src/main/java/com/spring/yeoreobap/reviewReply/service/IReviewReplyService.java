package com.spring.yeoreobap.reviewReply.service;

import java.util.List;

import com.spring.yeoreobap.command.ReviewReplyVO;

public interface IReviewReplyService {
	
	//댓글 등록
	void replyRegist(ReviewReplyVO vo);

	//목록 요청
	List<ReviewReplyVO> getList(int replyNo, int pageNum);

	//댓글 개수
	int getTotal(int replyNo);
	
	//아이디 확인
	boolean idCheck(int replyNo, String userId);

	//댓글 삭제
	void delete(int replyNo);
}