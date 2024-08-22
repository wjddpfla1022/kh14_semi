package com.kh.oneTrillionCompany.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.ItemDao;

@Controller
@RequestMapping("/cart")
public class CartController {
	
	@Autowired
	private ItemDao itemDao;
	
	//상품 삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int itemNo) {
		itemDao.delete(itemNo);
		return "redirect:list";
	}

}  
