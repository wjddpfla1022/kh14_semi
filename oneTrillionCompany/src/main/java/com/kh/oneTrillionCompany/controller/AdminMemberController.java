package com.kh.oneTrillionCompany.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.kh.oneTrillionCompany.dao.ReviewDao;

@Controller
@RequestMapping("/manager")
public class AdminMemberController {
	
	@Autowired
	private ReviewDao reviewDao;
	
//	//회원 상세
//	@RequestMapping("/detail")
//	
//	
//	//회원 정보 수정 
//	@GetMapping("/edit")
//	@PostMapping("/edit")
//	
//	//회원 차단
//	@GetMapping("/block")
//	@PostMapping("/block")
//	
//	//회원 차단 해제
//	@GetMapping("/cancel")
//	@PostMapping("/cancel")

}
