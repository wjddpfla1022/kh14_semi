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
	
	//주문서 한개 검색(주문번호로)
	public OrdersDto selectOne(int ordersNo) {
		String sql="select * from orders where order_no=?";
		Object[] data = {ordersNo};
		List<OrdersDto> list = jdbcTemplate.query(sql, ordersMapper, data);
		return list.isEmpty()?null:list.get(0);
	}
	//주문서 한개 검색(멤버 아이디로)
	public OrdersDto selectOne(String memberId) {
		String sql="select * from orders where order_buyer=? order by order_no asc";
		Object[] data = {memberId};
		List<OrdersDto> list = jdbcTemplate.query(sql, ordersMapper, data);
		return list.isEmpty()?null:list.get(list.size()-1);
	}
	//주문 현황 목록(R)
	public List<OrdersDto> selectList() {
		String sql = "select * from orders order by order_no asc";
		return jdbcTemplate.query(sql, ordersMapper);
	}
	//주문 현황 삭제(D)(주문번호로)
	public boolean delete (int ordersNo) {
		String sql = "delete orders where order_no=?";
		Object[]data = {ordersNo};
		return jdbcTemplate.update(sql, data)>0;
	}
	//주문 현황 삭제(아이디로)
	public boolean delete (String memberId) {
		String sql = "delete orders where order_buyer =?";
		Object[] data= {memberId};
		return jdbcTemplate.update(sql, data)>0;
	}
	
	//특정 회원의 주문 목록 조회
	public List<OrdersDto> selectListByOrder(String orderMemberId){
		String sql = "select * from orders where order_buyer = ? order by order_no desc";
		Object[] data = {orderMemberId};
		return jdbcTemplate.query(sql, ordersMapper, data);
	}
	//장바구니 -> 주문으로 이동시 필요한 주문 테이블 생성
	public void insertIntoOrdersTable(List<CartVO>list,int orderNo) {
		long payment=0L;
		String buyer = list.get(0).getBuyer();
		for(int i=0; i<list.size(); i++) {
			int cnt=list.get(i).getCartItemCnt();
			int price=list.get(i).getCartItemPrice();
			if(cnt==0) continue;
			payment+=(long)(cnt*price);
		}
		if(payment==0L) return ;
		String sql= "insert into orders(order_no, order_price, order_buyer) "
				+ "values(?,?,?)";
		Object[] data= {orderNo,payment, buyer};
		jdbcTemplate.update(sql, data);
	}
	public int sequence() {
		String sql="select order_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}



}