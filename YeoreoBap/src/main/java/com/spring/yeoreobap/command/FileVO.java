package com.spring.yeoreobap.command;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FileVO {

	String fileName, uploadPath, fileRealName;
	int reviewNo;
	
}
