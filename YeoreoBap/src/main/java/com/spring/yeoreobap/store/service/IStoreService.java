package com.spring.yeoreobap.store.service;

import java.util.List;

import com.spring.yeoreobap.command.StoreVO;

public interface IStoreService {
	
	List<StoreVO> getList(String uptaeNm, String Addr);

	void readOpenStoresFromJson();
}