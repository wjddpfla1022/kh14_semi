package com.kh.oneTrillionCompany.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.dto.MemberDto;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	@PostMapping("/login")
	public String login(@RequestParam String memberId,
			@RequestParam String memberPw, 
			@RequestParam(required = false) String remember, //아이디 저장하기
			HttpSession session, HttpServletResponse response) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		boolean isValid = memberDao.selectOne(memberId)!=null;
		if(isValid) {
			session.setAttribute("createdUser", memberId);
			session.setAttribute("createdLevel", memberDto.getMemberRank());
			memberDao.updateMemberLogin(memberId);
			return "redirect:/";
		}
		else {
			return "redirect:login?error";
			
		}
		
		
	}
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	@Transactional
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		//회원가입
		memberDao.insert(memberDto);
		
		if(!attach.isEmpty()){
			//첨부파일 등록
//			int attachmentNo=attachmentService.save(attach);
			//회원 이미지 연결정보 저장
//			memberDao.connect(memberDto.getMemberId(),attachmentNo);
		}
		
		return "redirect:joinFinish";
	}
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	
}
