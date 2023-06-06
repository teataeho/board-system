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
	     reg_date DATETIME DEFAULT CURRENT_TIMESTAMP
	 );
 */
@Getter
@Setter
@ToString
public class ReviewReplyVO {

	private int replyNo;
	private int reviewNo;
	
	private String reply;
	private String replyId;
	private LocalDateTime regDate;

	//조인용
	private String userNick;

}
