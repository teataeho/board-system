package com.spring.yeoreobap.reviewBoard.service;

import java.util.List;

import com.spring.yeoreobap.command.ReviewBoardVO;
import com.spring.yeoreobap.util.PageVO;

public interface IReviewBoardService {

	//글 등록
		void regist(ReviewBoardVO vo);

		//글 목록
		List<ReviewBoardVO> getList(PageVO vo);

		//총 게시물 수 구하기
		int getTotal(PageVO vo);

		//상세보기
		ReviewBoardVO getContent(int bno);

		//수정
		void update(ReviewBoardVO vo);

		//삭제
		void delete(int bno);

}
