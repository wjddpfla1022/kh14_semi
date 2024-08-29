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
		String sql = "insert into refund(refund_order_no , refund_memo , refund_date)"
				+ "values(? ,? ,sysdate)";
		Object[] data = {refundDto.getRefundOrderNo() , refundDto.getRefundMemo()};
		jdbcTemplate.update(sql, data);
	}
	
//	//환불 목록
//	public List<RefundDto> selectList(){
//		String sql = "select * from refund order by refund_order_no asc";
//		return jdbcTemplate.query(sql, refundMapper);
//	}
}
