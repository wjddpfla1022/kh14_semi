package com.kh.oneTrillionCompany.dto;

import lombok.Data;

@Data
public class CartDto {
	private int cartNo;
	private int cartItemNo;
	private String cartBuyer;
	private int cartCnt;
	private int itemAttachNo;
	private int cartTotalPrice;
	
}
