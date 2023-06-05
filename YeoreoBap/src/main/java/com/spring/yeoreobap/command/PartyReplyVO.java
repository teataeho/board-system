package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
	CREATE TABLE party_reply (
	    reply_no INT PRIMARY KEY AUTO_INCREMENT,
	    party_no INT NOT NULL,							# REFERENCES party(party_no)
	    writer VARCHAR(50) NOT NULL,					# REFERENCES user(user_id)
	    content VARCHAR(100) NOT NULL,
	    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP
	);
 */

@Getter @Setter @ToString
public class PartyReplyVO {

	private int replyNo, partyNo;
	private String writer, content;
	private LocalDateTime regDate;

}
