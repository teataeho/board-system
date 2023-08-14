package com.spring.yeoreobap.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.PartyVO;
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
	void delete(int reviewNo);

	//비밀번호검증
	int checkPw(ReviewVO vo);
	
	//부모글 답변 수 증가
	void increaseAnswer(int parentNo);
	
	//들어갈 자리 찾기
	ReviewVO findStep(ReviewVO vo);
	
	//들어갈 자리 만들기
	void increaseRefOrder(@Param("ref") int ref, @Param("maxRefOrder")int maxRefOrder);
	
	//답글쓰기
	void registDap(ReviewVO vo);

	//모든 리스트 가져오긴
	List<ReviewVO> getAllList();
	

//	List<PartyVO> getResList1(String userId);
//	List<PartyVO> getResList2(String userId);
}