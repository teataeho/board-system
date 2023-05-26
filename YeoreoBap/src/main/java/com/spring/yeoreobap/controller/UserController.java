package com.spring.yeoreobap.controller;

import javax.mail.Session;
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
import com.spring.yeoreobap.service.IFreeBoardService;
import com.spring.yeoreobap.user.service.IUserService;
//import com.spring.yeoreobap.freeboard.service.IFreeBoardService;
//import com.spring.yeoreobap.user.service.IUserService;
//import com.spring.yeoreobap.util.MailSenderService;
//import com.spring.yeoreobap.util.PageCreator;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/user")
@Slf4j
public class UserController {

	@Autowired
	private IUserService service;
	
	@Autowired
	private IFreeBoardService boardService;

//	@Autowired
//	private MailSenderService mailService;

	//ȸ������ �������� �̵�
	@GetMapping("/userJoin")
	public void userJoin() {}

	//ȸ�� ���� ó��
	@PostMapping("/join")
	public String join(UserVO vo, RedirectAttributes ra) {
		log.info("param: {}" + vo.toString());
		service.join(vo);
		ra.addFlashAttribute("msg", "joinSuccess");
		return "redirect:/user/userLogin";
	}
	
	//���̵� �ߺ� Ȯ��(�񵿱�)
	@ResponseBody
	@PostMapping("/idCheck")
	public String idCheck(@RequestBody String userId) {
		log.info("ȭ�鿡�� ���޵� ��: " + userId);
		int result = service.idCheck(userId);
		if(result == 1) return "duplicated";
		else return "available";
	}

	//�̸��� ����
//	@GetMapping("/mailCheck")
//	@ResponseBody
//	public String mailCheck(String email) {
//		log.info("�̸��� ���� ��û: " + email);
//		return mailService.joinEmail(email);
//	}
	
	//�α��� �������� �̵� ��û
	@GetMapping("/userLogin")
	public void login() {}
	
	//�α��� ��û
	@PostMapping("/userLogin")
	public void login(String userId, String userPw, Model model) {
		log.info("���� userController�� login");
		model.addAttribute("user", service.login(userId, userPw));
	}
	
	//���������� �̵� ��û
//	@GetMapping("/userMypage")
//	public void userMypage(HttpSession session, Model model, PageVO vo) {
//		String id = (String) session.getAttribute("login");
//		vo.setLoginId(id);		
//		PageCreator pc = new PageCreator(vo, boardService.getTotal(vo));
//		model.addAttribute("userInfo", service.getInfo(id, vo));
//		model.addAttribute("pc", pc);
//	}
	
}
