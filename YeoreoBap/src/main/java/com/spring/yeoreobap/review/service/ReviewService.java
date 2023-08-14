package com.spring.yeoreobap.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.PartyVO;
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
	public List<ReviewVO> getList2() {
		return mapper.getList2();
	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}

	@Override
	public ReviewVO getArticle(int reviewNo) {
		return mapper.getContent(reviewNo);
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
	public int checkPw(ReviewVO vo) {
		return mapper.checkPw(vo);
	}

	@Override
	public void registDab(ReviewVO vo) {
		int maxRefOrder;
		log.info("vo는 모야:" +vo);
		//중간에 들어갈 자리 찾기
		if(vo.getAnswerCnt() == 0) {
			maxRefOrder = vo.getRefOrder();
		} else {
			ReviewVO tmp = mapper.findStep(vo);
			maxRefOrder = tmp.getRefOrder() +tmp.getAnswerCnt();
		}
		
		//들어갈 자리 마련하기
		mapper.increaseRefOrder(vo.getRef(), maxRefOrder);
		
		//부모글의 답변수 증가
		mapper.increaseAnswer(vo.getParentNo());
		
		//답글등록
		ReviewVO result = new ReviewVO();
		result.setTitle(vo.getTitle());
		result.setPassword(vo.getPassword());
		result.setContent(vo.getContent());
		result.setWriter(vo.getWriter());
		result.setRef(vo.getRef());
		result.setStep(vo.getStep() + 1);
		result.setRefOrder(maxRefOrder + 1);
		result.setParentNo(vo.getParentNo());
		
		mapper.registDap(result);
		
		
	}

	@Override
	public List<ReviewVO> getAllList() {
		return mapper.getAllList();
	}

//	@Override
//	public List<PartyVO> getResList1(String userId) {
//		return mapper.getResList1(userId);
//	}
//	
//	@Override
//	public List<PartyVO> getResList2(String userId) {
//		return mapper.getResList2(userId);
//	}
}