package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dto.ItemDto;
import com.kh.oneTrillionCompany.mapper.ItemMapper;
import com.kh.oneTrillionCompany.vo.PageVO;

@Repository
public class ItemDao {
	
	@Autowired
	private ItemMapper itemMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	//기본 CRUD
	
	//시퀀스
	public int sequence() {
		String sql = "select item_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//상품 추가
	public void insert(ItemDto itemDto) {
		String sql="insert into item( "
				+ "item_no, item_name, "
				+ "item_price, item_sale_price, item_date,"
				+ "item_cnt, item_size, item_cate1, item_cate2, item_cate3, item_discount_rate, item_color"
				+ ") values(?, ?, ?, ?, sysdate, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data= {itemDto.getItemNo(),
						itemDto.getItemName(), itemDto.getItemPrice(), 
						itemDto.getItemSalePrice(), 
						itemDto.getItemCnt(), itemDto.getItemSize(), 
						itemDto.getItemCate1(), itemDto.getItemCate2(), 
						itemDto.getItemCate3(), itemDto.getItemDiscountRate(), itemDto.getItemColor()
						};
		jdbcTemplate.update(sql, data);
	}
	
	//상품 상세
	public ItemDto selectOne(int itemNo) {
		String sql="select * from item where item_no=?";
		Object[] data= {itemNo};
		List<ItemDto> list =jdbcTemplate.query(sql, itemMapper,data);
		return list.isEmpty()?null:list.get(0);
	}
	
	//상품 검색
	public List<ItemDto> selectList(String column, String keyword){
		String sql="select * from item where instr("+ column +", ?)>0 "
				+ "order by item_no asc";
		Object[] data= {keyword};
		return jdbcTemplate.query(sql, itemMapper, data);
	}
	
	//상품 카테고리별 리스트 조회
	public List<ItemDto> selectListByCate(String column, String keyword){
		String sql = "select * from item where item_cate"+ column +"  = ?"; //column은 1, 2, 3으로만 지정
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
		String sql="update item set item_name=?, item_price=?,"
				+ "item_sale_price=?, item_cnt=?, item_size=?, item_cate1=?,"
				+ "item_cate2=?, item_cate3=?, item_discount_rate=?, item_color=? "
				+ "where item_no=?";
		Object[] data= {itemDto.getItemName(), itemDto.getItemPrice(),
						itemDto.getItemSalePrice(), itemDto.getItemCnt(),
						itemDto.getItemSize(), itemDto.getItemCate1(), itemDto.getItemCate2(),
						itemDto.getItemCate3(), itemDto.getItemDiscountRate(), itemDto.getItemColor(), itemDto.getItemNo()};
		return jdbcTemplate.update(sql, data)>0;
	}
	//상품삭제
	public boolean delete(int itemNo) {
		String sql="delete item where item_no=?";
		Object[] data= {itemNo};
		return jdbcTemplate.update(sql, data)>0;
	}
	
	
	
	//상품 이미지 연결
	public void connect(int itemNo, int attachNo) {
		String sql = "insert into image(item_no, attach_no) values(?, ?)";
		Object[] data = {itemNo, attachNo};
		jdbcTemplate.update(sql, data);
	}
	
	//상품 이미지 조회
	public int findImage(int itemNo) {
		String sql = "select attach_no from image where item_no=?";
		Object[] data = {itemNo};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	//결제 후 상품 재고 차감
	public boolean deductItem(int cnt,int itemNo) {
		String sql="update item set item_cnt = item_cnt-? "
				+ "where item_no = ? and item_cnt >= ?";
		Object[] data= {cnt,itemNo, cnt};
		return jdbcTemplate.update(sql, data)>0;
	}
	
	//페이징
	public List<ItemDto> selectListByPaging(PageVO pageVO) {
	    if(pageVO.isSearch() == true) {//검색이라면
	        String sql = "select * from ("
	                            + "select rownum as rn, TMP.* from ("
	                                + "select "
	                                    + "item_no, item_name, item_price, item_sale_price, "
	                                    + "item_date, item_cnt, item_size, "
	                                    + "item_cate1, item_cate2, item_cate3, "
	                                    + "item_discount_rate, item_color "        
	                                + "from item "
	                                + "where instr(" + pageVO.getColumn() + ", ?) > 0 "
	                                + "order by item_no asc"
	                            + ")TMP"
	                    + ") where rn between ? and ?";
	        Object[] data = {
	                pageVO.getKeyword(), 
	                pageVO.getBeginRow(), 
	                pageVO.getEndRow() 
	                };
	                return jdbcTemplate.query(sql, itemMapper, data);
	        }
	    
	    else{//목록이라면
	    	String sql = "SELECT * FROM ("
	                + "    SELECT ROWNUM AS rn, TMP.* FROM ("
	                + "        SELECT "
	                + "            item_no, item_name, item_price, item_sale_price, "
	                + "            item_date, item_cnt, item_size, "
	                + "            item_cate1, item_cate2, item_cate3, "
	                + "            item_discount_rate, item_color "
	                + "        FROM item "
	                + "        ORDER BY item_no ASC"
	                + "    ) TMP"
	                + ") WHERE rn BETWEEN ? AND ?";
	        Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
	        return jdbcTemplate.query(sql, itemMapper, data);
	    }
	}
	
	public int countByPaging(PageVO pageVO) {
	    String sql;
	    if (pageVO.isSearch()) {
	        sql = "select count(*) from item where instr(" + pageVO.getColumn() + ", ?) > 0";
	        return jdbcTemplate.queryForObject(sql, Integer.class, pageVO.getKeyword());
	    } else {
	        sql = "select count(*) from item";
	        return jdbcTemplate.queryForObject(sql, Integer.class);
	    }
	}

	
}
