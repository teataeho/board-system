package com.spring.yeoreobap.star.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.StarVO;
import com.spring.yeoreobap.star.mapper.IStarMapper;

@Service
public class StarService implements IStarService {

	@Autowired
	private IStarMapper mapper;
	
	@Override
	public void insertStar(StarVO vo) {
		mapper.insertStar(vo);
	}

}
