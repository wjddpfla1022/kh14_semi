package com.kh.oneTrillionCompany.interceptor;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.oneTrillionCompany.dao.CartDao;
import com.kh.oneTrillionCompany.dto.CartDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class CartBuyerInterceptor implements HandlerInterceptor {

	@Autowired
	private CartDao cartDao;
	
	public boolean perHandle(HttpServletRequest request, HttpServletResponse response, Object handler 
													) throws IOException {
		HttpSession session = request.getSession();
		
		String createdUser = (String)session.getAttribute("createdUser");
		
		if(createdUser == null) {
			response.sendError(401);
			return false;
		}
		
		String cartBuyer = request.getParameter("cartBuyer");
		
		CartDto cartDto = cartDao.selectOne(cartBuyer);
		boolean isBuyer = createdUser.equals(cartDto.getCartBuyer());
		
		if(isBuyer) {
			return true;
		}
		else {
			response.sendError(403);
			return false;
		}
		
	}
}
