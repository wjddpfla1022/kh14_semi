package com.kh.oneTrillionCompany.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ItemDto {
	private int itemNo; //상품번호
	private int cateNo; //카테고리번호 왜래키
	private String itemName; //상품명
	private int itemPrice; //정가
	private int itemSalePrice; //판매가
	private Date itemDate; //등록일
	private int itemCnt; //재고
	private String itemSize; //사이즈
}
