package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 CREATE TABLE partyReply(
 	reply_no INT PRIMARY KEY AUTO_INCREMENT,
 	party_no INT NOT NULL,
 	writer VARCHAR(50),
 	content VARCHAR(1000),
 	reg_date DATETIME DEFAULT CURRENT_TIMESTAMP
 );*/
@Getter
@Setter
@ToString
public class PartyReplyVO {

	private int replyNo;
	private int partyNo;
	private String writer;
	private String content;
	private LocalDateTime regDate;
	//replPw, updateDate??
}
