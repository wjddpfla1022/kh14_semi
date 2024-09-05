package com.kh.oneTrillionCompany.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ItemDto {
	private int itemNo; //상품번호
	private String itemName; //상품명
	private int itemPrice; //정가
	private int itemSalePrice; //판매가
	private Date itemDate; //등록일
	private int itemCnt; //재고
	private String itemSize; //사이즈
	private String itemCate1; //카테고리 (상의, 하의, 슈즈)
	private String itemCate2; //카테고리2 (셔츠, 티셔츠)
	private String itemCate3; //카테고리3 (반팔, 긴팔, 후드)
	private String itemDiscountRate;
	private String itemColor;
	private int itemMain;
	
}
