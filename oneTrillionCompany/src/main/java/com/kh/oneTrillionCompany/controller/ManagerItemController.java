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

import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dto.ItemDto;

@Controller
@RequestMapping("/manager/item")
public class ManagerItemController {

	@Autowired
	private ItemDao itemDao;
	
	//상품 검색 + 목록
	@RequestMapping("/list")
	public String list(Model model, 
									@RequestParam(required = false) String column, 
									@RequestParam(required = false) String keyword) {
		boolean isSearch = column != null && keyword != null;
		
		List<ItemDto> list = isSearch ? itemDao.selectList(column, keyword) : itemDao.selectList();
		
		model.addAttribute("column", column);
		model.addAttribute("keyword", keyword);
		model.addAttribute("list", list);
		return "/WEB-INF/views/manager/item/list.jsp";
	}
	
	@GetMapping("/insert")
	public String insert() {
		
		return "/WEB-INF/views/manager/item/insert.jsp";
	}
	@PostMapping("/insert")
	public String insert(@ModelAttribute ItemDto itemDto) {
		itemDao.insert(itemDto);
		
		return "redirect:list";
	}
}
