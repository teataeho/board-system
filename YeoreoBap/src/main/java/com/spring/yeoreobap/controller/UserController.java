package com.spring.yeoreobap.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.yeoreobap.command.UserVO;
import com.spring.yeoreobap.user.service.IUserService;
import com.spring.yeoreobap.util.MailSenderService;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {

	@Autowired
	private IUserService service;

	//	@Autowired
	//	private IBoardService boardService;

	@Autowired
	private MailSenderService mailService;

	//	@Autowired
	//	public UserController(IUserService service, IBoardService boardService,
	//			MailSenderService mailSenderService) {
	//		this.service = service;
	//		this.boardService = boardService;
	//		this.mailService = mailSenderService;
	//	}
	//회원가입 페이지로 이동
	@GetMapping("/userJoin")
	public void userJoin() {}

	//아이디 중복 확인(비동기)
	@ResponseBody
	@PostMapping("/idCheck")
	public String idCheck(@RequestBody String userId) {
		log.info("화면에서 전달된 값: " + userId);
		int result = service.idCheck(userId);
		if(result == 1) return "duplicated";
		else return "available";
	}

	//이메일 인증
	@GetMapping("/mailCheck")
	@ResponseBody
	public String mailCheck(String email) {
		log.info("이메일 인증 요청: " + email);
		return mailService.joinEmail(email);
	}

	//회원 가입 처리
	@PostMapping("/join")
	public String join(UserVO vo, RedirectAttributes ra) {
		log.info("param: {}" + vo.toString());
		service.join(vo);
		ra.addFlashAttribute("msg", "joinSuccess");
		return "redirect:/user/userLogin";
	}


	//로그인 페이지로 이동 요청 	get
	@GetMapping("/userLogin")
	public void login() {}

	//로그인 요청	post
	@PostMapping("/userLogin")
	public void login(String userId, String userPw, Model model) {
		log.info("나는 userController의 login");
		model.addAttribute("user", service.login(userId, userPw));
	}

	//마이페이지 이동 요청
	@GetMapping("/userMypage")
	public void userMypage(HttpSession session, Model model, PageVO vo) {
		String id = (String) session.getAttribute("login");
		//		vo.setLoginId(id);		
		//		PageCreator pc = new PageCreator(vo, boardService.getTotal(vo));
		//		model.addAttribute("userInfo", service.getInfo(id, vo));
		//		model.addAttribute("pc", pc);
	}

}
