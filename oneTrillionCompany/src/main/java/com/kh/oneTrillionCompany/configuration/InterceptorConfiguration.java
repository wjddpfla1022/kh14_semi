package com.kh.oneTrillionCompany.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.oneTrillionCompany.interceptor.CartBuyerInterceptor;
import com.kh.oneTrillionCompany.interceptor.ManagerInterceptor;
import com.kh.oneTrillionCompany.interceptor.MemberInterceptor;
import com.kh.oneTrillionCompany.interceptor.TestInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {

	@Autowired
	private ManagerInterceptor managerInterceptor;
	
	@Autowired
	private MemberInterceptor memberInterceptor;
	
	@Autowired
	private CartBuyerInterceptor cartBuyerInterceptor;
	
	@Autowired
	private TestInterceptor testInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(testInterceptor).addPathPatterns("/item/**");
		//회원 권한 검사 인터셉터
		registry.addInterceptor(memberInterceptor)
						.addPathPatterns( //멤버권한 승인
								"/item/**" //상품 페이지
								
							)
						.excludePathPatterns( //멤버권한 차단
								"/manager/**", //관리자 페이지
								"/join/", //회원가입
								"/member/login/", //로그인 화면
								"/member/leaveFinish"
								
							);
		
		//관리자 검사 인터셉터 설정
		registry.addInterceptor(managerInterceptor)
						.addPathPatterns(
								"/manager/**" //모든 관리자 페이지
								
							)
						.excludePathPatterns(
								"/member/join*", //회원가입
								"/member/login", //로그인 화면
								"/member/leaveFinish"
							);
		
		//장바구니 주인 검사 인터셉터
		registry.addInterceptor(cartBuyerInterceptor)
						.addPathPatterns(
						"/cart/**"
				
				);
		
	}
}
