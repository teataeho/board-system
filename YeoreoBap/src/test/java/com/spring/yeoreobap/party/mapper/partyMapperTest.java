package com.spring.yeoreobap.party.mapper;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.spring.yeoreobap.command.partyVO;

@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/config/db-config.xml"
})
public class partyMapperTest {

	@Autowired
	private IPartyMapper mapper;
	
	@Test
	@DisplayName("글등록")
	void registTest() {
		for(int i=0; i< 100; i++) {
		partyVO vo = new partyVO();
		vo.setRestId("3007-10-12312312");
		vo.setWriter("누구");
		vo.setTitle("파티모집" + i);
		vo.setContent("파티모집중~~~" + i);
		mapper.regist(vo);
		}
	}
	
	@Test
	@DisplayName("글리스트")
	void getListTest() {
		List<partyVO> list = mapper.getList();
		
		for(partyVO vo : list) {
			System.out.println(vo);
		}
	}
	
}
