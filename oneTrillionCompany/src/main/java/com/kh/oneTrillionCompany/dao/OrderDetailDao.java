package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.OrderDetailDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;
import com.kh.oneTrillionCompany.mapper.OrderDetailMapper;
import com.kh.oneTrillionCompany.vo.CartVO;

@Repository
public class OrderDetailDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private OrderDetailMapper orderDetailMapper;
	
		//특정 회원의 주문 목록 조회(아이디, 주문번호로 조회)
		public List<OrderDetailDto> selectListByOrderDetail(String memberId,int orderNo){
			String sql = "select * from order_detail where order_detail_buyer = ? and order_detail_order_no =? order by order_detail_no desc";
			Object[] data = {memberId,orderNo};
			return jdbcTemplate.query(sql, orderDetailMapper, data);
		}
		//특정 회원의 주문 목록 조회(아이디로 조회)
		public List<OrderDetailDto> selectListByOrderDetail(String memberId){
			String sql = "select * from order_detail where order_detail_buyer = ? order by order_detail_no desc";
			Object[] data = {memberId};
			return jdbcTemplate.query(sql, orderDetailMapper, data);
		}
		//특정 회원의 주문 결제준비상태 목록 조회(아이디로 조회)
		public List<OrderDetailDto> selectListByOrderDetailReady(String orderMemberId){
			String sql = "select * from order_detail where order_detail_buyer = ? where order_detail_status = '결제준비' order by order_detail_no desc";
			Object[] data = {orderMemberId};
			return jdbcTemplate.query(sql, orderDetailMapper, data);
		}
		//특정 회원의 주문 결제완료상태 목록 조회(아이디로조회)
		public List<OrderDetailDto> selectListByOrderDetailComplete(String orderMemberId){
			String sql = "select * from order_detail where order_detail_buyer = ? and order_detail_status ='결제완료' order by order_detail_no desc";
			Object[] data = {orderMemberId};
			return jdbcTemplate.query(sql, orderDetailMapper, data);
		}

		public void insertByCartVOList(List<CartVO> list,int orderNo) {
			for(int i=0; i<list.size(); i++) {
			CartVO cartVO=list.get(i);
			System.out.println(cartVO);
			String sql="insert into order_detail("
					+ "order_detail_no,order_detail_order_no,order_detail_item_no,"
					+ "order_detail_price, order_detail_cnt, "
					+ "order_detail_buyer, order_detail_item_name,order_detail_status"
					+ ") values("
					+ "order_detail_seq.nextval,?,?,?,?,?,?,'결제준비')";
			Object[] data= {orderNo,cartVO.getCartItemNo(),cartVO.getCartItemPrice(),
					cartVO.getCartItemCnt(),cartVO.getBuyer(),cartVO.getCartItemName()};
			jdbcTemplate.update(sql, data);
			}
		}
		public void checkStatus(List<Integer> list) {//중복 결제를 막는 메서드(상태체크로)
			for(int i=0; i<list.size(); i++) { 
				String sql="select order_detail_status from order_detail where order_detail_no = ?";
				Object[] data= {list.get(i)};
				String status=jdbcTemplate.query(sql, orderDetailMapper, data).get(0).getOrderDetailStatus();
				if(!(status).equals("결제준비")) 
					throw new TargetNotFoundException("이미 결제된 상품입니다");
			}
		}
		public void payCompleteStatus(List<Integer>list) {//결제 완료시 결제상세의 상태변경("결제완료"로)
			for(int i=0; i<list.size(); i++) {
				int detailNo=list.get(i);
				String sql="update order_detail set "
						+ "order_detail_status='결제완료' "
						+ "where order_detail_no=?";
				Object[] data= {detailNo};
				jdbcTemplate.update(sql, data);
			}
		}
		public OrderDetailDto selectOne(int orderDetailNo) {
			String sql = "select * from order_detail where order_detail_no = ?";
			Object[] data= {orderDetailNo};
			List<OrderDetailDto> list = jdbcTemplate.query(sql, orderDetailMapper, data);
			return list.isEmpty() ? null : list.get(0);
		}
		public void update(OrderDetailDto orderDetailDto) {
			String sql = "update order_detail set order_detail_status = ? where order_detail_no = ?";
			Object[] data= {orderDetailDto.getOrderDetailStatus(), orderDetailDto.getOrderDetailNo()};
			jdbcTemplate.update(sql, data);
		}		
		//특정 회원의 주문 환불완료상태 목록 조회(아이디로조회)
		public List<OrderDetailDto> selectListByOrderDetailRefund(String orderMemberId){
			String sql = "select * from order_detail where order_detail_buyer = ? and order_detail_status ='환불완료' order by order_detail_no desc";
			Object[] data = {orderMemberId};
			return jdbcTemplate.query(sql, orderDetailMapper, data);
		}
}
