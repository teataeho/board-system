package com.spring.yeoreobap.command;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ReviewBoardVO {
	
	private int review_no;
	private String writer, restId, title, content;
	private LocalDateTime regDate, updateDate;

}
