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
	
	//상품 추가
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
	
	//상품 상세
	public ItemDto selectOne(String itemNo) {
		String sql="select * from item where item_no=?";
		Object[] data= {itemNo};
		List<ItemDto> list =jdbcTemplate.query(sql, itemMapper,data);
		return list.isEmpty()?null:list.get(0);
	}
	
	//상품 검색
	public List<ItemDto> selectList(String column, String keyword){
		String sql="select * from item where instr("+ column +", ?)>0 "
				+ "order by "+ column +" asc, item_no desc";
		Object[] data= {keyword};
		return jdbcTemplate.query(sql, itemMapper, data);
	}
	
	//상품 카테고리 리스트
	public List<ItemDto> selectListByCate(String keyword){
		String sql = "select * from item where cate_no = ?";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, itemMapper, data);
	}
	
	//상품 조회
	public List<ItemDto> selectList(){
		String sql = "select * from item order by item_no asc";
		return jdbcTemplate.query(sql, itemMapper);
	}
	
	
	
	//상품 수정
	public boolean update(ItemDto itemDto) {
		String sql="update item set cate_no=?, item_name=?, item_price=?,"
				+ "item_sale_price=?, item_date=?, item_cnt=?, item_size=? "
				+ "where item_no=?";
		Object[] data= {itemDto.getCateNo(), itemDto.getItemName(), itemDto.getItemPrice(),
						itemDto.getItemSalePrice(), itemDto.getItemDate(), itemDto.getItemCnt(),
						itemDto.getItemSize(),itemDto.getCateNo()};
		return jdbcTemplate.update(sql, data)>0;
	}
	//상품삭제
	public boolean delete(int itemNo) {
		String sql="delete item where item_no=?";
		Object[] data= {itemNo};
		return jdbcTemplate.update(sql, data)>0;
	}
	
	//상품 이미지 조회
	public void connect(int itemNo, int attachNo) {
		String sql = "insert into image(item, attach) values(?, ?)";
		Object[] data = {itemNo, attachNo};
		jdbcTemplate.update(sql, data);
	}
	
	//상품 이미지 연결
	public int findImage(int itemNo) {
		String sql = "select attach from image where item=?";
		Object[] data = {itemNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
}
