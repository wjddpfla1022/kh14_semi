package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.ReplyDto;

@Service
public class ReplyMapper implements RowMapper<ReplyDto> {

	@Override
	public ReplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReplyDto replyDto = new ReplyDto();
		replyDto.setReplyNo(rs.getInt("reply_no"));
		replyDto.setReplyWriter(rs.getString("reply_writer"));
		replyDto.setReplyOrigin(rs.getInt("reply_origin"));
		replyDto.setReplyContent(rs.getString("reply_content"));
		replyDto.setReplyTime(rs.getDate("reply_time"));
		
		return replyDto;
	}

}
