package com.kh.oneTrillionCompany.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dto.ItemDto;

@Controller
public class HomeController {
	@Autowired
	private ItemDao itemDao; 
	
	@RequestMapping("/")
	public String home(Model model) {
		List<ItemDto> swiperList=itemDao.selectListSwiper(7);
		List<ItemDto> mainList=itemDao.selectListMain(9);
		List<ItemDto> topList=itemDao.selectListTop(9);
		List<ItemDto> bottomList=itemDao.selectListBottom(9);
		List<ItemDto> shoesList=itemDao.selectListShoes(9);
		List<ItemDto> outerList=itemDao.selectListOuter(9);
		model.addAttribute("swiperList",swiperList);
 		model.addAttribute("mainList",mainList);
		model.addAttribute("topList",topList);
		model.addAttribute("bottomList",bottomList);
		model.addAttribute("shoesList",shoesList);
		model.addAttribute("outerList",outerList);
		return "/WEB-INF/views/home.jsp";
	}
}
