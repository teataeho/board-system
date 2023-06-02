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
	public int getTotal(int partyNo) {
		return mapper.getTotal(partyNo);
	}
	
	@Override
	public boolean userVerification(ReviewReplyVO vo, HttpSession session) {
		if(session.getAttribute("userInfo").equals(vo.getWriter())) return true;
		else return false;
	}

	@Override
	public void update(ReviewReplyVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int replyNo) {
		mapper.delete(replyNo);
	}

	@Override
	public List<ReviewReplyVO> getList(int replyNo, int pageNum) {
		PageVO vo = new PageVO();
		vo.setPageNum(pageNum);
		vo.setCpp(5);
		Map<String, Object> data = new HashMap<>();
		data.put("paging", vo);
		data.put("reply_no", replyNo);
		return mapper.getList(data);
	}

}
