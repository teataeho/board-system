package com.spring.yeoreobap.reviewReply.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.ReviewReplyVO;
import com.spring.yeoreobap.reviewReply.mapper.IReviewReplyMapper;
import com.spring.yeoreobap.util.PageVO;

@Service
public class ReviewReplyService implements IReviewReplyService {

	@Autowired
	private IReviewReplyMapper mapper;
	
	@Override
	public void replyRegist(ReviewReplyVO vo) {
		mapper.replyRegist(vo);
	}
	
	@Override
	public List<ReviewReplyVO> getList(int reviewNo, int pageNum){
		
		PageVO vo = new PageVO();
		vo.setPageNum(pageNum);
		
		Map<String, Object> data = new HashMap<>();
		data.put("paging", vo);
		data.put("reviewNo", reviewNo);
		
		return mapper.getList(data);
	}
	
	

	@Override
	public int getTotal(int replyNo) {
		return mapper.getTotal(replyNo);
	}

	@Override
	public void delete(int replyNo) {
		mapper.delete(replyNo);
	}

	@Override
	public boolean idCheck(int replyNo, String userId) {
		if(mapper.idCheck(replyNo).equals(userId)) {
			return true;
		}
		return false;
	}


}