package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.ItemDto;

@Service
public class ItemMapper implements RowMapper<ItemDto> {

	@Override
	public ItemDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ItemDto itemDto = new ItemDto();
		itemDto.setItemNo(rs.getInt("item_no"));
		itemDto.setItemName(rs.getString("item_name"));
		itemDto.setItemPrice(rs.getInt("item_price"));
		itemDto.setItemSalePrice(rs.getInt("item_sale_price"));
		itemDto.setItemDate(rs.getDate("item_date"));
		itemDto.setItemCnt(rs.getInt("item_cnt"));
		itemDto.setItemSize(rs.getString("item_size"));
		itemDto.setItemCate1(rs.getString("item_cate1"));
		itemDto.setItemCate2(rs.getString("item_cate2"));
		itemDto.setItemCate3(rs.getString("item_cate3"));
		itemDto.setItemDiscountRate(rs.getString("item_discount_rate"));
		return itemDto;
	}
	
}
