package com.kh.oneTrillionCompany.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.oneTrillionCompany.dao.RefundDao;
import com.kh.oneTrillionCompany.dto.RefundDto;

@Controller
@RequestMapping("/refund")
public class RefundController {

	@Autowired
	private RefundDao refundDao;
	
	@RequestMapping("/insert")
	public String insert() {
		return "/WEB-INF/views/refund/insert.jsp";
	}
	public String insert(@ModelAttribute RefundDto refundDto) {
		refundDao.insert(refundDto);
		return "redirect:/order/list";
	}
}
