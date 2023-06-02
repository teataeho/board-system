package com.spring.yeoreobap.command;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*
 	CREATE TABLE store (
		sno INT PRIMARY KEY AUTO_INCREMENT,
		site_tel VARCHAR(30),
		rdn_whl_addr VARCHAR(100),
		bplc_nm VARCHAR(100),
		uptae_nm VARCHAR(20),
		dtlstatenm VARCHAR(10),
		x VARCHAR(50),
		y VARCHAR(50),
		star_rate INT DEFAULT 0
	);
 */

@Getter @Setter @ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class StoreVO {

	private int sno; 			// 사업장 번호 (전화번호 X)

	@JsonProperty("sitetel")
	private String siteTel; 	// 소재지전화

	@JsonProperty("rdnwhladdr")
	private String rdnWhlAddr; 	// 도로명 전체 주소

	@JsonProperty("bplcnm")
	private String bplcNm; 		// 사업장명

	@JsonProperty("uptaenm")
	private String uptaeNm; 	// 업태 구분명

	private String dtlstatenm; 	// 영업/폐업 여부
	private String x;			// x좌표
	private String y; 			// y좌표
	private int starRate; 		// 별점

}