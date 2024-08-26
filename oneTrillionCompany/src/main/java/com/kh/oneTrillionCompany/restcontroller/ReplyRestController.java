package com.kh.oneTrillionCompany.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.oneTrillionCompany.dao.QnaDao;
import com.kh.oneTrillionCompany.dao.ReplyDao;
import com.kh.oneTrillionCompany.dto.ReplyDto;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {

	@Autowired
	private ReplyDao replyDao;
	@Autowired
	private QnaDao qnaDao;
	
	//댓글 작성
	@PostMapping("/write")
	public void write(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		//시퀀스 번호 생성
		int seq = replyDao.sequence();
		//작성자정보 불러오기
		String memberId=(String)session.getAttribute("createdUser");
		//정보설정
		replyDto.setReplyNo(seq);
		replyDto.setReplyWriter(memberId);
		//등록
		replyDao.insert(replyDto);
		///댓글 수 최신화
		qnaDao.updateQnaReply(replyDto.getReplyOrigin());
	}
	
	//댓글 목록
	@PostMapping("/list")
	public List<ReplyDto> list(@RequestParam int replyOrigin){
		return replyDao.selectList(replyOrigin);
	}
	
	
}
