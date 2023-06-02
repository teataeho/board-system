package com.spring.yeoreobap.review.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.util.PageVO;

public interface IReviewService {

	//글 등록
	void regist(ReviewVO vo);

	//글 목록
	List<ReviewVO> getList(PageVO vo);

	//총 게시물 수 구하기
	int getTotal(PageVO vo);

	//상세보기
	ReviewVO getArticle(int reviewNo);

	//수정
	void update(ReviewVO vo);

	//삭제
	void delete(int reviewNo);
	
	//파일업로드
	void upload(int reviewNo, MultipartFile file);

}