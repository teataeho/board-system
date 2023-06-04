package com.spring.yeoreobap.reviewReply.mapper;

import java.util.List;
import java.util.Map;

import com.spring.yeoreobap.command.ReviewReplyVO;

public interface IReviewReplyMapper {

	// 댓글 등록
	void replyRegister(ReviewReplyVO vo);

	// 목록 요청
	List<ReviewReplyVO> getList(Map<String, Object> data);

	// 댓글 개수
	int getTotal(int replyNo);
<<<<<<< HEAD

	// 댓글 수정
	void update(ReviewReplyVO vo);
=======
	
	//id 확인
	String idCheck(int replyNo);
>>>>>>> 954c3b98a2828b24da47c8c92e08656637cabb52

	// 댓글 삭제
	void delete(int replyNo);
}
