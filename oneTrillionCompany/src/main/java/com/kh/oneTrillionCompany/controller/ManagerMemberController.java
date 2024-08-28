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

import com.kh.oneTrillionCompany.dao.BlockDao;
import com.kh.oneTrillionCompany.dao.ItemDao;
import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.dao.OrderDetailDao;
import com.kh.oneTrillionCompany.dao.QnaDao;
import com.kh.oneTrillionCompany.dao.ReviewDao;
import com.kh.oneTrillionCompany.dto.BlockDto;
import com.kh.oneTrillionCompany.dto.MemberDto;
import com.kh.oneTrillionCompany.dto.QnaDto;
import com.kh.oneTrillionCompany.dto.ReviewDto;
import com.kh.oneTrillionCompany.exception.TargetNotFoundException;
import com.kh.oneTrillionCompany.vo.PageVO;

@Controller
@RequestMapping("/manager/member")
public class ManagerMemberController {
	
	@Autowired
	private MemberDao memberDao;	
	@Autowired
	private BlockDao blockDao;	
	@Autowired
	private ReviewDao reviewDao;	
	@Autowired
	private QnaDao qnaDao;	
	@Autowired
	private ItemDao itemDao; 	
	@Autowired
	private OrderDetailDao orderDetailDao;
	
	//회원 검색+목록
	@RequestMapping("/list")
	public String list(
			@ModelAttribute("pageVO") PageVO pageVO, Model model) {
		if(pageVO.isSearch() && checkSearch(pageVO)) {
			model.addAttribute("list", memberDao.selectListWithBlockByPaging(pageVO));	
			int count = memberDao.countByPaging(pageVO);
			pageVO.setCount(count);
		}
		return "/WEB-INF/views/manager/member/list.jsp";
	}
	private boolean checkSearch(PageVO pageVO) {
		if(pageVO.getColumn() == null) return false;
		if(pageVO.getKeyword() == null) return false;
		switch(pageVO.getColumn()) {
		case "member_id":
		case "member_email":
		case "member_nickname":
		case "member_rank":
			return true;
		}
		return false;
	}
	
	//회원 상세
		@RequestMapping("/detail")
		public String detail(@RequestParam String memberId , Model model) {
			MemberDto memberDto = memberDao.selectOne(memberId);
			BlockDto blockDto = blockDao.selectLastOne(memberId);
			if(memberDto == null)
				throw new TargetNotFoundException("존재하지 않는 회원입니다.");
			model.addAttribute("memberDto", memberDto);
			model.addAttribute("blockDto", blockDto);
			model.addAttribute("reviewWriteList" , reviewDao.selectListByWriter(memberId));
			model.addAttribute("orderList", orderDetailDao.selectListByOrderDetail(memberId));
			model.addAttribute("qnaWriteList", qnaDao.selectListByWriter(memberId));
			return "/WEB-INF/views/manager/member/detail.jsp";
		}
	
	//회원 정보 수정 
	@GetMapping("/update")
	public String edit(@RequestParam String memberId , Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null)
			throw new TargetNotFoundException("존재하지 않는 회원입니다.");
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/manager/member/update.jsp";
	}
	
	@PostMapping("/update")
	public String update(@ModelAttribute MemberDto memberDto) {
		boolean result = memberDao.updateMemberByAdmin(memberDto);
		if(result == false) 
			throw new TargetNotFoundException("존재하지 않는 회원입니다.");
			return "redirect:detail?memberId="+memberDto.getMemberId();
		}
	
	//회원 차단
	@RequestMapping("/block")
	public String block(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) {
			throw new TargetNotFoundException("존재하지 않는 회원입니다");
			}
			return "/WEB-INF/views/manager/member/block.jsp";
		}
	
	@PostMapping("/block")
	public String block(@ModelAttribute BlockDto blockDto) {
		//마지막 이력 조회
		BlockDto lastDto = blockDao.selectLastOne(blockDto.getBlockMemberId());
		if(lastDto == null || lastDto.getBlockType().equals("해제")) {
			blockDao.insertBlock(blockDto);//차단등록
		}
		return "redirect:list";//상대
	}
		
		//회원 차단 해제
	@GetMapping("/clear")
	public String cancel(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) 
			throw new TargetNotFoundException("존재하지 않는 회원ID");
		return "/WEB-INF/views/manager/member/clear.jsp";
	}
	@PostMapping("/clear")
	public String clear(@ModelAttribute BlockDto blockDto) {
		BlockDto lastDto = blockDao.selectLastOne(blockDto.getBlockMemberId());
		if(lastDto != null && lastDto.getBlockType().equals("차단")) {
			blockDao.insertClear(blockDto);
		}
		return "redirect:list";
	}
	
	//차단 내역 목록,검색
	@RequestMapping("/blockList")
	public String list(@RequestParam(required = false) String column, @RequestParam(required = false) String keyword, Model model) {
		boolean isSearch = column != null && keyword != null;
		List<BlockDto> list = isSearch ? blockDao.selectList(column, keyword) : blockDao.selectList();
		model.addAttribute("list", list);
		model.addAttribute("column", column);
		model.addAttribute("keyword", keyword);
		return "/WEB-INF/views/manager/member/blockList.jsp";
	}
}	

	

