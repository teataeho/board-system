package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
<<<<<<< HEAD
	CREATE TABLE users(
	   user_id VARCHAR(50) PRIMARY KEY,
	   user_pw VARCHAR(300) NOT NULL,
	   user_name VARCHAR(50) NOT NULL,
	   user_nick VARCHAR(50) NOT NULL,
	   user_email1 VARCHAR(50) NOT NULL,
	   user_email2 VARCHAR(50) NOT NULL,
	   addr_gu VARCHAR(300) NOT NULL,
	   addr_dong VARCHAR(300) NOT NULL,
	   reg_date DATETIME DEFAULT CURRENT_TIMESTAMP
	);
=======
CREATE TABLE users(
   user_id VARCHAR(50) PRIMARY KEY,
   user_pw VARCHAR(200) NOT NULL,
   user_name VARCHAR(50) NOT NULL,
   user_nick VARCHAR(50) NOT NULL,
   user_email1 VARCHAR(50),
   user_email2 VARCHAR(50),
   addr_gu VARCHAR(300),
   addr_dong VARCHAR(300),
   reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   temperature INT NOT NULL DEFAULT '0'
);
>>>>>>> 1a467eca75f935cecd2b950d4c79fedd1785029d
*/

@Getter @Setter @ToString
public class UserVO {

	private String userId, userPw, userName, userNick, userEmail1, userEmail2, addrGu, addrDong;
	private LocalDateTime regDate;
<<<<<<< HEAD

=======
>>>>>>> 1a467eca75f935cecd2b950d4c79fedd1785029d
}
