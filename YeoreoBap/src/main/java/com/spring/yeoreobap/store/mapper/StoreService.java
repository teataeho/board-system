package com.spring.yeoreobap.store.mapper;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.StoreVO;
import com.spring.yeoreobap.store.service.IStoreService;
import com.spring.yeoreobap.util.PageVO;

@Service
public class StoreService implements IStoreService {

	@Autowired
	private IStoreMapper mapper;
	
	//목록
	@Override
	public List<StoreVO> getList(PageVO vo) {
		return mapper.getList(vo);
	}

	//상세
	@Override
	public StoreVO getContent(int sno) {
		return mapper.getContent(sno);
	}
	
	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}

}
