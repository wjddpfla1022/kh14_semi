package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.RefundDto;
import com.kh.oneTrillionCompany.mapper.RefundMapper;


@Repository
public class RefundDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private RefundMapper refundMapper;
	
	//환불 등록(신청)
	public void insert(RefundDto refundDto) {
		String sql = "insert into refund(refund_order_detail_no , refund_memo , refund_date, refund_type)"
				+ "values(? ,? ,sysdate, ?)";
		Object[] data = {refundDto.getRefundOrderDetailNo() , refundDto.getRefundMemo(), refundDto.getRefundType()};
		jdbcTemplate.update(sql, data);
	}

	public RefundDto selectOne(int refundOrderDetailNo) {
		String sql = "select * from refund where refund_order_detail_no = ?";
		Object[] data = {refundOrderDetailNo};
		List<RefundDto> list = jdbcTemplate.query(sql, refundMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
//	//환불 목록
//	public List<RefundDto> selectList(){
//		String sql = "select * from refund order by refund_order_no asc";
//		return jdbcTemplate.query(sql, refundMapper);
//	}
}
