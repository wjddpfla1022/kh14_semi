package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.ReviewDto;

@Service
public class ReviewMapper implements RowMapper<ReviewDto> {

	@Override
	public ReviewDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ReviewDto reviewDto = new ReviewDto();
		reviewDto.setReviewNo(rs.getInt("review_no"));
		reviewDto.setReviewItemNo(rs.getInt("review_item_no"));
		reviewDto.setReviewWriter(rs.getString("review_writer"));
		reviewDto.setReviewContent(rs.getString("review_content"));
		reviewDto.setReviewScore(rs.getInt("review_score"));
		
		return reviewDto;
	}

}
