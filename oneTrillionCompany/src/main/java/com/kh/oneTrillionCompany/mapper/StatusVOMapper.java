package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.vo.StatusVO;

@Service
public class StatusVOMapper implements RowMapper<StatusVO>{

	@Override
	public StatusVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		StatusVO statusVO=new StatusVO();
		statusVO.setCnt(rs.getInt("cnt"));
		statusVO.setTitle(rs.getString("title"));
		return statusVO;
	}
	
}
