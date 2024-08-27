package com.kh.oneTrillionCompany.vo;

import lombok.Data;

@Data
public class CartVO {
	private int cartItemNo;
	private int cartItemPrice;
	private int cartItemCnt;
	private String buyer;
}
