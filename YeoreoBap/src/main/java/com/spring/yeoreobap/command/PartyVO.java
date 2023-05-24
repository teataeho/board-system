package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PartyVO {
	
	private int partyNo;
	private String restId;
	private String writer, title, content;
	private LocalDateTime regDate, updateDate;	

}