package com.spring.yeoreobap.command;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class StoreVO {
    private int sno; //사업장 번호(전화번호X)
    @JsonProperty("sitetel")
    private String siteTel;    //소재지전화
    @JsonProperty("rdnwhladdr")
    private String rdnWhlAddr;    //도로명전체주소
    @JsonProperty("bplcnm")
    private String bplcNm;    //사업장명
    @JsonProperty("uptaenm")
    private String uptaeNm;    //업태구분명
    private String dtlstatenm; //영업/폐업 여부
    private String x;    //x좌표
    private String y;    //y좌표
    
}