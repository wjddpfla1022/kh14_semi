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

import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.dto.MemberDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;

@Controller
@RequestMapping("/manager")
public class ManagerMemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	//회원 검색+목록
	@RequestMapping("/list")
	public String list(Model model, 
							@RequestParam(required = false) String column,
							@RequestParam(required = false) String keyword) {
		boolean isSearch = column != null & keyword != null;
		List<MemberDto> list = isSearch? memberDao.selectListByOption(column, keyword) : memberDao.selectList();	
		model.addAttribute("column" , column);
		model.addAttribute("keyword" , keyword);
		model.addAttribute("list", list);
		return "/WEB-INF/views/manager/member/list.jsp";
	}
	
	//회원 상세
	@RequestMapping("/detail")
	public String detail(@RequestParam String memberId , Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null)
			throw new TargetNotFoundException("존재하지 않는 회원입니다.");
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/manager/member/detail.jsp";
	}
	
	//회원 정보 수정 
	@GetMapping("/edit")
	public String edit(@RequestParam String memberId , Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null)
			throw new TargetNotFoundException("존재하지 않는 회원입니다.");
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/manager/member/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto) {
		boolean result = memberDao.updateMemberByAdmin(memberDto);
		if(result == false) 
			throw new TargetNotFoundException("존재하지 않는 회원입니다.");
			return "redirect:detail?memberId="+memberDto.getMemberId();
		}
	}	
	
	//회원 차단
//	@GetMapping("/block")
//	@PostMapping("/block")
	
	//회원 차단 해제
//	@GetMapping("/cancel")
//	@PostMapping("/cancel")

