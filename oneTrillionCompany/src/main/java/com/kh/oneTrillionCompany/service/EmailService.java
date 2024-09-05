package com.kh.oneTrillionCompany.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

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
import com.kh.oneTrillionCompany.dto.OrderDetailDto;
import com.kh.oneTrillionCompany.dto.OrdersDto;

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
	public boolean sendCert(String email, int size) throws MessagingException, IOException {
		String value=randomService.generateNumber(size);
		
		//메세지 생성 - 마임 메세지 객체
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
		helper.setTo(email);
		helper.setSubject("[일조쇼핑몰] 인증번호 안내");
		
		
		ClassPathResource resource = new ClassPathResource("templates/cert.html");
		File target = resource.getFile();
		Document document = Jsoup.parse(target, "UTF-8");
		Element number = document.getElementById("cert-number");
		number.text(value);
		
		helper.setText(document.toString(), true);
		
		sender.send(message);
		
		//db 기록 남기기
		certDao.delete(email);
		CertDto certDto=new CertDto();
		certDto.setCertEmail(email);
		certDto.setCertNumber(value);
		certDao.insert(certDto);
		return true;
	}
	//결제내역 메일 발송 기능
	public void sendPaymentDetails(String memberId, String memberEmail, List<OrderDetailDto> orderDetailList, List<OrdersDto> orderList) throws IOException, MessagingException {
	    // 이메일 템플릿 불러와서 정보 설정 후 발송
	    ClassPathResource resource = new ClassPathResource("templates/payment-details.html");
	    File target = resource.getFile();
	    Document document = Jsoup.parse(target);

	    // 회원 아이디 설정
	    Element memberIdWrapper = document.getElementById("member-id");
	    memberIdWrapper.text(memberId);

	    // 주문 내역을 HTML 테이블에 추가
	    Element orderDetailsWrapper = document.getElementById("order-details");
	    double totalPrice = 0.0;
	    for (OrderDetailDto order : orderDetailList) {
	        Element row = document.createElement("tr");

	        Element itemName = document.createElement("td");
	        itemName.text(order.getOrderDetailItemName());
	        row.appendChild(itemName);

	        Element itemPrice = document.createElement("td");
	        itemPrice.text(String.valueOf(order.getOrderDetailPrice()));
	        row.appendChild(itemPrice);

	        Element itemCount = document.createElement("td");
	        itemCount.text(String.valueOf(order.getOrderDetailCnt()));
	        row.appendChild(itemCount);

	        double itemTotalPrice = order.getOrderDetailPrice() * order.getOrderDetailCnt();
	        Element totalPriceElem = document.createElement("td");
	        totalPriceElem.text(String.valueOf(itemTotalPrice));
	        row.appendChild(totalPriceElem);

	        // 주문 내역 테이블에 추가
	        orderDetailsWrapper.appendChild(row);

	        totalPrice += itemTotalPrice;
	    }

	    // 총 결제 금액 설정
	    Element totalPriceWrapper = document.getElementById("total-price");
	    totalPriceWrapper.text(String.valueOf(totalPrice));

	    // 메세지 생성
	    MimeMessage message = sender.createMimeMessage();
	    MimeMessageHelper helper = new MimeMessageHelper(message, false, "UTF-8");
	    helper.setTo(memberEmail);
	    helper.setSubject("[일조쇼핑몰] 결제 내역 안내");
	    helper.setText(document.toString(), true);

	    // 전송
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
		certDao.delete(memberEmail);
		CertDto certDto=new CertDto();
		certDto.setCertEmail(memberEmail);
		certDto.setCertNumber(certNumber);
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
		helper.setSubject("[일조쇼핑몰]비밀번호 재설정 안내");
		helper.setText(document.toString(), true);
		
		//전송
		sender.send(message);
	}
}
