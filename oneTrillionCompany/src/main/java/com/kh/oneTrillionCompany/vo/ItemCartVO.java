package com.kh.oneTrillionCompany.vo;

import lombok.Data;

@Data
public class ItemCartVO {
	private int buyerItemNo; //사용자가 선택한 상품 번호
	private String buyerItemColor; //사용자가 선택한 상품 색깔
	private String buyerItemSize; //사용자가 선택한 사이즈
	private int buyeritemCnt; //사용자가 선택한 상품 수량
	private int buyerItemAttachNo;
	private String buyer;
}
