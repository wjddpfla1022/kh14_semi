package com.kh.oneTrillionCompany.dto;

import lombok.Data;

@Data
public class QnaDto {
	private int replyNo;
	private String replyWriter;
	private int replyOrigin;
	private String replyContent;
	private Date replyTime;
}
