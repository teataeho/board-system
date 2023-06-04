package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 CREATE TABLE reviewReply(
 	reply_no INT PRIMARY KEY AUTO_INCREMENT,
 	review_no INT NOT NULL,
 	
 	review_reply VARCHAR(1000),
 	reply_id VARCHAR(50),
 	reply_pw VARCHAR(100),
 	reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
 	update_date DATETIME DEFAULT NULL
 );*/
@Getter
@Setter
@ToString
public class ReviewReplyVO {

	private int replyNo;
	private int reviewNo;
	
	private String reviewReply;
	private String replyId;
	private String replyPw;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
}