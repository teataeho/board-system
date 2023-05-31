package com.spring.yeoreobap.store.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.yeoreobap.command.StoreVO;

public interface IStoreMapper {
	
	List<StoreVO> getList(@Param("uptaeNm") String uptaeNm,@Param("addr") String addr);
	
	void inputData(StoreVO vo);
	

}
