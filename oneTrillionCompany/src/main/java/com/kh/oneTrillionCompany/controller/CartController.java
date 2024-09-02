package com.kh.oneTrillionCompany.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.CartDao;
import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dao.OrderDetailDao;
import com.kh.oneTrillionCompany.dao.OrdersDao;
import com.kh.oneTrillionCompany.dto.CartDto;
import com.kh.oneTrillionCompany.dto.ItemDto;
import com.kh.oneTrillionCompany.service.AttachService;
import com.kh.oneTrillionCompany.vo.CartItemVO;
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
	public String list(Model model,HttpSession session) {
			//로그인한 사용자 조회
			String memberId = (String) session.getAttribute("createdUser");
				//장바구니 목록, 상품 목록 조회
				List<CartDto> cartList =cartDao.selectList(memberId);
				List<CartItemVO> cartItemVOList = new ArrayList<>();
				for(int i=0; i<cartList.size(); i++) {
					// CartDto에서 필요한 정보 추출
				    CartDto cartDto = cartList.get(i);
				    int cartItemNo = cartDto.getCartItemNo();

				    // ItemDto에서 추가 정보 가져오기
				    ItemDto itemDto = itemDao.selectOne(cartItemNo);
				    String itemName = itemDto.getItemName();
				    String itemColor = itemDto.getItemColor();
				    int itemPrice = itemDto.getItemPrice();
				    int itemStock=itemDto.getItemCnt();
				    
				    // CartItemVO 객체 생성 및 정보 설정
				    CartItemVO cartItemVO = new CartItemVO();
				    cartItemVO.setCartNo(cartDto.getCartNo());
				    cartItemVO.setCartItemNo(cartItemNo);
				    cartItemVO.setCartBuyer(cartDto.getCartBuyer());
				    cartItemVO.setCartCnt(cartDto.getCartCnt());
				    cartItemVO.setItemAttachNo(cartDto.getItemAttachNo());
				    cartItemVO.setCartTotalPrice(cartDto.getCartTotalPrice());
				    cartItemVO.setItemName(itemName);
				    cartItemVO.setItemColor(itemColor);
				    cartItemVO.setItemPrice(itemPrice);
				    cartItemVO.setItemStock(itemStock);

				    // 리스트에 추가
				    cartItemVOList.add(cartItemVO);
					
					
				}
				model.addAttribute("cartItemVOList",cartItemVOList);
				//장바구니 주문 총 합계, 장바구니 테이블이 비어 있으면 null 들어가므로 0 처리
				Integer cartTotalPrice = cartDao.sumCartTotalPrice(memberId);
				model.addAttribute("cartTotalPrice", (cartTotalPrice != null ? cartTotalPrice : 0));
				Integer cartItemCnt = cartDao.dataCount(memberId);
				//장바구니에 담긴 상품 갯수(상품별로)
				model.addAttribute("cartItemCnt", (cartItemCnt != null ? cartItemCnt : 0));
			return "/WEB-INF/views/cart/list.jsp"; 
	}
	@Transactional
	@PostMapping("/list")
	public String list(
			 @RequestParam("cartItemNo") List<Integer> cartItemNoList,
	            @RequestParam("cartItemCnt") List<Integer> cartItemCntList,
	            @RequestParam("buyer") List<String> buyerList,
	            @RequestParam("cartItemPrice") List<Integer> cartItemPriceList
	    ) {
		List<CartVO> list=new ArrayList<>();
	        for (int i = 0; i < cartItemNoList.size(); i++) {
	            CartVO cartVO = new CartVO();
	            cartVO.setBuyer(buyerList.get(i));
	            cartVO.setCartItemCnt(cartItemCntList.get(i));
	            cartVO.setCartItemNo(cartItemNoList.get(i));
	            cartVO.setCartItemPrice(cartItemPriceList.get(i));
	            list.add(cartVO);
	        }
	    int orderNo = ordersDao.sequence();
	    ordersDao.insertIntoOrdersTable(list, orderNo);
	    orderDetailDao.insertByCartVOList(list, orderNo);
	    for(int i=0; i<cartItemNoList.size(); i++)
	    	cartDao.delete(cartItemNoList.get(i));
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