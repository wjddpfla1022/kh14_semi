package com.kh.oneTrillionCompany.restcontroller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.oneTrillionCompany.dao.MemberDao;

import jakarta.servlet.http.HttpSession;

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
//	@PostMapping("/status")
//	public List<StatusVO> status(){
//		return memberDao.statusByMemberLevel();
//	}
//	@Autowired
//	private AttachmentService attachmentService;
//	//프로필 이미지만 업로드하는 매핑
//	@PostMapping("/profile")
//	public void profile(HttpSession session, @RequestParam MultipartFile attach) throws IllegalStateException, IOException {
//		if(attach.isEmpty()) return;
//		
//		//아이디 추출
//		String memberId=(String) session.getAttribute("createdUser");
//		
//		//기존 이미지가 있다면 제거(선택)
//		try {
//			int prevImageNo=memberDao.findImage(memberId);
//			attachmentService.delete(prevImageNo);
//		}
//		catch(Exception e) {}//예외 발생하면 넘어가
//		
//		
//		//신규 이미지 저장
//		int attachmentNo=attachmentService.save(attach);
//		
//		//아이디와 신규 이미지를 연결
//		memberDao.connect(memberId,attachmentNo);
//		
//	}
	
}
