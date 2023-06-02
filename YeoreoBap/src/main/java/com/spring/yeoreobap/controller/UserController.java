package com.spring.yeoreobap.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
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
	public String login(Model model, HttpSession session) {
		session.removeAttribute("user");
		return "user/userLogin";

	}

	// 로그인 요청 처리
	//		@PostMapping("/userLogin")
	//		public String login(String userId, String userPw, Model model, HttpSession session) {
	//		    UserVO user = service.login(userId, userPw);
	//		    if (user != null) {
	//		        // 로그인 성공 시 세션에 사용자 정보를 저장
	//		        model.addAttribute("user", user);
	//		        return "redirect:/"; // 메인 화면으로 리다이렉트
	//		    } else {
	//		        model.addAttribute("msg", "loginFail");
	//		        return "user/userLogin"; // 로그인 실패 시 로그인 페이지로 이동
	//		    }
	//		}

	// 로그인 요청 처리
    @PostMapping("/userLogin")
    public String login(String userId, String userPw, Model model) {
        log.info("나는 userController의 login");
        String result = service.login(userId, userPw);
        if (result.equals("success")) {
            return "redirect:/";
        } else {
            model.addAttribute("msg", "loginFail");
            return "user/userLogin";
        }
    }
	//		model.addAttribute("user", service.login(userId, userPw));
	//		if(user != null) {
	//			HttpSession session = request.getSession();
	//			if(session != null) {
	//				String sessionId = session.getId();
	//				Object attribute = session.getAttribute("user");
	//				if(attribute != null) {
	//					UserVO sessionUser = (UserVO) attribute;
	//					log.info("세션id: " + sessionId);
	//					log.info("유지되는 사용자: " + sessionUser);
	//				}
	//			}
	//			return "redirect:/";
	//		} else {
	//			model.addAttribute("msg", "loginFail");
	//		return "user/userLogin";
	//		}
	//	}

	//마이페이지 이동 요청
	@GetMapping("/userMypage")
	public void userMypage(HttpSession session, Model model, PageVO vo) {
		String id = (String) session.getAttribute("login");
		vo.setLoginId(id);		
		PageCreator pc = new PageCreator(vo, reviewService.getTotal(vo));
		model.addAttribute("userInfo", service.getInfo(id, vo));
		model.addAttribute("pc", pc);
	}

}