package com.spring.yeoreobap.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.yeoreobap.command.FileVO;
import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.util.PageVO;
@Mapper
public interface IReviewMapper {

	//글 등록
	void regist(ReviewVO vo);

	//글 목록
	List<ReviewVO> getList(PageVO vo);
	//글 목록
	List<ReviewVO> getList2();

	//총 게시물 수 구하기
	int getTotal(PageVO vo);

	//상세보기
	ReviewVO getContent(int reviewNo);

	//수정
	void update(ReviewVO vo);

	//삭제
	void delete(ReviewVO vo);
	
	//숨기기
	void hide(ReviewVO vo);

	//비밀번호검증
	int checkPw(ReviewVO vo);
	
	//마지막 자리 찾기
	int findMax(int ref);
	
	//들어갈 자리 찾기
	int findStep(ReviewVO vo);
	
	//들어갈 자리 만들기
	void increaseRefOrder(@Param("ref") int ref, @Param("maxRefOrder")int maxRefOrder);
	
	//답글쓰기
	void registDab(ReviewVO vo);

	//모든 리스트 가져오긴
	List<ReviewVO> getAllList();

	//파일 업로드내역 DB에 저장
	void fileUpload(FileVO fileVO);

	//파일 가져오기
	List<FileVO> getFiles(int reviewNo);

	//부모글 답글 개수 증가
	void increaseAnswer(int parentNo);
	

//	List<PartyVO> getResList1(String userId);
//	List<PartyVO> getResList2(String userId);
}