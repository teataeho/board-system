package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FreeBoardVO {

	private int bno;
	private String title;
	private String writer;
	private String content;
	private LocalDateTime regDate;
	private LocalDateTime updateDate;

	//하나의 게시물이 몇 개의 댓글을 포함하는지 
	private int replyCnt;

}

