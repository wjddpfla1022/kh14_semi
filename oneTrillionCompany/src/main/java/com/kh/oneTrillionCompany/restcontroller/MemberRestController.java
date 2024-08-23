package com.kh.oneTrillionCompany.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.vo.StatusVO;

@CrossOrigin(origins="http://localhost:8080/")
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	@Autowired
	private MemberDao memberDao;
	
//	@RequestMapping("/checkId")
	@PostMapping("/checkId")
	public boolean checkId(@RequestParam String memberId) {
		return memberDao.selectOne(memberId)==null;
			
	}
	@PostMapping("/checkNickname")
	public boolean checkNickname(@RequestParam String memberNickname) {
		return memberDao.canIUseThisMemberNickname(memberNickname);
	}
	@PostMapping("/status")
	public List<StatusVO> status(){
		return memberDao.statusByMemberLevel();
	}
}
