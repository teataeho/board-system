package com.spring.yeoreobap.command;

import lombok.ToString;

import lombok.Setter;

import lombok.Getter;

@Getter
@Setter
@ToString
public class StarVO {

    private int starNo, sno;
    private String userId;
    private double starRate;

}
