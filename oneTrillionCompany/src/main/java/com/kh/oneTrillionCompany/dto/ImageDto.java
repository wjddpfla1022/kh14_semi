package com.kh.oneTrillionCompany.dto;

import lombok.Data;

@Data
public class ImageDto {
	private int itemNo; //상품번호 외래키
	private int attachNo; //파일번호 외래키
}
