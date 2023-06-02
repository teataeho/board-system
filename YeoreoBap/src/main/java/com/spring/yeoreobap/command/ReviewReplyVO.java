package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
	 CREATE TABLE review_reply (
	    reply_no INT PRIMARY KEY AUTO_INCREMENT,
	    review_no INT NOT NULL,
	    writer VARCHAR(50) NOT NULL,
	    content VARCHAR(100) NOT NULL,
	    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP
	);
*/

@Getter @Setter @ToString
public class ReviewReplyVO {

<<<<<<< HEAD
	private int replyNo, reviewNo;
	private String writer, content;
	private LocalDateTime regDate;

=======
	private int replyNo;
	private int reviewNo;
	
	private String reply;
	private String replyId;
	private String replyPw;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;
>>>>>>> 1a467eca75f935cecd2b950d4c79fedd1785029d
}
