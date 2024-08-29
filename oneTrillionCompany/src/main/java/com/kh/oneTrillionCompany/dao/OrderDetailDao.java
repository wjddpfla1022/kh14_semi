package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.OrderDetailDto;
import com.kh.oneTrillionCompany.mapper.OrderDetailMapper;
import com.kh.oneTrillionCompany.vo.CartVO;

@Repository
public class OrderDetailDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private OrderDetailMapper orderDetailMapper;
	
	//특정 회원의 주문 목록 조회
		public List<OrderDetailDto> selectListByOrderDetail(String memberId,int orderNo){
			String sql = "select * from order_detail where order_detail_buyer = ? and order_detail_order_no =? order by order_detail_no desc";
			Object[] data = {memberId,orderNo};
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
			String sql = "select * from order_detail where order_detail_buyer = ? where order_detail_status ='결제완료' order by order_detail_no desc";
			Object[] data = {orderMemberId};
			return jdbcTemplate.query(sql, orderDetailMapper, data);
		}

		public void insertByCartVOList(List<CartVO> list,int orderNo) {
			for(int i=0; i<list.size(); i++) {
			CartVO cartVO=list.get(i);
			String sql="insert into order_detail("
					+ "order_detail_no,order_detail_order_no,order_detail_item_no,"
					+ "order_detail_price, order_detail_cnt, order_detail_status,"
					+ "order_detail_buyer,order_detail_status"
					+ ") values("
					+ "order_detail_seq.nextval,?,?,?,?,?,'결제준비')";
			Object[] data= {orderNo,cartVO.getCartItemNo(),cartVO.getCartItemPrice(),
					cartVO.getCartItemCnt(),cartVO.getBuyer()};
			jdbcTemplate.update(sql, data);
			}
		}
		public void payCompleteStatus(List<Integer>list) {
			for(int i=0; i<list.size(); i++) {
				int detailNo=list.get(i);
				String sql="update order_detail set "
						+ "order_detail_status='결제완료' "
						+ "where order_detail_no=?";
				Object[] data= {detailNo};
				jdbcTemplate.update(sql, data);
			}
		}

}
