package com.kh.oneTrillionCompany.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.oneTrillionCompany.dao.ReviewDao;
import com.kh.oneTrillionCompany.dto.ReviewDto;
import com.kh.oneTrillionCompany.service.AttachService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewDao reviewDao;	
	
	@Autowired
	private AttachService attachService;
	
	//리뷰 글 등록 페이지
	@GetMapping("/write")
	public String write(HttpSession session, Model model) {
		String memberId = (String)session.getAttribute("createdUser");
		model.addAttribute("memberId", memberId);
		
		return "/WEB-INF/views/review/write.jsp";
	}
	@Transactional
	@PostMapping("/write")
	public String write(@ModelAttribute ReviewDto reviewDto, HttpSession session, MultipartFile attach) throws IllegalStateException, IOException {
		
		//세션에서 아이디 추출
		String createdUser = (String)session.getAttribute("createdUser");
		reviewDto.setReviewWriter(createdUser);
		
		//시퀀스 번호 생성
		int seq = reviewDao.sequence();
		
		//등록할 정보에 번호 첨부
		reviewDto.setReviewNo(seq);
		//등록
		reviewDao.insertWithSequence(reviewDto);
		
		if(!attach.isEmpty()) {
		int attachNo = attachService.save(attach);
		reviewDao.connect(reviewDto.getReviewNo(), attachNo);
		}
		//생성한 번호에 맞는 상세페이지로 리다이렉트(추방)
		return "redirect:complete";
	}
	@RequestMapping("/complete")
	public String complete() {
		return "/WEB-INF/views/review/complete.jsp";
	}
	
	//리뷰 목록,검색
	@RequestMapping("/list")
	public String list(@RequestParam(required = false) String column, @RequestParam(required = false) String keyword, Model model) {
		boolean isSearch = column != null && keyword != null;
		List<ReviewDto> list = isSearch ? reviewDao.selectList(column, keyword) : reviewDao.selectList();
		model.addAttribute("list", list);
		model.addAttribute("column", column);
		model.addAttribute("keyword", keyword);
		return "/WEB-INF/views/review/list.jsp";
	}
	
}