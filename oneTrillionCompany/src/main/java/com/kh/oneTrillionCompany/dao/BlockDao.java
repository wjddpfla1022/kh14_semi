package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.BlockDto;
import com.kh.oneTrillionCompany.mapper.BlockMapper;

@Repository
public class BlockDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private BlockMapper blockMapper;
	
	//차단 등록
	public void insertBlock(BlockDto blockDto) {
		String sql = "insert into block"
					+ "(block_no, block_member_id, block_type, block_memo, block_time) "
						+ "values(block_seq.nextval, ?, '차단', ?, sysdate)";
		Object[] data = {
				blockDto.getBlockMemberId(), blockDto.getBlockMemo()};
		jdbcTemplate.update(sql, data);
	}
	
	//해제 등록
		public void insertClear(BlockDto blockDto) {
			String sql = "insert into block"
						+ "(block_no, block_member_id,block_type, block_memo, block_time) "
							+ "values(block_seq.nextval, ?, '해제', ?, sysdate)";
			Object[] data = {
					blockDto.getBlockMemberId(), blockDto.getBlockMemo()};
			jdbcTemplate.update(sql, data);
		}
		
		//마지막 상태 확인
		public BlockDto selectLastOne(String blockMemberId) {
			String sql = "select * from block where block_no = ("
								+ "select max(block_no) from block where block_member_id = ?)";
			Object[] data = {blockMemberId};
			List<BlockDto> list = jdbcTemplate.query(sql, blockMapper, data);
			return list.isEmpty() ? null : list.get(0);
		}
		
		//차단 내역 확인(아이디로 조회)
		public List<BlockDto> selectBlockHistory(String blockMemberId) {
			String sql = "select * from block where block_member_id = ? "
							+ "order by block_no desc";
			Object[] data = {blockMemberId};
			return jdbcTemplate.query(sql, blockMapper, data);
		}		
		
		//차단 내역 조회
		public List<BlockDto> selectList(){
			String sql = "select * from block order by block_no asc";
			return jdbcTemplate.query(sql, blockMapper);
		}
		
		//차단 내역 검색
		public List<BlockDto> selectList(String column, String keyword){
			String sql = "select * from block where instr("+column+", ?) > 0 order by block_no asc";
			Object[] data= {keyword};
			return jdbcTemplate.query(sql, blockMapper, data);
		}
				
}
