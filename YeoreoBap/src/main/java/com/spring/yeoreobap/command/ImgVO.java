package com.spring.yeoreobap.command;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class ImgVO {
	
	private int boardNo;
	private String uploadPath, fileLoca, fileName;

}
