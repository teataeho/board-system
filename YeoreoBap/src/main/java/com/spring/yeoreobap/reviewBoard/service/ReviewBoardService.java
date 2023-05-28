package com.spring.yeoreobap.reviewBoard.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.ReviewBoardVO;
import com.spring.yeoreobap.util.PageVO;

@Service
public class ReviewBoardService implements IReviewBoardService {

	@Override
	public void regist(ReviewBoardVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<ReviewBoardVO> getList(PageVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotal(PageVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ReviewBoardVO getContent(int bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(ReviewBoardVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int bno) {
		// TODO Auto-generated method stub

	}

}
