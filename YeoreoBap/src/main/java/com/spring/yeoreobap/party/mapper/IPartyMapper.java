package com.spring.yeoreobap.party.mapper;

import java.util.List;

import com.spring.yeoreobap.command.PartyVO;

public interface IPartyMapper {
	
	//글 등록
	void regist(PartyVO vo);
	//글 목록
	List<PartyVO> getList();
	//상세보기
	PartyVO getarticle(int partyNo);
	//수정
	
	//삭제
	
	//참여

}