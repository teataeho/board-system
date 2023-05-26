package com.spring.yeoreobap.party.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.party.mapper.IPartyMapper;
import com.spring.yeoreobap.util.PageVO;

@Service
public class PartyService implements IPartyService {
	
	@Autowired
	private IPartyMapper mapper;

	@Override
	public void regist(PartyVO vo) {
		mapper.regist(vo);
	}

	@Override
	public List<PartyVO> getList(PageVO paging) {		
		return mapper.getList(paging);
	}

	@Override
	public PartyVO getArticle(int partyNo) {
		return mapper.getArticle(partyNo);
	}

	@Override
	public void update(PartyVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int partyNo) {
		mapper.delete(partyNo);
	}

	@Override
	public int getTotal() {
		return mapper.getTotal();
	}

	@Override
	public void attend(String userId, int partyNo) {
			mapper.attend(userId, partyNo);
	}

}
