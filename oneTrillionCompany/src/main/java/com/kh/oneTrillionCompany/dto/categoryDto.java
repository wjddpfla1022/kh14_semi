package com.kh.oneTrillionCompany.dto;

import lombok.Data;

@Data
public class categoryDto {
	//카테고리
	private int cateNo; //카테고리번호
	private int cateNo2; //카테고리번호 외래키
	private String cateName; //카테고리명
}
