package com.spring.yeoreobap.command;

/*
 	CREATE TABLE party (
	    party_no INT PRIMARY KEY AUTO_INCREMENT,
	    sno INT NOT NULL, 								## REFERENCES store(sno)
	    bplc_nm VARCHAR(50) NOT NULL,
	    writer VARCHAR(50) NOT NULL,					## REFERENCES user(user_id)
	    writer_nick VARCHAR(50),
	    title VARCHAR(100) NOT NULL,
	    content VARCHAR(3000) NOT NULL,
	    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	    update_date DATETIME DEFAULT NULL,
	    max INT NOT NULL,
	    upload_path VARCHAR(50),
	    file_name VARCHAR(200) NOT NULL
	);
 */

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class PartyVO {
	
	private int partyNo, max;
	private int sno;
	private String writer, writerNick, title, content;
	private LocalDateTime regDate, updateDate;
	private String uploadPath, fileName;
	private String bplcNm, rdnWhlAddr;
	
}