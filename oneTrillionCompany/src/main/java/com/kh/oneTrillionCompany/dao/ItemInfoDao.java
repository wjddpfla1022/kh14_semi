package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.ItemInfoDto;
import com.kh.oneTrillionCompany.mapper.ItemInfoMapper;

@Repository
public class ItemInfoDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ItemInfoMapper infoMapper;
	
	
	//시퀀스 생성
	public int sequence() {
		String sql = "select info_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//글 등록
	public void write(ItemInfoDto infoDto) {
		String sql = "insert into item_info (info_no, info_item_no, info_content"
									+ ") "
								+ "values(?, ?, ?)";
		Object[] data = {
				infoDto.getInfoNo(), infoDto.getInfoItemNo(), infoDto.getInfoContent()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//글 수정
	public boolean update(ItemInfoDto infoDto) {
		String sql = "update item_info set "
				+ "info_content = ? "
				+ "where info_item_no = ?";
		Object[] data = {
				infoDto.getInfoContent(), infoDto.getInfoItemNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//글 검색
	public List<ItemInfoDto> selectList(int keyword){
		String sql = "select info_content "
				+ "from item_info "
				+ "where instr(info_item_no, ?) > 0 "
				+ "order by info_no desc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, infoMapper, data);
	}
	
	//상세
	public ItemInfoDto selectOne(int itemNo) {
		String sql = "select * from item_info where info_item_no = ?";
		Object[] data = {itemNo};
		List<ItemInfoDto> list = jdbcTemplate.query(sql, infoMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
