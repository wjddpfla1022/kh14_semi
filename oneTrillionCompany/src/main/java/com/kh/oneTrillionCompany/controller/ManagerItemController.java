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
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;
import com.kh.oneTrillionCompany.vo.PageVO;

@Controller
@RequestMapping("/manager/item")
public class ManagerItemController {

	@Autowired
	private ItemDao itemDao;
	
	//상품 검색 + 목록
	@RequestMapping("/list")
	public String list(@ModelAttribute("pageVO") PageVO pageVO, 
									Model model) {
		model.addAttribute("itemList", itemDao.selectListByPaging(pageVO));
		int count = itemDao.countByPaging(pageVO);
		pageVO.setCount(count);
		model.addAttribute("pageVO", pageVO);
		
		return "/WEB-INF/views/manager/item/list.jsp";
	}
	private boolean checkSearch(String column, String keyword) {
		if(column == null) return false;
		if(keyword == null) return false;
		switch(column) {
		case "item_no":
		case "item_cate1":
		case "item_name":
			return true;
		}
		return false;
	}
	
	//상품 추가
	@GetMapping("/insert")
	public String insert() {
		
		return "/WEB-INF/views/manager/item/insert.jsp";
	}
	@PostMapping("/insert")
	public String insert(@ModelAttribute ItemDto itemDto) {
		itemDao.insert(itemDto);
		
		return "redirect:list";
	}
	
	//상품 수정
	@GetMapping("/update")
	public String update(Model model, @RequestParam int itemNo) {
		ItemDto itemDto = itemDao.selectOne(itemNo);
		model.addAttribute("itemDto", itemDto);
		
		return "/WEB-INF/views/manager/item/update.jsp";
	}
	
	@PostMapping("/update")
	public String update(@ModelAttribute ItemDto itemDto) {
		itemDao.update(itemDto);
		
		return "redirect:list";
	}
	
	//상품 삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int itemNo) {
		ItemDto itemDto = itemDao.selectOne(itemNo);
		if(itemDto == null) throw new TargetNotFoundException("존재하지 않는 상품");
		
		boolean result = itemDao.delete(itemNo);
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
					return "redirect:/images/200.png";
				}
			}
	
}
