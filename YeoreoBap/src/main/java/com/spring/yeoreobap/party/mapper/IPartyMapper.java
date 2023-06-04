package com.spring.yeoreobap.party.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.yeoreobap.command.ParticipantsVO;
import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.util.PageVO;

public interface IPartyMapper {
	
	//글 등록
	void regist(PartyVO vo);
	//글 목록
	List<PartyVO> getList(PageVO vo);
	//상세보기
	PartyVO getArticle(@Param("partyNo") int partyNo, @Param("userId") String userId);
	//수정
	void update(PartyVO vo);
	//삭제
	void delete(int partyNo);
	//참여
	void attend(ParticipantsVO vo);
	
}