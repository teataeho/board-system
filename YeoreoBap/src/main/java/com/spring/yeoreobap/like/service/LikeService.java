package com.spring.yeoreobap.like.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.LikeVO;
import com.spring.yeoreobap.like.mapper.ILikeMapper;

@Service
public class LikeService implements ILikeService {
	
	@Autowired
	private ILikeMapper mapper;

	@Override
	public void insertPartyLike(LikeVO vo) {
		mapper.insertPartyLike(vo);
	}

	@Override
	public void deletePartyLike(LikeVO vo) {
		mapper.deletePartyLike(vo);
	}

	@Override
	public void insertReviewLike(LikeVO vo) {
		mapper.insertReviewLike(vo);
	}

	@Override
	public void deleteReviewLike(LikeVO vo) {
		mapper.deleteReviewLike(vo);
	}

}
