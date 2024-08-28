package com.kh.oneTrillionCompany.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dao.ItemInfoDao;
import com.kh.oneTrillionCompany.dto.ItemDto;
import com.kh.oneTrillionCompany.dto.ItemInfoDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;
import com.kh.oneTrillionCompany.service.AttachService;
import com.kh.oneTrillionCompany.vo.PageVO;

@Controller
@RequestMapping("/manager/item")
public class ManagerItemController {

	@Autowired
	private AttachService attachService;
	
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
	public String insert(@ModelAttribute ItemDto itemDto, MultipartFile attach) throws IllegalStateException, IOException {
			// 2. 첨부파일이 있다면 등록
			// 2-1. 시퀀스 생성
			int itemNo = itemDao.sequence();
			itemDto.setItemNo(itemNo);
			itemDao.insert(itemDto);
			
			if(!attach.isEmpty()) {
			int attachNo = attachService.save(attach);
			itemDao.connect(itemDto.getItemNo(), attachNo);
		}
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
	
	//여러개 삭제
		@PostMapping("/deleteAll")
		public String deleteAll(@RequestParam(value="itemNo") List<Integer> list) {
			for (int itemNo:list) {
				try {
					int attachNo = itemDao.findImage(itemNo);
					attachService.delete(attachNo);
				} catch (Exception e) {
				}
				finally {
					itemDao.delete(itemNo);
				}
			}
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
	
	//Infomation
	
	@Autowired
	private ItemInfoDao infoDao;
	
	@GetMapping("/info/write")
	public String write() {
		return "/WEB-INF/views/itemInfo/write.jsp";
	}
	@PostMapping("/info/write")
	public String write(@ModelAttribute ItemInfoDto infoDto, @RequestParam int itemNo) {
		int sequence = infoDao.sequence();
		infoDto.setInfoNo(sequence);
		infoDto.setInfoItemNo(itemNo);
		infoDao.write(infoDto);
		return "redirect:/manager/item/list";
	}
	
	@RequestMapping("/read")
	public String read(@RequestParam int infoNo, Model model) {
		ItemInfoDto infoDto = infoDao.selectOne(infoNo);
		if(infoDto == null) throw new TargetNotFoundException("존재하지 않는 글 번호");
		model.addAttribute("infoDto", infoDto);
		return "/WEB-INF/views/itemInfo/read.jsp";
	}
	
}
