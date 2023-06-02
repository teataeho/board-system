package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
<<<<<<< HEAD
	CREATE TABLE review (
	    review_no INT PRIMARY KEY AUTO_INCREMENT,
	    writer VARCHAR(50) NOT NULL,
	    sno INT NOT NULL,
	    title VARCHAR(300) NOT NULL,
	    content VARCHAR(3000) NOT NULL,
	    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	    update_date DATETIME DEFAULT NULL,
	    file_name VARCHAR(200)
=======
	CREATE TABLE review(
		review_no INT PRIMARY KEY AUTO_INCREMENT,
		writer VARCHAR(50) NOT NULL,
		sno INT(50) NOT NULL,
		title VARCHAR(300) NOT NULL,
		content VARCHAR(3000) NOT NULL,
		reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
		update_date DATETIME DEFAULT NULL
>>>>>>> 1a467eca75f935cecd2b950d4c79fedd1785029d
	);
 */

@Getter @Setter @ToString
public class ReviewVO {

	private int reviewNo, sno;
<<<<<<< HEAD
	private String writer, title, content, fileName;
	private LocalDateTime regDate, updateDate;

}
=======
	private String writer, title, content;
	private LocalDateTime regDate, updateDate;

	private int reviewReplyCnt;
}
>>>>>>> 1a467eca75f935cecd2b950d4c79fedd1785029d
