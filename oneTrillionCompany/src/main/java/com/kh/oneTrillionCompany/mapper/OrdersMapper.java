package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.OrdersDto;

@Service
public class OrdersMapper implements RowMapper<OrdersDto> {

	@Override
	public OrdersDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		OrdersDto ordersDto = new OrdersDto();
		ordersDto.setOrderNo(rs.getInt("order_no"));
		ordersDto.setOrderCartNo(rs.getInt("order_cart_no"));
		ordersDto.setOrderPrice(rs.getInt("order_price"));
		ordersDto.setOrderDate(rs.getDate("order_date"));
		ordersDto.setOrderStatus(rs.getString("order_status"));
		ordersDto.setOrderBuyer(rs.getString("order_buyer"));
		
		return ordersDto;
	}
	
}
