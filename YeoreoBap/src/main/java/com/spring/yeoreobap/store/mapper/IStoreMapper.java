package com.spring.yeoreobap.store.mapper;

import java.util.List;

import com.spring.yeoreobap.command.StoreVO;
import com.spring.yeoreobap.util.PageVO;

public interface IStoreMapper {

	//목록
	List<StoreVO> getList(PageVO vo);

	//상세
	StoreVO getContent(int sno);

	//전체 게시물 수
	int getTotal(PageVO vo);

}
