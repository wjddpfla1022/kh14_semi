package com.kh.oneTrillionCompany.restcontroller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dto.ItemDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;
import com.kh.oneTrillionCompany.service.AttachService;
import com.kh.oneTrillionCompany.service.ItemService;
import com.kh.oneTrillionCompany.vo.ItemPageVO;

@CrossOrigin(origins= { "http://127.0.0.1:5500" })
@RestController
@RequestMapping("/rest/item")
public class ItemRestController {
	
	@Autowired
	private ItemDao itemDao;
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private AttachService attachService;
	
	@PostMapping("/upload")
	public int upload(@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		if(attach.isEmpty()) {
			throw new TargetNotFoundException("파일이 없습니다");
		}
		int attachNo = attachService.save(attach);
		return attachNo;
	}
	
	@PostMapping("/uploads")
	public List<Integer> uploads(
			@RequestParam(value = "attach") List<MultipartFile> attachList) throws IllegalStateException, IOException {
		List<Integer> results = new ArrayList<>();//번호 담을 저장소 생성
		for(MultipartFile attach : attachList) {//사용자가 보낸 파일 수만큼 반복
			if(!attach.isEmpty()) {
				int attachNo = attachService.save(attach);
				results.add(attachNo);
			}
		}
		return results;
	}
//	 @GetMapping("/item/count")
//	    public int getItemCount(@RequestParam("itemNo") int itemNo, @RequestParam("itemColor") String itemColor) {
//	        return itemService.selectItemCntByNameColor(itemNo, itemColor);
//	    }
	@PostMapping("/list")
	public List<ItemDto> list(@RequestParam String sorting,
							@ModelAttribute ItemPageVO itemPageVO ){
		List<ItemDto> itemList=itemDao.selectListByPaging(itemPageVO, sorting);
		return itemList;
	}
}
