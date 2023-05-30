package com.spring.yeoreobap.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.user.mapper.IUserMapper;
import com.spring.yeoreobap.util.PageVO;

@Service
public class UserService implements IUserService {

	@Autowired
	private IUserMapper mapper;
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Override
	public int idCheck(String userId) {
		return mapper.idCheck(userId);
	}

	@Override
	public void join(UserVO vo) {
		mapper.join(vo);
	}

	@Override
	public String login(String userId, String userPw) {
		String dbPw = mapper.login(userId);	
		if(dbPw != null) {
			if(encoder.matches(userPw, dbPw)) {
				return userId;
			}
		}
		return null;
	}

	@Override
	public UserVO getInfo(String userId, PageVO vo) {
		return mapper.getInfo(userId, vo);
	}

	@Override
	public void updateUser(UserVO vo) {
		mapper.updateUser(vo);
	}
}
