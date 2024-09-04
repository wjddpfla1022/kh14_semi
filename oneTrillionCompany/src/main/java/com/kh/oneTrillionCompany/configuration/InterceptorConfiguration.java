package com.kh.oneTrillionCompany.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.kh.oneTrillionCompany.interceptor.ManagerInterceptor;
import com.kh.oneTrillionCompany.interceptor.MemberInterceptor;

@Configuration
public class InterceptorConfiguration implements WebMvcConfigurer {

	@Autowired
	private ManagerInterceptor managerInterceptor;
	
	@Autowired
	private MemberInterceptor memberInterceptor;
//	
//	@Autowired
//	private CartBuyerInterceptor cartBuyerInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//회원 권한 검사 인터셉터
		registry.addInterceptor(memberInterceptor)
						.addPathPatterns( //멤버권한 승인
								"/cart/**",
								"/member/**",
								"/order/**",
								"/qna/**",
								"/refund/**",
								"/review/**"
							)
						.excludePathPatterns( //멤버권한 차단
								"/member/login*",
								"/member/join*",
								"/member/joinFinish*",
								"/member/findPw*",
								"/member/findPwFinish*",
								"/member/resetPw*",
								"/member/resetPwFinish*",
								"/member/leaveFinish*",
								"/member/block*",
								"/qna/detail*",
								"/qna/list*",
								"/review/detail*",
								"/review/list*",
								"/review/image*"
							);
		//관리자 검사 인터셉터 설정
		registry.addInterceptor(managerInterceptor)
						.addPathPatterns(
								"/item/insert*",
								"/manager/item/**",
								"/manager/member/**"
							)
						.excludePathPatterns(
								
								"/qna/update*"
							);
		
	}
}
