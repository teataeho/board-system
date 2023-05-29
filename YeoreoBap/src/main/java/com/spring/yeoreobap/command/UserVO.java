package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
CREATE TABLE users(
	user_id VARCHAR(50) PRIMARY KEY,
   user_pw VARCHAR(50) NOT NULL,
   user_name VARCHAR(50) NOT NULL,
   user_nick VARCHAR(50) NOT NULL,
   user_phone VARCHAR(50),
   user_email1 VARCHAR(50),
   user_email2 VARCHAR(50),
   addr_zip_num VARCHAR(50),
   addr_basic VARCHAR(300),
   addr_detail VARCHAR(300),
   reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   temperature INT NOT NULL DEFAULT '0'
);
*/

@Getter @Setter @ToString
public class UserVO {

	private String userId;
	private String userPw;
	private String userName;
	private String userNick;
	private String userPhone;
	private String userEmail1;
	private String userEmail2;
	private String addrMine;
	private String addrClose;
	private LocalDateTime regDate;
	private int temperature;
}
