package com.kh.oneTrillionCompany.dto;

import java.util.Date;

import lombok.Data;

@Data
public class RefundDto {
	private int refundOrderNo;
	private String refundMemo;
	private Date refundDate;
}
