package com.kh.oneTrillionCompany.dto;

import lombok.Data;

@Data
public class ReviewDto {
	private int reviewNo;
	private int reviewItemNo;
	private String reviewWriter;
	private String reviewContent;
	private int reviewScore;
	private String reviewItemName;
	
	//메소드 추가
	public String getReviewWriterString() {
		if(reviewWriter == null)
			return "탈퇴한 사용자";
		return reviewWriter;
	}
}
