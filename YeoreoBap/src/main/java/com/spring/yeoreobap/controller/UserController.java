package com.spring.yeoreobap.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.party.service.IPartyService;
import com.spring.yeoreobap.review.service.IReviewService;
import com.spring.yeoreobap.user.service.IUserService;
import com.spring.yeoreobap.util.MailSenderService;
import com.spring.yeoreobap.util.PageCreator;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {

	@Autowired
	private IUserService service;

	@Autowired
	private IReviewService reviewService;

	@Autowired
	private IPartyService partyService;

	@Autowired
	private MailSenderService mailService;

	// 회원가입 페이지로 이동
	@GetMapping("/userJoin")
	public void userJoin() {
	}

	// 아이디 중복 확인(비동기)
	@ResponseBody
	@PostMapping("/idCheck")
	public String idCheck(@RequestBody String userId) {
		log.info("화면에서 전달된 값: " + userId);
		if (service.idCheck(userId) == 1)
			return "duplicated";
		else
			return "available";
	}

	// 이메일 인증
	@ResponseBody
	@GetMapping("/mailCheck")
	public String mailCheck(String email) {
		log.info("이메일 인증 요청: " + email);
		return mailService.joinEmail(email);
	}

	// 회원 가입 처리
	@PostMapping("/join")
	public String join(UserVO vo, RedirectAttributes ra) {
		log.info("userId : " + vo.getUserId());
		log.info("param: {}" + vo.toString());
		service.join(vo);
		ra.addFlashAttribute("msg", "joinSuccess");
		return "redirect:/user/userLogin";
	}

	
	//수정 요청
	@PostMapping("/userUpdate")
	public String updateUser(UserVO vo, Model model, HttpSession session, HttpServletRequest request) {
		service.updateUser(vo);		
		session.invalidate();
		HttpSession newSession = request.getSession(true);
		UserVO updateUser = service.login(vo.getUserId(), vo.getUserPw());
		newSession.setAttribute("user", updateUser);
		return "redirect:/";
	}
	
	//로그인 페이지로 이동 요청 	get
	@GetMapping("/userLogin")
	public String login(Model model, HttpSession session) {
		session.removeAttribute("user");
		return "user/userLogin";

	}

	// 로그인 요청
	@PostMapping("/userLogin")
	public void login(String userId, String userPw, Model model) {
		log.info("로그인요청 들어옴!");
		model.addAttribute("user", service.login(userId, userPw));
	}

	// 마이페이지 이동 요청
	@GetMapping("/userMypage")
	public void userMypage(HttpSession session, Model model, PageVO vo) {
		UserVO user = (UserVO) session.getAttribute("userInfo");
		String id = user.getUserId();
		vo.setLoginId(id);
		PageCreator pc = new PageCreator(vo, partyService.getTotal(vo));
		model.addAttribute("user", service.getInfo(id, vo));
		model.addAttribute("pc", pc);
		
	}

	// 로그아웃 요청
	@RequestMapping("/userLogout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		ModelAndView mv = new ModelAndView("redirect:/");
		return mv;
	}
}