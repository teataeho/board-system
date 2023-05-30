package com.spring.yeoreobap.party.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.ImgVO;
import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.util.PageVO;

public interface IPartyService {

	//글 등록
	void regist(PartyVO vo);
	//글 목록
	List<PartyVO> getList(PageVO paging);
	//전체 글
	int getTotal();
	//상세보기
	PartyVO getArticle(int partyNo);
	//수정
	void update(PartyVO vo);
	//삭제
	void delete(int partyNo);
	//참여
	void attend(String userId, int partyNo);
	//파일업로드
	void upload(int partyNo, MultipartFile file);
}
