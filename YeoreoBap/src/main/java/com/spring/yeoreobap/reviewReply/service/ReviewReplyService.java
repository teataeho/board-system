package com.spring.yeoreobap.reviewReply.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.ReviewReplyVO;
import com.spring.yeoreobap.reviewReply.mapper.IReviewReplyMapper;
import com.spring.yeoreobap.util.PageVO;

@Service
public class ReviewReplyService implements IReviewReplyService {

	@Autowired
	private IReviewReplyMapper mapper;
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Override
<<<<<<< HEAD
	public void replyRegister(ReviewReplyVO vo) {
		mapper.replyRegister(vo);
=======
	public void replyRegist(ReviewReplyVO vo) {
		mapper.replyRegist(vo);
>>>>>>> 1a467eca75f935cecd2b950d4c79fedd1785029d
	}
	
	@Override
	public List<ReviewReplyVO> getList(int reviewNo, int pageNum){
		
		PageVO vo = new PageVO();
		vo.setPageNum(pageNum);
		vo.setCpp(10);
		
		Map<String, Object> data = new HashMap<>();
		data.put("paging", vo);
		data.put("reviewNo", reviewNo);
		
		return mapper.getList(data);
	}
	
	

	@Override
	public int getTotal(int partyNo) {
		return mapper.getTotal(partyNo);
	}
	
	@Override
	public boolean userVerification(ReviewReplyVO vo, HttpSession session) {
		if(session.getAttribute("userInfo").equals(vo.getWriter())) return true;
		else return false;
	}

	@Override
	public void delete(int replyNo) {
		mapper.delete(replyNo);
	}

<<<<<<< HEAD


}
=======
	@Override
	public boolean idCheck(ReviewReplyVO vo) {
		String dbId = mapper.idCheck(vo.getReplyNo());
		return encoder.matches(vo.getReplyId(), dbId);
	}


}
>>>>>>> 954c3b98a2828b24da47c8c92e08656637cabb52
