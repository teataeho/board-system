package com.spring.yeoreobap.partyReply.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.PartyReplyVO;
import com.spring.yeoreobap.partyReply.mapper.IPartyReplyMapper;
import com.spring.yeoreobap.util.PageVO;

@Service
public class PartyReplyService implements IPartyReplyService {

	@Autowired
	private IPartyReplyMapper mapper;
	
	@Override
	public void replyRegist(PartyReplyVO vo) {
		mapper.replyRegist(vo);
	}

	@Override
	public int getTotal(int partyNo) {
		return mapper.getTotal(partyNo);
	}

	@Override
	public void update(PartyReplyVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int replyNo) {
		mapper.delete(replyNo);
	}

	@Override
	public List<PartyReplyVO> getList(Map<String, Object> data) {
		// TODO Auto-generated method stub
		return null;
	}

//	@Override
//	public List<PartyReplyVO> getList(int partyNo, int pageNum) {
//		PageVO vo = new PageVO();
//		vo.setPageNum(pageNum);
//		vo.setCpp(5);
//		Map<String, Object> data = new HashMap<>();
//		data.put("paging", vo);
//		data.put("party_board_no", partyNo);
//		return mapper.getList(data);
//	}
}
