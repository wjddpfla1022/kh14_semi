package com.kh.oneTrillionCompany.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class TestInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
														Object handler) {
		
		String memberId = request.getParameter("memberId");
		String memberLevel = request.getParameter("memberLevel");
		HttpSession session = request.getSession();
		String createdUser = (String)session.getAttribute("createdUser");
		String createdLevel = (String)session.getAttribute("createdLevel");
		System.out.println("테스트 인터셉터");
		System.out.println("memberId = " + memberId);
		System.out.println("memberLevel = " + memberLevel);
		System.out.println("createdUser = " + createdUser);
		System.out.println("createdLevel = " + createdLevel);
		return true;
	}
	@Override
	public void postHandle(
			HttpServletRequest request, //요청 객체
			HttpServletResponse response, //응답 객체
			Object handler, //매핑정보
			ModelAndView modelAndView //화면(View)과 모델의 정보
			) throws Exception {
			System.out.println(handler);
			System.out.println(modelAndView);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler, 
			Exception ex
			) throws Exception {
		System.out.println("<afterCompletion>");
		System.out.println("ex = " + ex);
	}
}
