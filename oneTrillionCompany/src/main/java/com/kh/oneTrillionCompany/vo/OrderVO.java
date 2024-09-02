package com.kh.oneTrillionCompany.vo;

import lombok.Data;

@Data
public class OrderVO {
	private int itemNo;
	private int itemPrice;
	private String buyer;
	private int cnt;
	private int orderNo;
	private int cartNo;
}
