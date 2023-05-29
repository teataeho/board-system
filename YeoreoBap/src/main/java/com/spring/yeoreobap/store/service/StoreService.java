package com.spring.yeoreobap.store.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.StoreVO;
import com.spring.yeoreobap.store.mapper.IStoreMapper;
import com.spring.yeoreobap.util.PageVO;

@Service
public class StoreService implements IStoreService {

	@Autowired
	private IStoreMapper mapper;	
	
	@Override
	public List<StoreVO> getList(PageVO vo) {
		return mapper.getList(vo);
	}
	
	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}

}
