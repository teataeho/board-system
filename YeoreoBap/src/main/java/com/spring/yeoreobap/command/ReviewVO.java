package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
	CREATE TABLE review(
		review_no INT PRIMARY KEY AUTO_INCREMENT,
		writer VARCHAR(50) NOT NULL,
		rest_id VARCHAR(50) NOT NULL,
		content VARCHAR(3000) NOT NULL,
		reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
		update_date DATETIME DEFAULT NULL
	);
 */

@Getter
@Setter
@ToString
public class ReviewVO {

	private int review_no;
	private String writer, restId, title, content;
	private LocalDateTime regDate, updateDate;
}