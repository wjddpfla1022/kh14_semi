package com.kh.oneTrillionCompany.interceptor;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.oneTrillionCompany.exception.TargetNotFoundException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class ManagerInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws IOException {
		
		HttpSession session = request.getSession();
		String createdLevel = (String)session.getAttribute("createdLevel");
		
		boolean isManager = createdLevel != null && createdLevel.equals("관리자");
		
		if(isManager) {
			return true;
		}
		else {
			response.sendRedirect("/member/login");
			return false;
		}
	}
}
