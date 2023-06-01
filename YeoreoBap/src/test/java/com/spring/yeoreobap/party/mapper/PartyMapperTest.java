package com.spring.yeoreobap.party.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.spring.yeoreobap.command.PartyVO;


@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/config/db-config.xml"
})
public class PartyMapperTest {

	@Autowired
	private IPartyMapper mapper;
	
	
	
	@Test
	@DisplayName("상세보기")
	void getArticleTest() {
		mapper.getArticle(100);
	}
	
	@Test
	@DisplayName("수정")
	void updateTest() {
		PartyVO vo = new PartyVO();
		vo.setPartyNo(100);
		vo.setTitle("이런");
		vo.setContent("수박.....");
		
		mapper.update(vo);
	}
	
	@Test
	@DisplayName("삭제")
	void deleteTest() {
		mapper.delete(102);
	}
	
}
