package com.spring.yeoreobap.partyReply.service;

import java.util.List;
import java.util.Map;

import com.spring.yeoreobap.command.PartyReplyVO;

public interface IPartyReplyService {

	//댓글 등록
	void replyRegist(PartyReplyVO vo);

	//목록 요청
	List<PartyReplyVO> getList(Map<String, Object> data);

	//댓글 개수
	int getTotal(int partyNo);

	//비밀번호 확인
	//String pwCheck(int replyNo);

	//댓글 수정
	void update(PartyReplyVO vo);

	//댓글 삭제
	void delete(int replyNo);
}
