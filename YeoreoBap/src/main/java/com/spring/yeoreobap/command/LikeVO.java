package com.spring.yeoreobap.command;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LikeVO {

	private int lno, partyNo, reviewNo;
	private String userId;

}
