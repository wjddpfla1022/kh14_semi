package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.OrdersDto;
import com.kh.oneTrillionCompany.mapper.OrdersMapper;


@Repository
public class OrdersDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private OrdersMapper ordersMapper;

	//주문 현황 목록(R)
	public List<OrdersDto> selectList() {
		String sql = "select * from orders order by orders_no=?";
		return jdbcTemplate.query(sql, ordersMapper);
	}
	//주문 현황 삭제(D)
	public boolean delete (int orderNo) {
		String sql = "delete orders where orders_no=?";
		Object[]data = {orderNo};
		return jdbcTemplate.update(sql, data)>0;
	}
	
	//특정 회원의 주문 목록 조회
	public List<OrdersDto> selectListByOrders(String orderMemberId){
		String sql = "select * from orders where order_member_id = ? order by order_no desc";
		Object[] data = {orderMemberId};
		return jdbcTemplate.query(sql, ordersMapper, data);
	}



}