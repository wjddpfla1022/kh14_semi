package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.ItemInfoDto;

@Service
public class ItemInfoMapper implements RowMapper<ItemInfoDto> {

	@Override
	public ItemInfoDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		ItemInfoDto infoDto = new ItemInfoDto();
		
		infoDto.setInfoNo(rs.getInt("info_no"));
		infoDto.setInfoItemNo(rs.getInt("info_item_no"));
		infoDto.setInfoContent(rs.getString("info_content"));
		
		return infoDto;
	}

}
