package com.spring.yeoreobap.user.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.user.mapper.IUserMapper;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;
@Slf4j
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
		log.info("암호화 전 비번: " + vo.getUserPw());
		String securePw = encoder.encode(vo.getUserPw());
		log.info("암호화 후 비번: " + securePw);
		vo.setUserPw(securePw);
		mapper.join(vo);
	}

	@Override
	public UserVO login(String userId, String userPw) {
		String dbPw = mapper.login(userId);	
		if(dbPw != null) {
			if(encoder.matches(userPw, dbPw)) {
				return mapper.getUser(userId);
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
