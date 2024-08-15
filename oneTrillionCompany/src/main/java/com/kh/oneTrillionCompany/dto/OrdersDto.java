package com.kh.oneTrillionCompany.dto;

import java.util.Date;

import lombok.Data;

@Data
public class OrdersDto {
	private int orderNo;
	private String orderMemberId;
	private int orderCartNo;
	private int orderPrice;
	private Date orderDay;
	private String orderStatus;
}
