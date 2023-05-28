package com.spring.yeoreobap.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.user.mapper.IUserMapper;

@Service
public class UserService implements IUserService {
	
	@Autowired
	private IUserMapper mapper;

	@Override
	public int idCheck(String userId) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void join(UserVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public String login(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateUser(UserVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public void deleteUser(String userId) {
		// TODO Auto-generated method stub

	}

}
