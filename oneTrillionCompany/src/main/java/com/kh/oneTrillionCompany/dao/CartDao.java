package com.kh.oneTrillionCompany.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.oneTrillionCompany.dto.CartDto;
import com.kh.oneTrillionCompany.dto.ItemDto;
import com.kh.oneTrillionCompany.mapper.CartMapper;
import com.kh.oneTrillionCompany.mapper.ItemMapper;


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
	public boolean delete(int cartNo) {
		String sql = "delete cart where cart_no = ?";
		Object[] data = {cartNo};
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
	//카트번호로 수량 조회(결제)
	public int selectCnt(int cartNo) {
		String sql="select * from cart where cart_no=?";
		Object[] data= {cartNo};
		List<CartDto> list =jdbcTemplate.query(sql, cartMapper,data);
		int result = list.get(0).getCartCnt();
		return result;
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
	//장바구니 수량 업데이트(결제시)
	public boolean updateCartCnt(String buyer,int cartNo, int itemCnt) {
		String sql = "update cart set cart_cnt=cart_cnt-? where cart_no=? and cart_buyer=?";
		Object[] data= {itemCnt,cartNo,buyer};
		return jdbcTemplate.update(sql, data)>0;
	}
	//장바구니 총 금액
	public Integer sumCartTotalPrice(String memberId) {
		String sql = "select sum(cart_cnt*item_sale_price) from "
				+ "cart join item on CART_ITEM_NO = item_no "
				+ "where CART_BUYER = ?";
		Object[] data = {memberId};
		return jdbcTemplate.queryForObject(sql, Integer.class, data);
	}
	//데이터 갯수 가져오기
	public int dataCount(String memberId) {
	    String sql =  "select count(*) from cart where cart_buyer = ?";
	    Object[] data = {memberId};
	    return jdbcTemplate.queryForObject(sql, Integer.class, data);
	}
	
	//컬러와 상품명으로 아이템 번호를 찾는다
	public Integer findItemNo(String itemName, String itemColor, String itemSize) {
		String sql = "select item_no from item where item_name=? and item_color=? and item_size=?";
		Object[] data = {itemName, itemColor, itemSize};
		 try {
	         return jdbcTemplate.queryForObject(sql, Integer.class, data);
		 } catch (Exception e) {
	            return null;
	        }
	 }
	
	//상품을 장바구니에 등록하는 메소드
	public void itemInsertCart(String itemName, String itemColor,String cartBuyer, 
											int itemSalePrice, int cartCnt, int attachNo, String itemSize) {
		Integer itemNo = findItemNo(itemName, itemColor, itemSize);
		Integer cartTotalPrice = sumCartTotalPrice(cartBuyer);

		//장바구니 총합계에 새로운 아이템이 추가될때마다 가격을 증가시킨다
		cartTotalPrice = cartTotalPrice != null ? cartTotalPrice + (itemSalePrice * cartCnt) : (itemSalePrice * cartCnt);
		String sql ="insert into cart (cart_no, cart_item_no, cart_buyer, cart_cnt, "
				+ "item_attach_no, cart_total_price"
				+ ") values(cart_seq.nextval, ?, ?, ?, ?, ?)";
		Object[] data = {itemNo, cartBuyer, cartCnt, attachNo, cartTotalPrice};
		jdbcTemplate.update(sql, data);
	}
	

	//장바구니 체크 항목들 삭제
	public boolean checkDelete(List<Integer> cartNoList) {
		if (cartNoList == null || cartNoList.isEmpty()) {
            return false; // 삭제할 항목이 없으면 false 반환
        }

        // SQL 쿼리 문자열 생성 (IN 절 사용)
        StringBuilder sql = new StringBuilder("DELETE FROM cart WHERE cart_no IN (");
        for (int i = 0; i < cartNoList.size(); i++) {
            sql.append("?");
            if (i < cartNoList.size() - 1) {
                sql.append(", ");
            }
        }
        sql.append(")");

        // 데이터를 배열로 변환
        Object[] data = cartNoList.toArray();

        // SQL 쿼리 실행
        return jdbcTemplate.update(sql.toString(), data) > 0;
	}
		
	//품절 유무를 위해 아이템 컬러를 뽑는다 -> itemDao로 옮기기
	public List<String> selectItemColors(String itemName) {
		String sql = "select item_color from item where item_name=?";
		return jdbcTemplate.queryForList(sql, String.class, itemName);
	}
	
}
