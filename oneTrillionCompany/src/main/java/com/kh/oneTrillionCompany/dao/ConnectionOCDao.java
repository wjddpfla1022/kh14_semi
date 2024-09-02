package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.ConnectionOCDto;
import com.kh.oneTrillionCompany.mapper.ConnectionOCMapper;

@Repository
public class ConnectionOCDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ConnectionOCMapper connectionOCMapper;
	
	public boolean insert(ConnectionOCDto connectionOCDto) {
		String sql="insert into connection_order_cart("
				+ "cart_no, buyer,cnt_payment)"
				+ "values (?,?,?)";
		Object[] data= {connectionOCDto.getCartNo(),
				connectionOCDto.getBuyer(),
				connectionOCDto.getCntPayment()};
		return jdbcTemplate.update(sql, data)>0;
	}
	public boolean delete(int cartNo) {
		String sql="delete connection_order_cart where cart_no=?";
		Object[] data= {cartNo};
		return jdbcTemplate.update(sql,data)>0;
	}
	public List<ConnectionOCDto> selectListBySession(String buyer) {
		String sql="select * from connection_order_cart where buyer = ?";
		Object[] data= {buyer};
		List<ConnectionOCDto> list=jdbcTemplate.query(sql, connectionOCMapper,data);
		if(list.isEmpty()) return null;
		return list;
	}
	public boolean deleteAll(String memberId) {
		String sql="delete connection_order_cart where buyer=?";
		Object[] data= {memberId};
		return jdbcTemplate.update(sql, data)>0;
	}
}
