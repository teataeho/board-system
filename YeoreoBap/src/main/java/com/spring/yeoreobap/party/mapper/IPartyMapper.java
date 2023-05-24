package com.spring.yeoreobap.party.mapper;

import java.util.List;

import com.spring.yeoreobap.command.partyVO;

public interface IPartyMapper {
	
	//글 등록
	void regist(partyVO vo);
	//글 목록
	List<partyVO> getList();
	//상세보기
	partyVO getarticle(int partyNo);
	//수정
	
	//삭제
	
	//참여

}
