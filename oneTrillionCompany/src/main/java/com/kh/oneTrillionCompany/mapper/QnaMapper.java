package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.QnaDto;

@Service
public class QnaMapper implements RowMapper<QnaDto> {

	@Override
	public QnaDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		QnaDto qnaDto = new QnaDto();
		qnaDto.setQnaNo(rs.getInt("qna_no"));
		qnaDto.setQnaWriter(rs.getString("qna_writer"));
		qnaDto.setQnaTitle(rs.getString("qna_title"));
		qnaDto.setQnaContent(rs.getString("qna_content"));
		qnaDto.setQnaTime(rs.getDate("qna_time"));
		qnaDto.setQnaReply(rs.getString("qna_reply"));
		qnaDto.setQnaView(rs.getInt("qna_view"));
		
		return qnaDto;
	}

}
