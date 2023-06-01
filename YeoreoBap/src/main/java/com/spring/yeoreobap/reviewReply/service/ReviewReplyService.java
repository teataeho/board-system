package com.spring.yeoreobap.reviewReply.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.PartyReplyVO;
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
	public void replyRegist(ReviewReplyVO vo) {
		mapper.replyRegist(vo);

	}

	@Override
	public int getTotal(int partyNo) {
		return mapper.getTotal(partyNo);
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

	@Override
	public boolean pwCheck(ReviewReplyVO vo) {
		String dbPw = mapper.pwCheck(vo.getReplyNo());
		return encoder.matches(vo.getReplyPw(), dbPw);
	}

}
