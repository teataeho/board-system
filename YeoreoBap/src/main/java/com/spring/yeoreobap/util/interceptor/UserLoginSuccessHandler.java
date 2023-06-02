package com.spring.yeoreobap.util.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.spring.yeoreobap.command.UserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UserLoginSuccessHandler implements HandlerInterceptor{
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler
			, ModelAndView modelAndView) throws Exception {
		log.info("로그인 인터셉터!!");
		log.info("요청 방식: " + request.getMethod());
		
		if(request.getMethod().equals("POST")) {
			ModelMap map = modelAndView.getModelMap();
			UserVO vo = (UserVO) map.get("user");
			
			if(vo != null) {
				log.info("login Success");
				HttpSession session = request.getSession();
				session.setAttribute("userInfo", vo);
				response.sendRedirect(request.getContextPath() + "/");
			} else {
				modelAndView.addObject("msg", "loginFail");
			}
		}
	}
	
	
}