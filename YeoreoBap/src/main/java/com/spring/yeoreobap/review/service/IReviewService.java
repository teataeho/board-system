package com.spring.yeoreobap.review.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.FileVO;
import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.util.PageVO;

public interface IReviewService {

	//글 등록
	void regist(ReviewVO vo, List<MultipartFile> list);

	//글 목록
	List<ReviewVO> getList(PageVO vo);

	//총 게시물 수 구하기
	int getTotal(PageVO vo);

	//상세보기
	ReviewVO getArticle(int reviewNo);

	//수정
	void update(ReviewVO vo, List<MultipartFile> list, List<String> fileName);

	//삭제
	void delete(ReviewVO vo);
	
	//후기 등록시 파티만들었거나 혹은 파티 참가한 기록을 가지고 sno와 bplcNm을 리턴
//	List<PartyVO> getResList1(String userId);
//	List<PartyVO> getResList2(String userId);

	List<ReviewVO> getList2();
	
	//비밀번호 검증
	int checkPw(ReviewVO vo);

	//답글
	void registDab(ReviewVO vo, List<MultipartFile> list);

	//모든 게시글
	List<ReviewVO> getAllList();

	//게시글의 모든 파일 받아오기
	List<FileVO> getFiles(int reviewNo);
	
	//파일업로드
	void uploadFiles(List<MultipartFile> list);
	
	//파일수정업로드
	void uploadModifyFiles(List<MultipartFile> list, int reviewNo);
	
	//게시글의 전체 파일삭제
	void deleteFiles(int reviewNo);
	
	//파일 삭제
	void deleteFile(String fileName);

}