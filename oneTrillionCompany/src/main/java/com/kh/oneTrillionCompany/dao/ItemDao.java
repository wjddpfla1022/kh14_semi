package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.ItemDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;
import com.kh.oneTrillionCompany.mapper.ItemMapper;
import com.kh.oneTrillionCompany.vo.ItemPageVO;
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
						itemDto.getItemCate3(), 0, itemDto.getItemColor()
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
	
//	//상품 카테고리별 리스트 조회
//	public List<ItemDto> selectListByCate(String column, String keyword){
//		String sql = "select * from item where item_cate"+ column +"  = ?"; //column은 1, 2, 3으로만 지정
//		Object[] data = {keyword};
//		return jdbcTemplate.query(sql, itemMapper, data);
//	}
	
	//상품 카테고리별 리스트 조회
		public List<ItemDto> selectListByCatePaging(ItemPageVO pageVO){
			
			String column = "item_cate" + pageVO.getColumn();
			String sql = "select * from ("
		               + "select rownum as rn, TMP.* from ("
		               + "select * from item where instr(" + column + ", ?) > 0 "
		               + "order by item_no asc"
		               + ") TMP "
		               + ") where rn between ? and ?";
			
			Object[] data = {pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow()};
			
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
				+ "item_sale_price=?, item_cnt=?"
				+ "where item_no=?";
		Object[] data= {itemDto.getItemName(), itemDto.getItemPrice(),
						itemDto.getItemSalePrice(), itemDto.getItemCnt(),
						 itemDto.getItemNo()};
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
		boolean isEnough=jdbcTemplate.update(sql, data)>0;
		if(!isEnough) {
			System.out.println("재고부족!");
			throw new TargetNotFoundException("재고가 부족합니다");
		}
		return isEnough;
	}
	//페이징 (관리자 전용)
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
	
	//페이징 (회원 전용)
	public List<ItemDto> selectListByPaging(ItemPageVO pageVO) {
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
	//페이징 (회원 전용) //판매량순(sales) 가격비싼순(priceDesc) 가격싼순(priceAsc) 최신등록순(latest)
		public List<ItemDto> selectListByPaging(ItemPageVO pageVO,String sorting) {
			if(sorting.equals("sales")) {//판매량순
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
			                                + "order by item_discount_rate desc"
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
			                + "        ORDER BY item_discount_rate desc"
			                + "    ) TMP"
			                + ") WHERE rn BETWEEN ? AND ?";
			        Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			        return jdbcTemplate.query(sql, itemMapper, data);
			    }
			}
			else if(sorting.equals("priceAsc")) {//가격 싼 순서대로
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
			                                + "order by item_price asc"
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
			                + "        ORDER BY item_price ASC"
			                + "    ) TMP"
			                + ") WHERE rn BETWEEN ? AND ?";
			        Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			        return jdbcTemplate.query(sql, itemMapper, data);
			    }
			}
			else if(sorting.equals("priceDesc")) {//가격 비싼 순서대로
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
			                                + "order by item_price desc"
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
			                + "        ORDER BY item_price desc"
			                + "    ) TMP"
			                + ") WHERE rn BETWEEN ? AND ?";
			        Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			        return jdbcTemplate.query(sql, itemMapper, data);
			    }
			}
			else {//최신등록순
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
		}
	
	public int countByPaging(ItemPageVO pageVO) {
	    String sql;
	    if (pageVO.isSearch()) {
	        sql = "select count(*) from item where instr(" + pageVO.getColumn() + ", ?) > 0";
	        return jdbcTemplate.queryForObject(sql, Integer.class, pageVO.getKeyword());
	    } else {
	        sql = "select count(*) from item";
	        return jdbcTemplate.queryForObject(sql, Integer.class);
	    }
	}
	public int countByPagingCate(ItemPageVO itemPageVO) {
	    String sql;
	    if (itemPageVO.isSearch()) {
	        sql = "select count(*) from item where instr(item_cate" + itemPageVO.getColumn() + ", ?) > 0";
	        return jdbcTemplate.queryForObject(sql, Integer.class, itemPageVO.getKeyword());
	    } else {
	        sql = "select count(*) from item";
	        return jdbcTemplate.queryForObject(sql, Integer.class);
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
	
	//itemNo로 이름을 찾는다-장바구니
	public String findItemName (int itemNo) {
		String sql= "select item_name from item where item_no=?";
		return jdbcTemplate.queryForObject(sql, String.class, itemNo);
	}
	//품절 유무를 위해 아이템 컬러를 뽑는다-장바구니
	public List<String> selectItemColors(int itemNo) {
		String itemName = findItemName(itemNo);
		String sql = "select item_color from item where item_name=?";
		Object[] data = {itemName};
		return jdbcTemplate.queryForList(sql, String.class, data);
	}
	
//	//아이템 수량을 이름과 색깔로 뽑아내기
//	public int selectItemCntByNameColor(int itemNo, String itemColor){
//		String itemName = findItemName(itemNo);
//		String sql = "select item_cnt from item where item_name = ? and item_color = ?";
//		Object[] data= {itemName, itemColor};
//		
//		return jdbcTemplate.queryForObject(sql, Integer.class, data);
//	}
	//판매량 기록
	public void salesCounting(int itemNo,int sales) {
		String sql="update item set item_discount_rate = item_discount_rate+? where item_no =?";
		Object[] data= {sales,itemNo};
		jdbcTemplate.update(sql,data);
	}
}
