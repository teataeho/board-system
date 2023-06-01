package com.spring.yeoreobap.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class UserAuthHandler implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	throws Exception {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("login") == null) {		//로그인 아직
			response.sendRedirect(request.getContextPath() + "/user/userLogin");
			return false;
		}
		return true;
	}
}
