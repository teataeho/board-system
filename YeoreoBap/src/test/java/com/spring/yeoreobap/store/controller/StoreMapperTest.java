package com.spring.yeoreobap.store.controller;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.spring.yeoreobap.command.StoreVO;
import com.spring.yeoreobap.store.mapper.IStoreMapper;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;


@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/config/db-config.xml"
})
public class StoreMapperTest {

	@Autowired
	private IStoreMapper mapper;
	
	@Test
	@DisplayName("글리스트")
	void getListTest() {
		List<StoreVO> list = mapper.getList("%(동교동)");
	}
	
}
