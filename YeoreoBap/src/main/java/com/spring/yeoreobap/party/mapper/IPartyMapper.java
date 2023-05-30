package com.spring.yeoreobap.party.mapper;

import java.util.List;

import com.spring.yeoreobap.command.ImgVO;
import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.util.PageVO;

public interface IPartyMapper {
	
	//글 등록
	void regist(PartyVO vo);
	//글 목록
	List<PartyVO> getList(PageVO vo);
	//게시글 총 수
	int getTotal();
	//상세보기
	PartyVO getArticle(int partyNo);
	//수정
	void update(PartyVO vo);
	//삭제
	void delete(int partyNo);
	//참여
	void attend(String userId, int partyNo);
	//업로드
	void upload(int partyNo, ImgVO img);

}
