package com.kh.oneTrillionCompany.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.oneTrillionCompany.configuration.CustomCertProperties;
import com.kh.oneTrillionCompany.dao.CertDao;
import com.kh.oneTrillionCompany.dto.CertDto;
import com.kh.oneTrillionCompany.service.EmailService;

import jakarta.mail.MessagingException;


@RestController
@RequestMapping("/rest/cert")
public class CertRestController {
	@Autowired
	private EmailService emailService;
	@Autowired
	private CertDao certDao;
	@Autowired
	private CustomCertProperties customCertProperties;
	
	//사용자가 요구하는 이메일로 인증메일을 보내는 기능
	@PostMapping("/send")
	public void send(@RequestParam String certEmail) throws MessagingException {
		int size=6;
		emailService.sendCert(certEmail, size);
//		emailService.sendCert2(certEmail, size);
	}
	//사용자가 입력한 인증번호가 유효한지를 판정하는 기능
	@PostMapping("/check")
	public boolean check(@ModelAttribute CertDto certDto) {
		int duration = customCertProperties.getExpire();
		boolean result = certDao.check(certDto, duration);
		if(result) {
			
		}
		return result;
	}
}
