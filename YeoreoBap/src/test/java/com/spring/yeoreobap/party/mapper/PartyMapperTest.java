package com.spring.yeoreobap.party.mapper;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.review.mapper.IReviewMapper;
import com.spring.yeoreobap.user.mapper.IUserMapper;


@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/config/db-config.xml"
})
public class PartyMapperTest {

	@Autowired
	private IPartyMapper mapper;
	@Autowired
	private IReviewMapper reviewMapper;
	@Autowired
	private IUserMapper userMapper;
	
	@Test
	@DisplayName("글등록")
	void registTest() {
		for(int i=0; i< 100; i++) {
		PartyVO vo = new PartyVO();
//		vo.setRestId("3007-10-12312312");
		vo.setWriter("누구");
		vo.setTitle("파티모집" + i);
		vo.setContent("파티모집중~~~" + i);
		mapper.regist(vo);
		}
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
	
	@Test
	@DisplayName("후기매크로")
	void makeTest() {
		for(int i=0; i< 100; i++) {
			ReviewVO vo = new ReviewVO();
			vo.setTitle("후기" + i);
			vo.setWriter("user" + i);
			vo.setContent("내용" + i);
			vo.setPassword("1q2w3e4r");
			reviewMapper.regist(vo);
		}
	}
	
	@Test
	@DisplayName("유저매크로")
	void makeUser() {
		for(int i=0; i<100; i++) {
			UserVO vo = new UserVO();
			vo.setUserEmail1("abc" + i);
			vo.setUserEmail2("naver.com");
			vo.setUserNick("사용자" + i);
			vo.setUserName("임의의사람" + i);
			vo.setUserId("user" + i);
			vo.setUserPw("1q2w3e4r");
			vo.setAddrDong("노고산동");
			vo.setAddrGu("마포구");
			userMapper.join(vo);
		}
	}
	
}
