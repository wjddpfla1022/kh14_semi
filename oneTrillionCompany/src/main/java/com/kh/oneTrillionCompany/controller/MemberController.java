package com.kh.oneTrillionCompany.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.oneTrillionCompany.dao.BlockDao;
import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.dto.MemberDto;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private BlockDao blockDao;
	
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
	public String join(@ModelAttribute MemberDto memberDto) throws IllegalStateException, IOException {
		//회원가입
		memberDao.insert(memberDto);
		
		
		return "redirect:joinFinish";
	}
	@RequestMapping("/joinFinish")
	public String joinFinish() {
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("createdUser");
		session.removeAttribute("createdLevel");
		return "redirect:/";
	}
	//마이페이지 구현
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String createdUser = (String) session.getAttribute("createdUser");
		MemberDto memberDto = memberDao.selectOne(createdUser);
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("blockList", blockDao.selectBlockHistory(createdUser));	//차단 내역 확인
		return "/WEB-INF/views/member/mypage.jsp";
	}
}
