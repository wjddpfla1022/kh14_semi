package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.MemberDto;

@Service
public class MemberMapper implements RowMapper<MemberDto> {


@Override
public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	MemberDto memberDto = new MemberDto();
	memberDto.setMemberId(rs.getString("member_id"));
	memberDto.setMemberPw(rs.getString("member_pw"));
	memberDto.setMemberName(rs.getString("member_name"));
	memberDto.setMemberNickname(rs.getString("member_nickname"));
	memberDto.setMemberEmail(rs.getString("member_email"));
	memberDto.setMemberRank(rs.getString("member_rank"));
	memberDto.setMemberPoint(rs.getInt("member_point"));
	memberDto.setMemberJoin(rs.getDate("member_join"));
	memberDto.setMemberLogin(rs.getDate("member_login"));
	memberDto.setMemberPost(rs.getString("member_post"));
	memberDto.setMemberAddress1(rs.getString("member_address1"));
	memberDto.setMemberAddress2(rs.getString("member_address2"));
	memberDto.setMemberHeight(rs.getInt("member_height"));
	memberDto.setMemberWeight(rs.getInt("member_weight"));
	memberDto.setMemberContact(rs.getString("member_contact"));
	
	return memberDto;
}
}
