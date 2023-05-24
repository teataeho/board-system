package com.spring.yeoreobap.user.mapper;

import org.apache.ibatis.annotations.Param;

import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.util.PageVO;

public interface IUserMapper {
	//아이디 중복 확인
	int idCheck(String userId);

	//회원 가입
	void join(UserVO vo);

	//로그인
	/*
		 - MyBatis로 DB연동 진행할 때 파라미터 값이 2개 이상일 때 에러 발생한다.
		 1. @Param을 이용해서 이름 붙여주는 방법(xml 파일에서 해당 값을 지목할 수 있는 이름 붙이기)
		 2. Map으로 포장
		 3. 클래스 디자인해서 객체 하나만 매개값으로 보내는 방법(VO)
		 															중 하나 선택*/
	String login(String userId);

	//회원 정보 얻기
	UserVO getInfo(@Param("userId") String userId, @Param("paging") PageVO vo);

	//회원 정보 수정
	void updateUser(UserVO vo);

}
