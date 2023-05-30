package com.spring.yeoreobap.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageVO {

	private int pageNum, cpp;

	//검색 요청에 필요한 필드를 추가
	private String keyword;
	private String condition;

	public PageVO() {
		this.pageNum = 1;
		this.cpp = 10;
	}

	public int getPageStart() {
		return (pageNum - 1) * cpp;
	}

}
