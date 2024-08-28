package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.CartDto;
import com.kh.oneTrillionCompany.dto.ItemDto;
import com.kh.oneTrillionCompany.mapper.CartMapper;
import com.kh.oneTrillionCompany.vo.ItemCartVO;

@Repository
public class CartDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private CartMapper cartMapper;
	//임시 삭제하기 장바구니 등록 상품으로 옮기면

	
	//장바구니 등록
	public void insert(CartDto cartDto) {
		String sql = "insert into cart(cart_no, cart_item_no, cart_buyer, cart_cnt,"
					+ " item_attacth_no, cart_total_price)"
					+ " values(cart_seq.nextval, cart_item_no_seq.nextval, ?, ?, ?, ?)";
		Object[] data = {
				cartDto.getCartNo(), cartDto.getCartItemNo(), cartDto.getCartBuyer(), 
				cartDto.getCartCnt(), cartDto.getItemAttachNo(), 
				cartDto.getCartTotalPrice()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//장바구니 삭제
	public boolean delete(int itemNo) {
		String sql = "delete cart where cart_no = ?";
		Object[] data = {itemNo};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//장바구니 전체삭제//
	public void deleteAll() {
		String sql = "delete from cart";
		jdbcTemplate.update(sql);
	}
	
	//장바구니 수정(상품수량, 주문총가격)
	public boolean updateCart(CartDto cartDto) {
		String sql = "update cart set "
					+ "cart_cnt=?, cart_total_price=? "
					+ "where cart_no=?";
		Object[] data = { 
				cartDto.getCartCnt(), cartDto.getCartTotalPrice(),
				cartDto.getCartNo()
		};
		return jdbcTemplate.update(sql,data) > 0;	
	}
	
	//장바구니 목록
	public List<CartDto> selectList(String memberId) {
		String sql = "select * from cart where cart_buyer = ? order by cart_no asc";
		Object[] data = {memberId};
		return jdbcTemplate.query(sql, cartMapper, data);		
	}
	
	//장바구니 상세 정보
	public CartDto selectOne(String cartBuyer) {
		String sql = "select * from cart where cart_buyer = ?";
		Object[] data = {cartBuyer};
		List<CartDto> list = jdbcTemplate.query(sql, cartMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//장바구니 검색
	public List<CartDto> selectList(String column, String keyword) {
		String sql = "select * from cart "
				+ "where instr(" + column +", ?) > 0 "
				+ "order by cart_no asc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, cartMapper, data);			
	}

	//이미지 번호 찾기
	public Integer findImage(int cartNo) {
		String sql = "select attach from cart where item_no=?";
		Object[] data = {cartNo};
		return jdbcTemplate.queryForObject(sql, Integer.class, data);
	}
		
	//장바구니 수량 업데이트
	public boolean updateCartCnt(CartDto cartDto) {
		String sql = "update cart set cart_cnt=? where cart_no=? and cart_buyer=?";
		Object[] data = { cartDto.getCartCnt(), cartDto.getCartNo(), 
							cartDto.getCartBuyer() };
		return jdbcTemplate.update(sql,data) > 0;
	}

	//장바구니 총 금액
	public Integer sumCartTotalPrice(String memberId) {
		String sql = "select sum(cart_cnt*item_price) from "
				+ "cart join item on CART_ITEM_NO = item_no "
				+ "where CART_BUYER = ?";
		Object[] data = {memberId};
		return jdbcTemplate.queryForObject(sql, Integer.class, data);
	}
	
	public Integer lastCartNumber(String memberId) {
	    String sql = "select cart_no from("
	            + "select cart_no from cart "
	            + "where cart_buyer = ? "
	            + "order by cart_no desc) where rownum = 1";
	    Object[] data = {memberId};
	    try {
	        return jdbcTemplate.queryForObject(sql, Integer.class, data);
	    } catch (EmptyResultDataAccessException e) {
	        // 결과가 없는 경우 0 또는 null 반환
	        return null; // 또는 return 0; (적절한 기본값으로 수정 가능)
	    }
	}
	
	//컬러와 상품명으로 아이템을 찾기
	public Integer findItemNo(String itemName, String itemColor) {
		String sql = "select item_no from item where item_name=? and item_color=?";
		Object[] data = {itemName, itemColor};
		 try {
	         return jdbcTemplate.queryForObject(sql, Integer.class, data);
		 } catch (Exception e) {
	            return null;
	        }
	 }

	public void itemInsertCart(String cartBuyer, String itemName, 
												String itemColor, int cartCnt) {
		Integer itemNo = findItemNo(itemName, itemColor);
		String sql ="insert into cart (cart_no, cart_buyer, cart_item_no, cart_cnt) values(cart_seq.nextval, ?, ?, ?)";
		Object[] data = {cartBuyer, itemNo, cartCnt};
		jdbcTemplate.update(sql, data);
	}
	
}