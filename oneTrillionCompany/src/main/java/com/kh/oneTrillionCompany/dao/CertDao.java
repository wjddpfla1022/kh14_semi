package com.kh.oneTrillionCompany.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.CertDto;
import com.kh.oneTrillionCompany.mapper.CertMapper;

@Repository
public class CertDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private CertMapper certMapper;
	
	public void insert(CertDto certDto) {
		String sql="insert into cert(cert_email, cert_number) "
				+ "values(?, ?)";
		Object[] data = {certDto.getCertEmail(), certDto.getCertNumber()};
		jdbcTemplate.update(sql, data);
	}
	public boolean delete(String certEmail) {
		String sql="delete cert where cert_email =?";
		Object[] data= {certEmail};
		return jdbcTemplate.update(sql, data)>0;
	}
	//db 이메일인증번호 테이블의 시간, 인증번호 검사 
	public boolean check(CertDto certDto, int duration) {
		String sql="select * from cert "
				+ "where cert_email=? and cert_number=? "
				+ "and cert_time between sysdate-?/60/24 and sysdate";
		Object[] data= {certDto.getCertEmail(),certDto.getCertNumber(), duration};
		return jdbcTemplate.query(sql, certMapper, data)!=null;
	}
}
