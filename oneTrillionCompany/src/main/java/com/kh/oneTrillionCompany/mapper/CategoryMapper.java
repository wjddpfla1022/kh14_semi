package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.CategoryDto;

@Service
public class CategoryMapper implements RowMapper<CategoryDto> {

	@Override
	public CategoryDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		CategoryDto categoryDto = new CategoryDto();
		categoryDto.setCateNo(rs.getInt("cate_no"));
		categoryDto.setCateName(rs.getString("cate_name"));
		
		return categoryDto;
	}

}
