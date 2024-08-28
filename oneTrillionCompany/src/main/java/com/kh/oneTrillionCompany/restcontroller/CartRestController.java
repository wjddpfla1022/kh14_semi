package com.kh.oneTrillionCompany.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.oneTrillionCompany.dao.CartDao;
import com.kh.oneTrillionCompany.dto.CartDto;

import jakarta.servlet.http.HttpSession;

@CrossOrigin(origins={"http://localhost:8080/"})
@RestController
@RequestMapping("/rest/cart")
public class CartRestController {
	
	@Autowired
	private CartDao cartDao;
	
	//장바구니 수량 증가 DB 업데이트
	@PostMapping("/cartCntUpdate")
	public void cartCntUpdate(@RequestParam int cartNo, 
							@RequestParam int cartCnt, HttpSession session){
		String cartBuyer = (String) session.getAttribute("createdUser");
		CartDto cartDto = new CartDto();
		cartDto.setCartNo(cartNo);
		cartDto.setCartCnt(cartCnt);
		cartDto.setCartBuyer(cartBuyer);
		
		cartDao.updateCartCnt(cartDto);
	}
	
	//장바구니 총구매금액
	@PostMapping("/cartTotalPriceUpdate")
	public Integer cartTotalPriceupdat(HttpSession session) {
		String cartBuyer = (String) session.getAttribute("createdUser");
		Integer cartTotalPrice = cartDao.sumCartTotalPrice(cartBuyer);
		cartTotalPrice = cartTotalPrice != null ? cartTotalPrice : 0;
		return cartTotalPrice;
	}
	
	//장바구니 등록
	@PostMapping("/insertCart")
	public void insertCart(HttpSession session,
							@RequestParam String itemName, @RequestParam String itemColor, 
							@RequestParam int cartCnt ) {
		String cartBuyer = (String)session.getAttribute("createdUser");
		cartDao.itemInsertCart(cartBuyer, itemName, itemColor, cartCnt);
	}
}