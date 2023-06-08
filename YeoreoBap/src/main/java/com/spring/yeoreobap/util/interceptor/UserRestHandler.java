package com.spring.yeoreobap.util.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.AsyncHandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.spring.yeoreobap.command.UserVO;

import lombok.extern.slf4j.Slf4j;

public class UserRestHandler implements AsyncHandlerInterceptor {

  @Override
  public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
      throws Exception {

    HttpSession session = request.getSession();
    if (session.getAttribute("userInfo") == null) {
      response.setContentType("text/html; charset=UTF-8");
      PrintWriter out = response.getWriter();
      out.println("<script>alert('로그인이 필요한 서비스입니다. :)');"
          + "location.href = '/yeoreobap/user/userLogin'</script>");
      out.flush();
    }
  }

}
