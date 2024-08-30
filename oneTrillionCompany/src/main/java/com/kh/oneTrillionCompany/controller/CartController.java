package com.kh.oneTrillionCompany.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.CartDao;
import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dao.OrderDetailDao;
import com.kh.oneTrillionCompany.dao.OrdersDao;

import com.kh.oneTrillionCompany.service.AttachService;
import com.kh.oneTrillionCompany.vo.CartVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	private CartDao cartDao;
	@Autowired
	private ItemDao itemDao;
	@Autowired
	private OrdersDao ordersDao;
	@Autowired
	private OrderDetailDao orderDetailDao;
	
	@Autowired
	private AttachService attachService;

	//장바구니 목록
 
	@GetMapping("/list")
	public String list(Model model, HttpSession session) {
			//로그인한 사용자 조회
			String memberId = (String) session.getAttribute("createdUser");
			if(memberId != null) {
				//장바구니 목록, 상품 목록 조회
				model.addAttribute("cartList", cartDao.selectList(memberId));
				model.addAttribute("itemList", itemDao.selectList());
			
				//장바구니 주문 총 합계, 장바구니 테이블이 비어 있으면 null 들어가므로 0 처리
				Integer cartTotalPrice = cartDao.sumCartTotalPrice(memberId);
				model.addAttribute("cartTotalPrice", (cartTotalPrice != null ? cartTotalPrice : 0));
				Integer cartItemCnt = cartDao.dataCount(memberId);
				//장바구니에 담긴 상품 갯수(상품별로)
				model.addAttribute("cartItemCnt", (cartItemCnt != null ? cartItemCnt : 0));
			}
			return "/WEB-INF/views/cart/list.jsp"; 
	}
	@PostMapping("/list") //장바구니-> 주문창으로 갈때 orders 테이블에 등록
	public String list(@RequestBody List<CartVO>list, HttpSession session) { //list.jsp에서 List<CartVO>로 값을 받아서 등록
		int orderNo=ordersDao.sequence();
		String buyer = (String)session.getAttribute("createdUser");
		ordersDao.insertIntoOrdersTable(list,orderNo,buyer);
		orderDetailDao.insertByCartVOList(list,orderNo);
		return "redirect:/order/pay";
	}

	
	//장바구니 전체 삭제
	@PostMapping("/deleteAll")
	public String deleteAll() {
		try {
			cartDao.deleteAll();
		} catch (Exception e) {}
		return "redirect:list";
	}
	
	
	//장바구니 목록+검색
//	@RequestMapping("/list")
//	public String list(Model model,
//				@RequestParam(required = false) String column,
//				@RequestParam(required = false) String keyword) {
//		
//		boolean isSearch = column != null && keyword != null;
//		model.addAttribute("isSearch", isSearch);
//		
//		model.addAttribute("column", column);
//		model.addAttribute("keyword", keyword);
//		
//		if(isSearch) {
//			model.addAttribute("cartList", cartDao.selectList(column, keyword));
//		}
//		else {
//			model.addAttribute("list", cartDao.selectList());
//		}
//		return "/WEB-INF/views/emp/list.jsp"; 
//	}
		
}