package com.kh.oneTrillionCompany.vo;

import lombok.Data;

@Data
public class CartItemVO {
	private int cartNo;
	private int cartItemNo;
	private String cartBuyer;
	private int cartCnt;
	private int itemAttachNo;
	private int cartTotalPrice;
	private String itemName;
	private String itemColor;
	private int itemPrice;
	private int itemStock;
}
