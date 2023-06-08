package com.spring.yeoreobap.party.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.ParticipantsVO;
import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.util.PageVO;

public interface IPartyService {

	// 글 등록 (사진없음)
	void register(PartyVO vo);

	// 글 등록 (사용자 지정 파일)
	void register(PartyVO vo, MultipartFile file);

	// 글 목록
	List<PartyVO> getList(PageVO paging);

	// 상세보기
	PartyVO getArticle(int partyNo, String userId);

	// 수정
	void update(PartyVO vo);

	// 삭제
	void delete(int partyNo);

	// 참여
	void attend(ParticipantsVO vo);

	// 참가 취소
	void cancelAttend(ParticipantsVO vo);

	// 총 게시물 수 (mypage)
	int getTotal(PageVO vo);

	//홈화면에 올릴 리스트
	List<PartyVO> getListHome();
	
	//마이페이지에 쓸 참여파티
	List<PartyVO> getParticipantsParty(String userId);
}