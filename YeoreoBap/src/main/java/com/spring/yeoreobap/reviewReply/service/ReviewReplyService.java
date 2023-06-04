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
	public void replyRegister(ReviewReplyVO vo) {
		mapper.replyRegister(vo);
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
		if(session.getAttribute("userInfo").equals(vo.getUserNick())) return true;
		else return false;
	}

	@Override
	public void delete(int replyNo) {
		mapper.delete(replyNo);
	}
	
	@Override
	public boolean idCheck(ReviewReplyVO vo) {
		String dbId = mapper.idCheck(vo.getReplyNo());
		return encoder.matches(vo.getReplyId(), dbId);
	}

	@Override
	public void update(ReviewReplyVO vo) {
		
	}

}
