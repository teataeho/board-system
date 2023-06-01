package com.spring.yeoreobap.store.service;

import java.util.List;

import com.spring.yeoreobap.command.StoreVO;

public interface IStoreService {
	
	//카카오맵에 가져갈 가게리스트
	List<StoreVO> getList(String uptaeNm, String Addr);

	//제이슨파일 db에 넣기위한 메서드
	void readOpenStoresFromJson();
	
	StoreVO getStoreInfo(int sno);
}