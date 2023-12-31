package com.spring.yeoreobap.controller;

import java.io.File;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.review.service.IReviewService;
import com.spring.yeoreobap.util.PageCreator;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/review")
@Slf4j
public class ReviewController {

	@Autowired
	private IReviewService service;
	
	//후기게시판에 후기리스트를 불러오기
	@GetMapping("/reviewList")
	public void reviewList(PageVO vo, Model model) {
		PageCreator pc = new PageCreator(vo, service.getTotal(vo));
		log.info("getTotal : " + service.getTotal(vo));
		System.out.println("store: " + pc.toString());
		log.info(pc.toString());
		
		model.addAttribute("reviewList",service.getList(vo));
		model.addAttribute("pc", pc);
	}
	
	//메인화면에 후기리스트 일부 불러오기
	@GetMapping("/reviewList2")
	public void reviewList2(Model model) {
		model.addAttribute("reviewList",service.getList2());
	}
	
	//후기등록화면으로 보내기
	@GetMapping("/reviewRegist")
	public void regist() {
		
//		String userId = ((UserVO) session.getAttribute("userInfo")).getUserId();
//		
//		model.addAttribute("party" ,service.getResList1(userId));
//		model.addAttribute("attendedParty" ,service.getResList2(userId));
	}
	
	//답글에 필요한 컬럼을 추가해서 후기등록화면으로 보내기
	@PostMapping("/reviewRegistDab")
	public void registDap(ReviewVO vo, Model model) {
		model.addAttribute("dab", vo);
	}
	
	//후기등록하기
	@PostMapping("/regist")
	public String regist(ReviewVO vo, @RequestParam(value="file",required = false) List<MultipartFile> list) {
		service.regist(vo, list);
		return "redirect:/review/reviewList";
	}
	
	//후기상세보기
	@GetMapping("/content/{reviewNo}")
	public String getContent(@PathVariable int reviewNo, @ModelAttribute("p") PageVO vo
			, Model model) {
		model.addAttribute("article", service.getArticle(reviewNo));
		model.addAttribute("fileList", service.getFiles(reviewNo));
		return "review/reviewDetail";
	}
	
	//후기수정화면으로 보내기
	@PostMapping("/modify")
	public String modify(ReviewVO vo, Model model) {
		log.info(vo.toString());
		model.addAttribute("article", service.getArticle(vo.getReviewNo()));
		model.addAttribute("fileList", service.getFiles(vo.getReviewNo()));
		return "review/reviewModify";
	}
	
	//후기수정하기
	@PostMapping("/update")
	public String update(ReviewVO vo
			, @RequestParam(value="file",required = false) List<MultipartFile> list
			, @RequestParam(value = "fileName", required = false) List<String> fileName) {
		service.update(vo, list, fileName);
		return "redirect:/review/content/" + vo.getReviewNo();
	}
	
	//후기삭제
	@PostMapping("/delete")
	public String delete(@ModelAttribute("article") ReviewVO vo) {
		service.delete(vo);
		return "redirect:/review/reviewList";
	}
	
	@ResponseBody
	@PostMapping("/checkPw")
	public int checkPw(@RequestBody ReviewVO vo) {
		log.info("checkPw : " + vo);
		return service.checkPw(vo);
	}
	
	//답글쓰기
	@PostMapping("/registDab")
	public String registDab(ReviewVO vo, @RequestParam(value="file",required = false) List<MultipartFile> list) {
		service.registDab(vo, list);
		return "redirect:/review/reviewList";
	}
	
	//엑셀 다운로드
	@GetMapping("/downloadExcel")
	public void downloadExcel(HttpServletResponse response) throws IOException {
		
		Workbook workbook = new HSSFWorkbook();
		Sheet sheet = workbook.createSheet("reviewList");
		int rowNo = 0;
		
		Row headerRow = sheet.createRow(rowNo++);
        headerRow.createCell(0).setCellValue("번호");
        headerRow.createCell(1).setCellValue("제목");
        headerRow.createCell(2).setCellValue("작성자");
        headerRow.createCell(4).setCellValue("등록일");
        
		List<ReviewVO> list = service.getAllList();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		
		for(ReviewVO vo : list) {
			if(vo.getHidden() == 0) {
				Row row = sheet.createRow(rowNo++);
				row.createCell(0).setCellValue(vo.getRef());
	            row.createCell(1).setCellValue(vo.getTitle());
	            row.createCell(2).setCellValue(vo.getWriter());
	            row.createCell(4).setCellValue(vo.getRegDate().format(formatter));
			}
		}
		
		response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=reviewlist.xls");
 
        workbook.write(response.getOutputStream());
        workbook.close();
	}
	
	//현재 페이지 엑셀 다운로드
	@ResponseBody
	@PostMapping("/downloadExcel")
	public void download(HttpServletResponse response, @RequestBody List<ReviewVO> reviewList) throws IOException {
			
		log.info("리뷰리스트 다운받을건데 들어오나???:" + reviewList.toString());
		
		Workbook workbook = new HSSFWorkbook();
		Sheet sheet = workbook.createSheet("reviewList");
		int rowNo = 0;
			
		Row headerRow = sheet.createRow(rowNo++);
        headerRow.createCell(0).setCellValue("번호");
        headerRow.createCell(1).setCellValue("제목");
        headerRow.createCell(2).setCellValue("작성자");
        headerRow.createCell(4).setCellValue("등록일");
	        
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			
		for(ReviewVO vo : reviewList) {
			if(vo.getHidden() == 0) {
				Row row = sheet.createRow(rowNo++);
				row.createCell(0).setCellValue(vo.getRef());
	            row.createCell(1).setCellValue(vo.getTitle());
	            row.createCell(2).setCellValue(vo.getWriter());
	            row.createCell(4).setCellValue(vo.getRegDate().format(formatter));
			}
		}
			
		response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=reviewlist.xls");
	 
        workbook.write(response.getOutputStream());
        workbook.close();
	}
	
	//파일 다운로드
	@GetMapping("/download/{fileName}")
	public ResponseEntity<FileSystemResource> fileDownload(@PathVariable String fileName) {
		File file = new File("C:/Work/upload/" + fileName);
		
		if(file.exists()) {
			HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + fileName);
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

            FileSystemResource resource = new FileSystemResource(file);
            return new ResponseEntity<>(resource, headers, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}
	
}