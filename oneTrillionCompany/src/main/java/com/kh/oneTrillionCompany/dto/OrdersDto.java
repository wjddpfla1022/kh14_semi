package com.kh.oneTrillionCompany.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class OrdersDto {
	private int orderNo;
	private int orderPrice;
	private String orderMemo;
	private String orderBuyer;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date orderDate;
}
