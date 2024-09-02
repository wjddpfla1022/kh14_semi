package com.kh.oneTrillionCompany.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.OrderDetailDao;
import com.kh.oneTrillionCompany.dao.RefundDao;
import com.kh.oneTrillionCompany.dto.OrderDetailDto;
import com.kh.oneTrillionCompany.dto.RefundDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/refund")
public class RefundController {

	@Autowired
	private RefundDao refundDao;
	@Autowired
	private OrderDetailDao orderDetailDao;
	
	//환불 등록
	@GetMapping("/insert")
	public String insert(Model model, @RequestParam int refundOrderDetailNo) {
		RefundDto refundDto = refundDao.selectOne(refundOrderDetailNo);
		OrderDetailDto orderDetailDto= orderDetailDao.selectOne(refundOrderDetailNo);
		model.addAttribute("refundDto", refundDto);
		model.addAttribute("orderDetailDto", orderDetailDto);
		return "/WEB-INF/views/refund/insert.jsp";
	}
	@PostMapping("/insert")
	public String insert(@ModelAttribute RefundDto refundDto) {
		//환불 정보 저장
		refundDao.insert(refundDto);
		//해당 주문 상세 정보 가져오기
		OrderDetailDto orderDetailDto = orderDetailDao.selectOne(refundDto.getRefundOrderDetailNo());
		if(orderDetailDto==null) {
			throw new TargetNotFoundException("존재하지 않는 주문입니다");
		}
		//주문 상태를 환불완료로 변경
		orderDetailDto.setOrderDetailStatus("환불완료");
		//업데이트 된 주문 상태를 저장
		orderDetailDao.update(orderDetailDto);
		//주문 목록 페이지로 리다이렉트
		return "redirect:/order/list";
	}
	//환불 목록
	@GetMapping("/list")
	public String list(HttpSession session, Model model) {
		String memberId=(String) session.getAttribute("createdUser");
		
		List<OrderDetailDto>detailList=orderDetailDao.selectListByOrderDetailRefund(memberId);
		for(int i=0; i<detailList.size(); i++) {
		}
		model.addAttribute("memberId",memberId);
		model.addAttribute("detailList",detailList);
		return "/WEB-INF/views/order/list.jsp";
	}
}
