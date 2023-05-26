package com.spring.yeoreobap.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageVO {
	
	private int pageNum, cpp;
	
	public PageVO() {
		this.pageNum = 1;
		this.cpp = 10;
	}
	
	public int getPageStart() {
		return (pageNum - 1) * cpp;
	}

}
