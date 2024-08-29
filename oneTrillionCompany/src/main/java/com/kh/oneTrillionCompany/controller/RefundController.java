package com.kh.oneTrillionCompany.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.RefundDao;
import com.kh.oneTrillionCompany.dto.RefundDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;

@Controller
@RequestMapping("/refund")
public class RefundController {

	@Autowired
	private RefundDao refundDao;
	
	@GetMapping("/insert")
	public String insert(Model model, @RequestParam int refundOrderDetailNo) {
		RefundDto refundDto = refundDao.selectOne(refundOrderDetailNo);
		if(refundDto == null) throw new TargetNotFoundException("존재하지 않는 주문입니다");
		model.addAttribute("refundDto", refundDto);
		return "/WEB-INF/views/refund/insert.jsp";
	}
	@PostMapping("/insert")
	public String insert(@ModelAttribute RefundDto refundDto) {
		refundDao.insert(refundDto);
		return "redirect:/order/list";
	}
}
