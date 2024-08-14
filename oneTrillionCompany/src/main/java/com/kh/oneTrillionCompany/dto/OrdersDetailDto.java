package com.kh.oneTrillionCompany.dto;

import lombok.Data;

@Data
public class OrdersDetailDto {
	private int orderDetailNo;
	private int orderDetailItemNo;
	private int orderDetailOrderNo;
	private int orderDetailPrice;
	private int orderDetailCnt;

}
