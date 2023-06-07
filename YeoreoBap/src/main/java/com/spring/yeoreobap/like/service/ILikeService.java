package com.spring.yeoreobap.like.service;

import com.spring.yeoreobap.command.LikeVO;

public interface ILikeService {
	
	void insertPartyLike(LikeVO vo);
	
	void deletePartyLike(LikeVO vo);
	
	void insertReviewLike(LikeVO vo);
	
	void deleteReviewLike(LikeVO vo);

}
