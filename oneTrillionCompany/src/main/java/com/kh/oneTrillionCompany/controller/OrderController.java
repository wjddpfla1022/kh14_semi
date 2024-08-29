package com.kh.oneTrillionCompany.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.dao.OrderDetailDao;
import com.kh.oneTrillionCompany.dao.OrdersDao;
import com.kh.oneTrillionCompany.dto.MemberDto;
import com.kh.oneTrillionCompany.dto.OrderDetailDto;
import com.kh.oneTrillionCompany.dto.OrdersDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;
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
	private ItemDao itemDao;
	
	@GetMapping("/pay")
	public String pay(Model model,HttpSession session) {
		//세션 아이디 검사 및 보내기 
		String memberId=(String) session.getAttribute("createdUser");
		if(memberId ==null) new TargetNotFoundException();//TargetNotFoundException 자리
		MemberDto memberDto = memberDao.selectOne(memberId);
		memberDto.setMemberPw(null); //비밀번호를 지우고 view로 전송
		model.addAttribute("memberDto",memberDto);
		
		//결제 세부목록 보내기
		int orderNo=ordersDao.selectOne(memberId).getOrderNo();
		List<OrderDetailDto> detailList=orderDetailDao.selectListByOrderDetail(memberId,orderNo);
		model.addAttribute("orderDetailList",detailList);
		//사진 번호 보내기
		
		//총 금액 보내기
		int totalPrice=0;
		for(int i=0; i<detailList.size(); i++) {
		totalPrice+=detailList.get(i).getOrderDetailCnt()*detailList.get(i).getOrderDetailPrice();
		}
		model.addAttribute("totalPrice",totalPrice);
		//총 갯수 보내기
		int cnt=0;
		for(int i=0; i<detailList.size(); i++) {
			cnt+= detailList.get(i).getOrderDetailCnt();
		}
		model.addAttribute("cnt",cnt);
		//결제번호 보내기
		model.addAttribute("orderNo",orderNo);
		return "/WEB-INF/views/order/pay.jsp";
	}
	@Transactional //중요한 절차이고 db를 거치는 횟수가 많아서 rollback이 가능하도록
	@PostMapping("/pay")
	public String pay(@RequestParam("list[0].itemNo") List<Integer> itemNos,
		    @RequestParam("list[0].itemPrice") List<Integer> itemPrices,
		    @RequestParam("list[0].cnt") List<Integer> cnts,
		    @RequestParam("list[0].buyer") List<String> buyers,
		    @RequestParam("list[0].orderNo") List<Integer> orderNos, @RequestParam int orderNo,
			HttpSession session) {
		List<OrderVO> list = new ArrayList<>();
	    for (int i = 0; i < itemNos.size(); i++) {
	        OrderVO order = new OrderVO();
	        order.setItemNo(itemNos.get(i));
	        order.setItemPrice(itemPrices.get(i));
	        order.setCnt(cnts.get(i));
	        order.setBuyer(buyers.get(i));
	        order.setOrderNo(orderNos.get(i));
	        list.add(order);
	    }
		System.out.println(list);
		int payment=ordersDao.selectOne(orderNo).getOrderPrice();
		String memberId=(String) session.getAttribute("createdUser");
		boolean sessionVaild=list.get(0).getBuyer().equals(memberId); //세션 유효성 검사
		if(list.size()==0&&!sessionVaild) 
			return"redirect:error?error=1";
		//결제
		memberDao.payment(memberId, payment);
		//주문서 생성(detail)
		List<OrderDetailDto> detailList= orderDetailDao.selectListByOrderDetail(memberId,orderNo);
		List<Integer> detailNoList=new ArrayList<>();
		for(int i=0; i<detailList.size(); i++) {
			detailNoList.add(detailList.get(i).getOrderDetailNo());
			//재고 차감
			itemDao.deductItem(detailList.get(i).getOrderDetailCnt(),detailList.get(i).getOrderDetailItemNo());
		}
		orderDetailDao.payCompleteStatus(detailNoList);
		//임시 주문서 삭제
//		ordersDao.delete(memberId);
		return "redirect:payFinish";
	}
	@GetMapping("/payFinish")
	public String payFinish(HttpSession session,Model model) {
		String memberId = (String) session.getAttribute("createdUser");
		model.addAttribute("orderDetailList",ordersDao.selectListByOrder(memberId));
		return "/WEB-INF/views/order/payFinish.jsp";
	}
	@GetMapping("/detail")
	public String detail(@RequestParam int orderNo,
						Model model) {
		OrdersDto ordersDto = ordersDao.selectOne(orderNo);
		model.addAttribute("ordersDto",ordersDto);
		return "/WEB-INF/views/order/detail.jsp";
	}
	@GetMapping("/list")
	public String list(HttpSession session, Model model) {
		String memberId=(String) session.getAttribute("createdUser");
		
		List<OrderDetailDto>detailList=orderDetailDao.selectListByOrderDetailComplete(memberId);
		model.addAttribute("memberId",memberId);
		model.addAttribute("detailList",detailList);
		return "/WEB-INF/views/order/list.jsp";
	}
}
