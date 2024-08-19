package com.kh.oneTrillionCompany.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberBlockVO {
	private String memberId;
	private String memberPw;
	private String memberName;
	private String memberNickname;
	private String memberEmail;
	private String memberBlock;
	private String memberRank;
	private int memberPoint;
	private Date memberJoin;
	private Date memberLogin;
	private String memberPost;
	private String memberAddress1;
	private String memberAddress2;
	private int memberHeight;
	private int memberWeight;
	
	private int blockNo;
	private String blockMemberId;
	private String blockType;
	private String blockMemo;
	private Date blockTime;
}
