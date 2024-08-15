package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.CartDto;

@Service
public class CartMapper implements RowMapper<CartDto> {

	@Override
	public CartDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		CartDto cartDto = new CartDto();
		cartDto.setCartNo(rs.getInt("cart_no"));
		cartDto.setCartItemNo(rs.getInt("cart_item_no"));
		cartDto.setCartCnt(rs.getInt("cart_cnt"));
		cartDto.setItemAttachNo(rs.getInt("item_attach_no"));
		cartDto.setCartTotalPrice(rs.getInt("cart_total_price"));
		
		return cartDto;
	}
	
}
