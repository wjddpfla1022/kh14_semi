package com.kh.oneTrillionCompany.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.vo.OrderVO;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	
	@GetMapping("/pay")
	public String pay(Model model) {
		return "/WEB-INF/views/order/pay.jsp";
	}
	@Transactional //
	@PostMapping("/pay")
	public String pay(@RequestParam List<OrderVO>list) {
		list.get(0).getItemNo();
		list.get(1).getCnt();
		return "redirect:payFinish";
	}
	@RequestMapping("/payFinish")
	public String payFinish() {
		return "/WEB-INF/views/order/payFinish.jsp";
	}
}
