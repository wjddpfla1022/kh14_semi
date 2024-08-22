package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.vo.MemberBlockVO;

@Service
public class MemberBlockMapper implements RowMapper<MemberBlockVO>{

	@Override
	public MemberBlockVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberBlockVO memberBlockVO = new MemberBlockVO();
		memberBlockVO.setMemberId(rs.getString("member_id"));
		memberBlockVO.setMemberPw(rs.getString("member_pw"));
		memberBlockVO.setMemberName(rs.getString("member_name"));
		memberBlockVO.setMemberNickname(rs.getString("member_nickname"));
		memberBlockVO.setMemberEmail(rs.getString("member_email"));
		memberBlockVO.setMemberBlock(rs.getString("member_block"));
		memberBlockVO.setMemberRank(rs.getString("member_rank"));
		memberBlockVO.setMemberPoint(rs.getInt("member_point"));
		memberBlockVO.setMemberJoin(rs.getDate("member_join"));
		memberBlockVO.setMemberLogin(rs.getDate("member_login"));
		memberBlockVO.setMemberPost(rs.getString("member_post"));
		memberBlockVO.setMemberAddress1(rs.getString("member_address1"));
		memberBlockVO.setMemberAddress2(rs.getString("member_address2"));
		memberBlockVO.setMemberHeight(rs.getInt("member_height"));
		memberBlockVO.setMemberWeight(rs.getInt("member_weight"));
		
		memberBlockVO.setBlockNo(rs.getInt("block_no"));
		memberBlockVO.setBlockMemberId(rs.getString("block_member_id"));
		memberBlockVO.setBlockType(rs.getString("block_type"));
		memberBlockVO.setBlockMemo(rs.getString("block_memo"));
		memberBlockVO.setBlockTime(rs.getDate("block_time"));
		
		return memberBlockVO;
	}

}
