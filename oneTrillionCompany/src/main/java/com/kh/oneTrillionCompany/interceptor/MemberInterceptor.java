package com.kh.oneTrillionCompany.interceptor;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class MemberInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
		
		HttpSession session = request.getSession();
		String createdUser = (String)session.getAttribute("createdUser");
		
		boolean isLogin = createdUser != null;
		
		if(isLogin) {
			return true;
		}
		else {
			response.sendRedirect("/member/login");
			return false;
		}
	}
}
