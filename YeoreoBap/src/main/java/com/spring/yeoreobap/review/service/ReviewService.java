package com.spring.yeoreobap.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.review.mapper.IReviewMapper;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReviewService implements IReviewService {

	@Autowired
	private IReviewMapper mapper;
	
	@Override
	public void regist(ReviewVO vo) {
		mapper.regist(vo);

	}

	@Override
	public List<ReviewVO> getList(PageVO vo) {
		return mapper.getList(vo);
	}

	@Override
	public int getTotal() {
		return mapper.getTotal();
	}

	@Override
	public ReviewVO getArticle(int reviewNo) {
		return mapper.getArticle(reviewNo);
	}

	@Override
	public void update(ReviewVO vo) {
		mapper.update(vo);

	}

	@Override
	public void delete(int reviewNo) {
		mapper.delete(reviewNo);
	}

	@Override
	public void upload(int reviewNo, MultipartFile file) {
		
	}
}