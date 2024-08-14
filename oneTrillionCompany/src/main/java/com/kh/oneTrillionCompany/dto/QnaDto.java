package com.kh.oneTrillionCompany.dto;

import java.util.Date;

import lombok.Data;

@Data
public class QnaDto {
	private int qnaNo;
	private String qnaWriter;
	private String qnaTitle;
	private String qnaContent;
	private Date qnaTime;
}
