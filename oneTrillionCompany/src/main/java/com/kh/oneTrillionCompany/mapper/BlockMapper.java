package com.kh.oneTrillionCompany.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.oneTrillionCompany.dto.BlockDto;

@Service
public class BlockMapper implements RowMapper<BlockDto> {

	@Override
	public BlockDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		BlockDto blockDto = new BlockDto();
		blockDto.setBlockNo(rs.getInt("block_no"));
		blockDto.setBlockMemberId(rs.getString("block_member_id"));
		blockDto.setBlockType(rs.getString("block_type"));
		blockDto.setBlockMemo(rs.getString("block_memo"));
		blockDto.setBlockTime(rs.getDate("block_time"));
		
		return blockDto;
	}

}
