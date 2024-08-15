package com.kh.oneTrillionCompany.dto;

import lombok.Data;

@Data
public class ReviewDto {
	private int reviewNo;
	private int reviewItemNo;
	private String reviewWriter;
	private String reviewContent;
	private int reviewScore;
}
