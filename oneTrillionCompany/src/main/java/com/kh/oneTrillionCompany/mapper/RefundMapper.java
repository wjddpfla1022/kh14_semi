package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.RefundDto;

@Service
public class RefundMapper implements RowMapper<RefundDto> {

	@Override
	public RefundDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		RefundDto refundDto = new RefundDto();
		refundDto.setRefundOrderDetailNo(rs.getInt("refund_order_detail_no"));
		refundDto.setRefundMemo(rs.getString("refund_memo"));
		refundDto.setRefundDate(rs.getDate("refund_Date"));
		
		return refundDto;
	}
	
}
