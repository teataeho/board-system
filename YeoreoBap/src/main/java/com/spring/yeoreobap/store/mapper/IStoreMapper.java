package com.spring.yeoreobap.store.mapper;

import java.util.List;

import com.spring.yeoreobap.command.StoreVO;

public interface IStoreMapper {
	
	List<StoreVO> getList(String addr);
	
	void inputData(StoreVO vo);

}