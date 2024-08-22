package com.kh.oneTrillionCompany.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dto.ItemDto;


@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	private ItemDao itemDao;
	
	
	@RequestMapping("/list")
	public String detail(Model model, 
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword) {
		boolean isSearch = column != null && keyword != null;
		
		List<ItemDto> list = isSearch ?
				itemDao.selectList(column, keyword) : itemDao.selectList();
			
			model.addAttribute("column", column);//검색분류
			model.addAttribute("keyword", keyword);//검색어
			model.addAttribute("list", list);//조회결과
			return "/WEB-INF/views/item/list.jsp";
		}
	@RequestMapping("/detail")
	public String detail(@RequestParam String itemNo, Model model) {
		ItemDto itemdto = itemDao.selectOne(itemNo);
		model.addAttribute("itemdto", itemdto);
		return "/WEB-INF/views/item/detail.jsp";
	}
	
}
