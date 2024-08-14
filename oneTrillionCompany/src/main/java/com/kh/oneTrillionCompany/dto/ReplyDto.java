package com.kh.oneTrillionCompany.dto;

import java.util.Date;
import lombok.Data;

@Data
public class ReplyDto {
	private int replyNo;
	private String replyWriter;
	private int replyOrigin;
	private String replyContent;
	private Date replyTime;
}
