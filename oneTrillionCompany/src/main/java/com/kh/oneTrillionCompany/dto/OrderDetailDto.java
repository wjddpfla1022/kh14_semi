package com.kh.oneTrillionCompany.dto;

import lombok.Data;

@Data
public class OrderDetailDto {
	private int orderDetailNo;
	private int orderDetailOrderNo;
	private int orderDetailItemNo;
	private String orderDetailBuyer;
	private int orderDetailPrice;
	private int orderDetailCnt;
	private String orderDetailStatus;

}
