package com.spring.yeoreobap.command;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
/*
 CREATE TABLE store(
	sno INT PRIMARY KEY AUTO_INCREMENT,
    siteTel VARCHAR(100) NOT NULL,
    rdnWhlAddr VARCHAR(300) NOT NULL,
    bplcNm VARCHAR(50) NOT NULL,
    uptaeNm VARCHAR(20) NOT NULL,
    x long NOT NULL, 
    y long NOT NULL
); 
*/
@Getter @Setter @ToString
public class StoreVO {
	
	//공공데이터 프로퍼티명과 같은 이름으로 선언했습니다.
	
	private int sno; //사업장 번호(전화번호X)
	private String siteTel;	//소재지전화
	private String rdnWhlAddr;	//도로명전체주소
	private String bplcNm;	//사업장명
	private String uptaeNm;	//업태구분명
	private long x;	//x좌표
	private long y;	//y좌표
	
}
