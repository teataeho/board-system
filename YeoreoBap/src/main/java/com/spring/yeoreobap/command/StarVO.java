package com.spring.yeoreobap.command;

import lombok.ToString;

import lombok.Setter;

import lombok.Getter;

@Getter
@Setter
@ToString
public class StarVO {

	private int star_no, sno;
    private String user_id;
    private double star_rate;
    
}
