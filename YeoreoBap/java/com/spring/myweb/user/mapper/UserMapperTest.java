package com.spring.myweb.user.mapper;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.spring.myweb.command.UserVO;
import com.spring.myweb.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/config/db-config.xml")
@Slf4j
public class UserMapperTest {

	@Autowired
	private IUserMapper mapper;
	
	@Test
	@DisplayName("회원가입을 진행했을 때 회원가입에 성공해야 한다.")
	void registTest() {
		UserVO vo = new UserVO();
		vo.setUserId("abc1234");
		vo.setUserPw("aaa1111!");
		vo.setUserName("홍길동");
		
		mapper.join(vo);
	}
	
	@Test
	@DisplayName("존재하는 회원 아이디를 조회하면 1이 리턴되어야 한다.")
	void checkIdTest() {
		
		String userId = "abc1234";	
//		assertEquals(id, vo.getUserId());
		assertEquals(1, mapper.idCheck(userId));
	}
	

	@Test
	@DisplayName("존재하는 회원 아이디와 올바른 비밀번호를 입력하면 회원의 정보가 리턴되어야 한다.")
	void loginTest() {
		String userId = "abc1234";
		String userPw = "aaa1111!";
//		UserVO vo = mapper.login(id, pw);
		assertNotNull(mapper.login(userId));

	}

	
	@Test
	@DisplayName("존재하지 않는 회원 아이디를 입력하면 null이 온다.")
	void getInfoTest() {
//		String id = "abc1234";
//		UserVO vo = new UserVO(); 

		PageVO paging = new PageVO();
		UserVO vo = mapper.getInfo("abc1234", paging);
		log.info(vo.toString());
		
//		assertNull(mapper.getInfo("qweasdzxc"));
	}

	
	@Test
	@DisplayName("아이디를 제외한 회원의 정보를 수정할 수 있다.")
	void updateTest() {
		UserVO vo = new UserVO();
		vo.setUserId("abc1234");
		vo.setUserPw("aaa1111!");
		vo.setUserName("수정 이름");
		vo.setUserPhone1("수정 폰1");
		vo.setUserPhone2("수정 폰2");
		vo.setUserEmail1("수정 이메일1");
		vo.setUserEmail2("수정 이메일2");
		vo.setAddrBasic("수정 주소");
		vo.setAddrDetail("수정 주소 상세");
		vo.setAddrZipNum("주소 집넘");
		mapper.updateUser(vo);
//		assertEquals(mapper.getInfo("abc1234").getUserName(),vo.getUserName());
	}
	
}
