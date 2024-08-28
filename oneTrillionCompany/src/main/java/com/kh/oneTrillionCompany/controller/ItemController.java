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
import com.kh.oneTrillionCompany.vo.PageVO;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	private ItemDao itemDao;

	@RequestMapping("/list")
	public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
		model.addAttribute("itemList", itemDao.selectListByPaging(pageVO));
		int count = itemDao.countByPaging(pageVO);
		pageVO.setCount(count);
		model.addAttribute("pageVO", pageVO);
		
		return "/WEB-INF/views/item/list.jsp";
	}
	
	@RequestMapping("/list/cate")
	public String listCate(Model model,
			@RequestParam(required = false) String column, 
			@RequestParam(required = false) String keyword) {
		boolean isSearch = column != null && keyword != null;

		List<ItemDto> list = isSearch ? itemDao.selectListByCate(column, keyword) : itemDao.selectList();
		model.addAttribute("column", column);
		model.addAttribute("keyword", keyword);// 검색어
		model.addAttribute("list", list);// 조회결과
		return "/WEB-INF/views/item/list.jsp";
	}

	@RequestMapping("/detail")
	public String detail(@RequestParam int itemNo, Model model) {
		ItemDto itemdto = itemDao.selectOne(itemNo);
		model.addAttribute("itemDto", itemdto);
		return "/WEB-INF/views/item/detail.jsp";
	}
	
	@GetMapping("/insert")
	public String insert() {
		
		return "/WEB-INF/views/item/insert.jsp";
	}
	@PostMapping("/insert")
	public String insert(@ModelAttribute ItemDto itemDto) {
		itemDao.insert(itemDto);
		
		return "redirect:list";
	}

	
	// 이미지
	@RequestMapping("/image")
	public String image(@RequestParam int itemNo) {
		try {
			int attachNo = itemDao.findImage(itemNo);
			return "redirect:/attach/download?attachNo=" + attachNo;
				}
				catch(Exception e){
					return "redirect:https://placehold.co/200";
				}
			}
	
	//장바구니 담기 구현 완료 후 (삭제)
		@RequestMapping("/detail2")
		public String detail2(@RequestParam int itemNo, Model model) {
			ItemDto itemDto = itemDao.selectOne(itemNo);
			model.addAttribute("itemDto", itemDto);
			return "/WEB-INF/views/item/detail2.jsp?itemNo=2";
		}
}
