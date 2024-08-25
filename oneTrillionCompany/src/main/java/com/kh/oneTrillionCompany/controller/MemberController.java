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

import com.kh.oneTrillionCompany.configuration.CustomCertProperties;
import com.kh.oneTrillionCompany.dao.BlockDao;
import com.kh.oneTrillionCompany.dao.CertDao;
import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.dto.CertDto;
import com.kh.oneTrillionCompany.dto.MemberDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private BlockDao blockDao;
	@Autowired
	private CertDao certDao;
	@Autowired
	private CustomCertProperties customCertProperties;
	
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
	//비밀번호 재설정 페이지
		@GetMapping("/resetPw")
		public String resetPw(@ModelAttribute CertDto certDto
							,@RequestParam String memberId
							,Model model) {
			boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
			//isValid 가 true인 경우만 통과하도록 처리하면 비정상적 접근을 막을 수 있다.
			if(isValid) {
				model.addAttribute("certDto", certDto);
				model.addAttribute("memberId",memberId);
				return "/WEB-INF/views/member/resetPw.jsp";
			}
			else {
				throw new TargetNotFoundException("올바르지 않은 접근");
			}
		}
		@PostMapping("/resetPw")
		public String resetPw(@ModelAttribute CertDto certDto,
							@ModelAttribute MemberDto memberDto) {
			boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
			if(!isValid) {
				throw new TargetNotFoundException("올바르지 않은 접근");
			}
			//인증 성공 시 인증번호 삭제
			//이 페이지는 1회만 접근 가능해짐
			certDao.delete(certDto.getCertEmail());
			
			//비밀번호 변경 처리
			memberDao.updateMemberPw(memberDto.getMemberId(), memberDto.getMemberPw());
			return "redirect:resetPwFinish";
		}
		@RequestMapping("/resetPwFinish")
		public String resetPwFinish() {
			return "/WEB-INF/views/member/resetPwFinish.jsp";
		}
}
