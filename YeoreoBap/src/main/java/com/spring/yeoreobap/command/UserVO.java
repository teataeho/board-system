package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class UserVO {
	
	private String userId, userPw, userName, userNick, userEmail1, userEmail2;
	private LocalDateTime regDate;
	private double temperature;
	private String addrMine, addrClose1, addrClose2;

}
