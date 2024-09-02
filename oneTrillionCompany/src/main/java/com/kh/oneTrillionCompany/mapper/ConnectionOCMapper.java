package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.ConnectionOCDto;

@Service
public class ConnectionOCMapper implements RowMapper<ConnectionOCDto>{

	@Override
	public ConnectionOCDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ConnectionOCDto connectionOCDto = new ConnectionOCDto();
		connectionOCDto.setCartNo(rs.getInt("cart_no"));
		connectionOCDto.setBuyer(rs.getString("buyer"));
		connectionOCDto.setCntPayment(rs.getInt("cnt_payment"));
		return connectionOCDto;
	}
	
}
