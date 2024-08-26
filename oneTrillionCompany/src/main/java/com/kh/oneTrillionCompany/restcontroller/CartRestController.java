package com.kh.oneTrillionCompany.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.oneTrillionCompany.dao.CartDao;
import com.kh.oneTrillionCompany.dto.CartDto;
import com.kh.oneTrillionCompany.dto.MemberDto;

import jakarta.servlet.http.HttpSession;

@CrossOrigin(origins={"http://localhost:8080/"})
@RestController
@RequestMapping("/rest/cart")
public class CartRestController {
	
	@Autowired
	private CartDao cartDao;
	
	@PostMapping("update")
	public 
}
