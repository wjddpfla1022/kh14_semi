package com.kh.oneTrillionCompany.dto;

import lombok.Data;

@Data
public class ConnectionOCDto { //결제 후 장바구니 수량 업데이트를 위한 테이블
	private int cartNo;
	private String buyer;
	private int cntPayment;
}
