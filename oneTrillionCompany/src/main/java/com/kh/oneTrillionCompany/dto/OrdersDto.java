package com.kh.oneTrillionCompany.dto;

import java.util.Date;

import lombok.Data;

@Data
public class OrdersDto {
	private int ordersNo;
	private String ordersMemberId;
	private int ordersCartNo;
	private int ordersPrice;
	private Date ordersDay;
	private String ordersStatus;
}
