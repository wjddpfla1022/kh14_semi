package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.ItemDto;
import com.kh.oneTrillionCompany.mapper.ItemMapper;

@Repository
public class ItemDao {
	
	@Autowired
	private ItemMapper itemMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	//기본 CRUD
	public void insert(ItemDto itemDto) {
		String sql="insert into item( "
				+ "item_no, cate_no, item_name,"
				+ "item_price, item_sale_price, item_date,"
				+ "item_cnt, item_size"
				+ ") values(item_seq.nextval, ?,?,?,?,?,?,?)";
		Object[] data= {itemDto.getCateNo(),itemDto.getItemName(),
						itemDto.getItemPrice(),itemDto.getItemSalePrice(),
						itemDto.getItemDate(),itemDto.getItemCnt(),
						itemDto.getItemSize()};
		jdbcTemplate.update(sql, data);
		
	}
	public ItemDto selectOne(int itemNo) {
		String sql="select * from item where item_no=?";
		Object[] data= {itemNo};
		List<ItemDto> list =jdbcTemplate.query(sql, itemMapper,data);
		return list.isEmpty()?null:list.get(0);
	}
	public List<ItemDto> selectList(String column, String keyword){
		String sql="select * from item where instr(#!,?)>0 "
				+ "order by item_no desc";
		sql = sql.replace("#!", column);
		Object[] data= {keyword};
		return jdbcTemplate.query(sql, itemMapper, data);
	}
	public boolean update(ItemDto itemDto) {
		String sql="update item set cate_no=?, item_name=?, item_price=?,"
				+ "item_sale_price=?, item_date=?, item_cnt=?, item_size=? "
				+ "where item_no=?";
		Object[] data= {itemDto.getCateNo(), itemDto.getItemName(), itemDto.getItemPrice(),
						itemDto.getItemSalePrice(), itemDto.getItemDate(), itemDto.getItemCnt(),
						itemDto.getItemSize(),itemDto.getCateNo()};
		return jdbcTemplate.update(sql, data)>0;
	}
	public boolean delete(int itemNo) {
		String sql="delete item where item_no=?";
		Object[] data= {itemNo};
		return jdbcTemplate.update(sql, data)>0;
	}
}
