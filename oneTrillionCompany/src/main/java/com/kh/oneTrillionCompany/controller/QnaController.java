package com.kh.oneTrillionCompany.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.oneTrillionCompany.dao.QnaDao;
import com.kh.oneTrillionCompany.dto.QnaDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/service/qna")
public class QnaController {
	
	@Autowired
	private QnaDao qnaDao;
	
	/* ------------- 문의 등록------------- */
	@GetMapping("/write") 
		public String write() { 
			return "/WEB-INF/views/qna/write.jsp";
		}
	@PostMapping("/write")
	public String write(@ModelAttribute QnaDto qnaDto , HttpSession session) {
		String createdUser = (String)session.getAttribute("createdUser");
		
		qnaDto.setQnaWriter(createdUser);
		
		int seq = qnaDao.sequence();	//시퀀스 번호 생성
		qnaDto.setQnaNo(seq);
		
		//등록
		qnaDao.insert(qnaDto);
		
		//return "redirect:list?qnaNo="+seq;
		return "redirect:list";
	}
	@RequestMapping("list")
	public String list() {
	    return "/WEB-INF/views/qna/list.jsp";
	}
}
