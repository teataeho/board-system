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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.party.service.IPartyService;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/party")
public class PartyController {

	@Autowired
	private IPartyService service;

	// 카카오맵으로 이동
	@GetMapping("/map")
	public void map() {
	}

	// 여러밥 모집 페이지로 이동
	@GetMapping("/partyList")
	public void partyList() {
	}

	// 글 목록 가져오기
	@ResponseBody
	@GetMapping("/{page}")
	public List<PartyVO> partyList(@PathVariable int page) {
		System.out.println(page);
		PageVO vo = new PageVO();
		vo.setPageNum(page);
		vo.setCpp(10);

		return service.getList(vo);
	}

	// 여러밥 모집글 작성 페이지 이동
	@GetMapping("/partyRegister")
	public void register() {
	}

	// 여러밥 모집글 등록 (예시 사진)
	@PostMapping("/partyRegister")
	public String register(PartyVO vo) {
		service.register(vo);
		return "redirect:/party/partyList";
	}

	// 여러밥 모집글 등록 (사용자 지정 사진)
	@PostMapping("/partyRegister")
	public String register(PartyVO vo, MultipartFile file) {
		service.register(vo, file);
		return "redirect:/party/partyList";
	}

	@GetMapping("/content/{bno}")
	public String partyContent(@PathVariable int partyNo, @ModelAttribute("p") PageVO paging, Model model) {
		model.addAttribute("article", service.getArticle(partyNo));
		return "party/partyDetail";
	}

	// 글 수정 페이지 이동 처리
	@PostMapping("/modify")
	public String modify(@ModelAttribute("article") PartyVO vo) {
		return "party/partyModify";
	}

	// 글 수정 처리
	@PostMapping("/update")
	public String update(PartyVO vo) {
		service.update(vo);
		return "redirect:/party/content/" + vo.getPartyNo();
	}

	@PostMapping("/delete")
	public String delete(int partyNo) {
		service.delete(partyNo);
		return "redirect:/party/partyList";
	}

	// 참가시 유저아이디와 글번호를 모두 가져와야함 가져오는 방식은 미정
	@ResponseBody
	@PostMapping("/attend")
	public void attend(String userId, int partyNo) {
		service.attend(userId, partyNo);
	}

	// 이미지 파일 전송
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