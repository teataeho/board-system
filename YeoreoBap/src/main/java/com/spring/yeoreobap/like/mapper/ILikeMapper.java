package com.spring.yeoreobap.like.mapper;

import com.spring.yeoreobap.command.LikeVO;

public interface ILikeMapper {
	
	void insertPartyLike(LikeVO vo);
	
	void deletePartyLike(LikeVO vo);
	
	void insertReviewLike(LikeVO vo);
	
	void deleteReviewLike(LikeVO vo);

}
