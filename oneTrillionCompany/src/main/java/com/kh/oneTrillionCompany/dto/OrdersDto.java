package com.kh.oneTrillionCompany.dto;

import java.util.Date;

import lombok.Data;

@Data
public class OrdersDto {
	private int orderNo;
	private int orderPrice;
	private Date orderDate;
	private String orderMemo;
	private String orderBuyer;
}
