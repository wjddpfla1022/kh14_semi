package com.kh.oneTrillionCompany.service;

import java.io.File;
import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.kh.oneTrillionCompany.dao.CertDao;
import com.kh.oneTrillionCompany.dao.MemberDao;
import com.kh.oneTrillionCompany.dto.CertDto;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {
	@Autowired
	private JavaMailSender sender;
	
	@Autowired
	private RandomService randomService;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private MemberDao memberDao;
	//회원가입시 임시 이메일 인증 코드 발송
	public boolean sendCert(String email, int size) throws MessagingException {
		String value=randomService.generateNumber(size);
		
		//메세지 생성
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		
		
		ClassPathResource resource = new ClassPathResource("templates/cert.html");
		
		
		sender.send(message);
		
		//db 기록 남기기
		certDao.delete(email);
		CertDto certDto=new CertDto();
		certDto.setCertEmail(email);
		certDto.setCertNumber(value);
		certDao.insert(certDto);
		return true;
	}
	//임시 비밀번호 발급 및 메일 전송
	public void sendTempPw(String memberId, String memberEmail) throws IOException, MessagingException {
		//임시 비밀번호 발급
		String tempPassword=randomService.generateString(12);
		memberDao.updateMemberPw(memberId, tempPassword);
		
		//이메일 템플릿 불러와 정보 설정 후 발송
		ClassPathResource resource = new ClassPathResource("templates/tempPw.html");
		File target = resource.getFile();
		Document document = Jsoup.parse(target);
		Element element = document.getElementById("temp-pw");
		element.text(tempPassword);
		
		//마임메세지 발송
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		helper.setTo(memberEmail);
		helper.setSubject("[kh정보교육원] 임시 비밀번호 안내");
		helper.setText(document.toString(),true);
		
		sender.send(message);
	}

	//비밀번호 재설정 메일 발송 기능
	public void sendResetPw(String memberId, String memberEmail) throws IOException, MessagingException {
		//이메일 템플릿 불러와서 정보 설정 후 발송
		ClassPathResource resource = new ClassPathResource("templates/reset-pw.html");
		File target=resource.getFile();
		Document document=Jsoup.parse(target);
		
		Element memberIdWrapper = document.getElementById("member-id");
		memberIdWrapper.text(memberId);
		
		//돌아올 링크 주소를 생성하는 코드
		String certNumber = randomService.generateNumber(6);
		CertDto certDto=new CertDto();
		certDto.setCertEmail(memberEmail);
		certDto.setCertNumber(certNumber);
		certDao.delete(memberEmail);
		certDao.insert(certDto);
		
		//- 접속 주소 생성 : 도구를 이용하여 현재 실행중인 주소를 자동으로 읽어오도록 처리
//하드	String url="http://localhost:8080/member/resetPw?certNumber="+certNumber
//				+ "&certNumber="+certNumber+"&certEmail="+memberEmail+"&memberId="+memberId;
		String url=ServletUriComponentsBuilder // 소프트코딩
				.fromCurrentContextPath() // http://localhost:8080/
				.path("/member/resetPw") // 나머지 경로
				.queryParam("certNumber",certNumber) // 파라미터 전달
				.queryParam("certEmail",memberEmail) // 파라미터 전달
				.queryParam("memberId",memberId) // 인자
				.build().toUriString();// http://localhost:8080/까지 읽어옴
		Element resetUrlWrapper = document.getElementById("reset-url");
		resetUrlWrapper.attr("href",url);
		
		//메세지 생성
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		helper.setTo(memberEmail);
		helper.setSubject("[kh정보교육원]비밀번호 재설정 안내");
		helper.setText(document.toString(), true);
		
		//전송
		sender.send(message);
	}
}
