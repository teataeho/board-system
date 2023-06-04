package com.spring.yeoreobap.reviewReply.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.spring.yeoreobap.command.ReviewReplyVO;

public interface IReviewReplyService {
	
	// 댓글 등록
	void replyRegister(ReviewReplyVO vo);

	// 목록 요청
	List<ReviewReplyVO> getList(int replyNo, int pageNum);

	// 댓글 개수
	int getTotal(int replyNo);
	
<<<<<<< HEAD
	// 본인 확인 (세션 데이터와 작성자 일치 여부 확인)
	boolean userVerification(ReviewReplyVO vo, HttpSession session);

	// 댓글 수정
	void update(ReviewReplyVO vo);
=======
	//아이디 확인
	boolean idCheck(ReviewReplyVO vo);
>>>>>>> 954c3b98a2828b24da47c8c92e08656637cabb52

	// 댓글 삭제
	void delete(int replyNo);
}
