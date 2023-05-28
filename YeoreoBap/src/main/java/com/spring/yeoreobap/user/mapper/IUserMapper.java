package com.spring.yeoreobap.user.mapper;

import com.spring.yeoreobap.command.UserVO;

public interface IUserMapper {

	//아이디 중복 확인
	int idCheck(String userId);

	//회원 가입
	void join(UserVO vo);

	//로그인
	String login(String userId);

	//회원 정보 수정
	void updateUser(UserVO vo);
	
	//회원 탈퇴
	void deleteUser(String userId);

}
