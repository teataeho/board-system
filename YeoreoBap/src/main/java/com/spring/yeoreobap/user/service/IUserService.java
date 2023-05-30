package com.spring.yeoreobap.user.service;

import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.util.PageVO;

@Service
public interface IUserService {

	//아이디 중복 확인
	int idCheck(String userId);

	//회원 가입
	void join(UserVO vo);

	//로그인
	String login(String userId, String userPw);

	//MyPage
	//회원 정보 얻기
	UserVO getInfo(String userId, PageVO vo);

	//회원 정보 수정
	void updateUser(UserVO vo);
}
