package com.kh.oneTrillionCompany.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.ConnectionOCDao;
import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.dao.OrderDetailDao;
import com.kh.oneTrillionCompany.dao.OrdersDao;
import com.kh.oneTrillionCompany.dto.ConnectionOCDto;
import com.kh.oneTrillionCompany.dto.MemberDto;
import com.kh.oneTrillionCompany.dto.OrderDetailDto;
import com.kh.oneTrillionCompany.dto.OrdersDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;
import com.kh.oneTrillionCompany.service.PayService;
import com.kh.oneTrillionCompany.vo.OrderVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private OrdersDao ordersDao;
	@Autowired
	private OrderDetailDao orderDetailDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private PayService payService;
	@Autowired
	private ConnectionOCDao connectionOCDao;
	@Autowired
	private ItemDao itemDao;
	
	@GetMapping("/pay")
	public String pay(Model model,HttpSession session) {
		//세션 아이디 검사 및 보내기 
		String memberId=(String) session.getAttribute("createdUser");
		if(memberId ==null) throw new TargetNotFoundException("다시 로그인 해주세요");//세션,주문자 불일치시 예외처리
		MemberDto memberDto = memberDao.selectOne(memberId);
		memberDto.setMemberPw(null); //비밀번호를 지우고 view로 전송
		model.addAttribute("memberDto",memberDto);
		//장바구니 정보 보내기(결제시 제거되어야 할 수량이 담긴)
		List<ConnectionOCDto> connectionList=connectionOCDao.selectListBySession(memberId);
		model.addAttribute("connectionList",connectionList);
		//결제 세부목록 보내기
		int orderNo=ordersDao.selectOne(memberId).getOrderNo();
		List<OrderDetailDto> detailList=orderDetailDao.selectListByOrderDetail(memberId,orderNo);
		for(int i=0; i<detailList.size(); i++) {
			OrderDetailDto orderDetailDto=detailList.get(i);
			int itemNo=detailList.get(i).getOrderDetailItemNo();
			String orderDetailItemName=itemDao.selectOne(itemNo).getItemName();
			orderDetailDto.setOrderDetailItemName(orderDetailItemName);
			detailList.set(i, orderDetailDto);
		}
		model.addAttribute("orderDetailList",detailList);
		//사진 번호 보내기
		
		//장바구니번호 - 수량 보내기
		
		
		//총 금액 보내기
		int totalPrice=0;
		int cnt=0;
		for(int i=0; i<detailList.size(); i++) {
			totalPrice+=detailList.get(i).getOrderDetailCnt()*detailList.get(i).getOrderDetailPrice();
			cnt+= detailList.get(i).getOrderDetailCnt();
		}
		model.addAttribute("totalPrice",totalPrice);
		//총 갯수 보내기
		model.addAttribute("cnt",cnt);
		//결제번호 보내기
		model.addAttribute("orderNo",orderNo);
		return "/WEB-INF/views/order/pay.jsp";
	}
//	@Transactional //중요한 절차이고 db를 거치는 횟수가 많아서 rollback이 가능하도록 -> PayService 로 이관
	@PostMapping("/pay")
	public String pay(@RequestParam("itemNo") List<Integer> itemNos,
		    @RequestParam("itemPrice") List<Integer> itemPrices,
		    @RequestParam("cnt") List<Integer> cnts,
		    @RequestParam("buyer") List<String> buyers,
		    @RequestParam("orderNo") List<Integer> orderNos,
		    @RequestParam("cartNo") List<Integer> cartNos,
		    @RequestParam("cartNoByConnection") List<Integer> cartNoList,
		    @RequestParam("cntByConnection") List<Integer> cntList, 
		    @RequestParam int orderNo,
		    @RequestParam int reward,
		    @RequestParam String orderMemo,
			HttpSession session) throws Exception {
		String memberId=(String) session.getAttribute("createdUser");
		List<OrderVO> list = new ArrayList<>();
	    for (int i = 0; i < itemNos.size(); i++) {
	        OrderVO order = new OrderVO();
	        order.setItemNo(itemNos.get(i));
	        order.setItemPrice(itemPrices.get(i));
	        order.setCnt(cnts.get(i));
	        order.setBuyer(buyers.get(i));
	        order.setOrderNo(orderNos.get(i));
	        order.setCartNo(cartNos.get(i));
	        list.add(order);
	    }
	    payService.pay(list,orderNo, reward, session,orderMemo);
	    connectionOCDao.deleteAll(memberId);
		return "redirect:payFinish?orderNo="+orderNo;
	}
	@RequestMapping("/payFinish")
	public String payFinish(HttpSession session,Model model,
			@RequestParam int orderNo) {
		String memberId = (String) session.getAttribute("createdUser");
		model.addAttribute("ordersDto",ordersDao.selectOne(orderNo));
		model.addAttribute("detailList",orderDetailDao.selectListByOrderDetail(memberId, orderNo));
		return "/WEB-INF/views/order/payFinish.jsp";
	}
	@RequestMapping("/detail")
	public String detail(HttpSession session,Model model,
			@RequestParam int orderNo) {
		String memberId=(String) session.getAttribute("createdUser");
		OrdersDto ordersDto = ordersDao.selectOne(orderNo);
		System.out.println(ordersDto);
		model.addAttribute("ordersDto",ordersDto);
		List<OrderDetailDto> list=orderDetailDao.selectListByOrderDetail(memberId, orderNo);
		List<OrdersDto> orderList=ordersDao.selectListByOrder(memberId);
		model.addAttribute("detailList",list);
		return "/WEB-INF/views/order/detail.jsp";
	}
	@GetMapping("/list")
	public String list(HttpSession session, Model model) {
		String memberId=(String) session.getAttribute("createdUser");
		
		List<OrderDetailDto>detailList=orderDetailDao.selectListByOrderDetailComplete(memberId);
		List<OrderDetailDto>refundList=orderDetailDao.selectListByOrderDetailRefund(memberId);
		model.addAttribute("memberId",memberId);
		model.addAttribute("detailList",detailList);
		model.addAttribute("refundList",refundList);
		return "/WEB-INF/views/order/list.jsp";
	}
}
