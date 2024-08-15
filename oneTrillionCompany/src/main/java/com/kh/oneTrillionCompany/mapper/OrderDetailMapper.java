package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.OrderDetailDto;

@Service
public class OrderDetailMapper implements RowMapper<OrderDetailDto> {

	@Override
	public OrderDetailDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		OrderDetailDto orderDetailDto = new OrderDetailDto();
		orderDetailDto.setOrderDetailNo(rs.getInt("order_detail_no"));
		orderDetailDto.setOrderDetailItemNo(rs.getInt("order_detail_item_no"));
		orderDetailDto.setOrderDetailOrderNo(rs.getInt("order_detail_order_no"));
		orderDetailDto.setOrderDetailPrice(rs.getInt("order_detail_price"));
		orderDetailDto.setOrderDetailCnt(rs.getInt("order_detail_cnt"));
		
		return orderDetailDto;
	}

}
