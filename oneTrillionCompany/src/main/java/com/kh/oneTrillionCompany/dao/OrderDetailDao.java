package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.OrderDetailDto;
import com.kh.oneTrillionCompany.mapper.OrderDetailMapper;

@Repository
public class OrderDetailDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private OrderDetailMapper orderDetailMapper;
	
	//특정 회원의 주문 목록 조회
		public List<OrderDetailDto> selectListByOrderDetail(String orderMemberId){
			String sql = "select * from order_detail where order_detail_buyer = ? order by order_detail_no desc";
			Object[] data = {orderMemberId};
			return jdbcTemplate.query(sql, orderDetailMapper, data);
		}

}
