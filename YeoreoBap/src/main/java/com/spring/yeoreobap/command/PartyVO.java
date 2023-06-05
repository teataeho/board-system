package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
	CREATE TABLE party (
	    party_no INT PRIMARY KEY AUTO_INCREMENT,
	    sno INT NOT NULL,
	    bplc_nm VARCHAR(50) NOT NULL,
	    writer VARCHAR(50) NOT NULL,
	    title VARCHAR(100) NOT NULL,
	    content VARCHAR(3000) NOT NULL,
	    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	    update_date DATETIME DEFAULT NULL,
	    max INT NOT NULL,
	    upload_path VARCHAR(50),
	    file_name VARCHAR(200) NOT NULL,
	    view_num INT DEFAULT 0
	);
*/

@Getter
@Setter
@ToString
public class PartyVO {

	private int partyNo, sno, max, viewNum, attendedNum, attended;
	private String bplcNm, writer, title, content, uploadPath, fileName, rdnWhlAddr;
	private LocalDateTime regDate, updateDate;
	
	// Join
	private String writerNick;
}