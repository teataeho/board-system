package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
/*
CREATE TABLE party (
    party_no INT PRIMARY KEY AUTO_INCREMENT,
    rest_id VARCHAR(50) NOT NULL,
    writer VARCHAR(50) NOT NULL,
    title VARCHAR(100) NOT NULL,
    content VARCHAR(3000) NOT NULL,
    reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_date DATETIME DEFAULT NULL,
    max INT NOT NULL
);
*/
@Setter
@Getter
@ToString
public class PartyVO {
	
	private int partyNo, max;
	private String restId;
	private String writer, title, content;
	private LocalDateTime regDate, updateDate;	
	private int max;
}
