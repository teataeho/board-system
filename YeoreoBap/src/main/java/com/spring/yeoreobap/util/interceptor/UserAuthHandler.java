package com.spring.yeoreobap.util.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class UserAuthHandler implements HandlerInterceptor{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	throws Exception {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("userInfo") == null) {		//로그인 아직
//			response.sendRedirect(request.getContextPath() + "/user/userLogin");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인이 필요한 서비스입니다.');"
					+ "location.href = '/yeoreobap/user/userLogin'</script>");
			out.flush(); 
			return false;
		}
		return true;
	}
}