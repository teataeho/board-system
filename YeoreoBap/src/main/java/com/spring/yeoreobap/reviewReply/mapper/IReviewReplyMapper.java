package com.spring.yeoreobap.reviewReply.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.yeoreobap.command.ReviewReplyVO;

public interface IReviewReplyMapper {

	//댓글 등록
	void replyRegist(ReviewReplyVO vo);

	//목록 요청
	List<ReviewReplyVO> getList(Map<String, Object> data);

	//댓글 개수
	int getTotal(int replyNo);
	
	//id 확인
	String idCheck(int replyNo);

	//댓글 삭제
	void delete(int replyNo);

	//비번 체크
	int checkPw(@Param("replyNo") int replyNo, @Param("replyPw") String replyPw);
}