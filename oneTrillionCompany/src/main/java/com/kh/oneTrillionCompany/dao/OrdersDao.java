package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.OrdersDto;
import com.kh.oneTrillionCompany.mapper.OrdersMapper;
import com.kh.oneTrillionCompany.vo.CartVO;


@Repository
public class OrdersDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private OrdersMapper ordersMapper;
	
	@Autowired
	private CartDao cartDao;
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
		String sql = "select * from orders where order_buyer = ? order by order_no desc";
		Object[] data = {orderMemberId};
		return jdbcTemplate.query(sql, ordersMapper, data);
	}
	//장바구니 -> 주문으로 이동시 필요한 주문 테이블 생성
	public void insert(List<CartVO>list) {
		int payment=0;
		String buyer = list.get(0).getBuyer();
		for(int i=0; i<list.size(); i++) {
			int cnt=list.get(i).getCartItemCnt();
			int price=list.get(i).getCartItemPrice();
			payment+=cnt*price;
		}
		String sql= "insert into orders(order_no, order_price, order_buyer) "
				+ "values(order_seq.nextval,?,?)";
		Object[] data= {payment, buyer};
		jdbcTemplate.update(sql, data);
	}



}