package com.spring.yeoreobap.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.ParticipantsVO;
import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.party.service.IPartyService;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/party")
@Slf4j
public class PartyController {

	@Autowired
	private IPartyService service;

	// 카카오맵으로 이동
	@GetMapping("/map")
	public void map() {}
	
	@GetMapping("/partyList")
	public void partyList() {}

	//글목록 가져오기
	@ResponseBody
	@GetMapping("/partyList/{page}")
	public List<PartyVO> partyList(@PathVariable int page) {
		System.out.println(page);
		PageVO vo = new PageVO();
		vo.setPageNum(page);
		vo.setCpp(10);		
		
		return service.getList(vo);
	}
	
	@GetMapping("/partyRegister")
	public void regist() {}
	
	@PostMapping("/partyRegister")
	public String register(PartyVO vo, MultipartFile file) {
		//파일이 안들어왔을 때 어떻게 나오는지 확인
		service.regist(vo, file);
		return "redirect:/party/partyList";
	}

	@ResponseBody
	@GetMapping("/content/{partyNo}/{uid}")
	public PartyVO getArticle(@PathVariable int partyNo, @PathVariable("uid") String userId) {
		return service.getArticle(partyNo, userId);
	}

	@PostMapping("/delete")
	public String delete(int partyNo) {
		service.delete(partyNo);
		return "redirect:/party/partyList";
	}

	// 참가시 유저아이디와 글번호를 모두 가져와야함 가져오는 방식은 미정
	@ResponseBody
	@PostMapping("/attend")
	public String attend(@RequestBody ParticipantsVO vo) {
		service.attend(vo);
		return "success";
	}
	
	@ResponseBody
	@DeleteMapping("/cancelAttend")
	public String cancelAttend(@RequestBody ParticipantsVO vo) {
		service.cancelAttend(vo);
		return "success";
	}
	
	//이미지 파일 전송
	@GetMapping("/getImg/{fileName}")
	public ResponseEntity<byte[]> getFile(@PathVariable String fileName) {
		
		log.info("filename: " + fileName);
		
		File file = new File("C:/yeoreobap/upload/party/" + fileName);
		log.info(file.toString());
		
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			headers.add("Content_Type", Files.probeContentType(file.toPath()));
			headers.add("merong", "hello");
			
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
			result = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return result;
	}

}