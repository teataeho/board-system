package com.spring.yeoreobap.command;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
	CREATE TABLE participants (
	    p_no INT PRIMARY KEY AUTO_INCREMENT,
	    party_no INT NOT NULL,							# REFERENCES party(party_no)
	    user_id VARCHAR(50) NOT NULL					# 세션에서 가져오기
	);
*/

@Getter @Setter @ToString
public class ParticipantsVO {
	
	private int pNo, partyNo;
	private String userId;

}
