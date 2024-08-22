package com.kh.oneTrillionCompany.dao;

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
	
	//등록
	public void insert(RefundDto refundDto) {
		String sql = "insert into refund(refund_order_no , refund_memo , refund_data)"
				+ "values(? ,? ,?)";
		Object[] data = {refundDto.getRefundOrderNo() , refundDto.getRefundMemo() , 
								refundDto.getRefundDate()};
		jdbcTemplate.update(sql, data);
	}
}
