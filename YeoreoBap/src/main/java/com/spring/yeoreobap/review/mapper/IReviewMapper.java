package com.spring.yeoreobap.review.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.util.PageVO;
@Mapper
public interface IReviewMapper {

	//글 등록
	void regist(ReviewVO vo);

	//글 목록
	List<ReviewVO> getList(PageVO vo);

	//총 게시물 수 구하기
	int getTotal();

	//상세보기
	ReviewVO getContent(int reviewNo);

	//수정
	void update(ReviewVO vo);

	//삭제
	void delete(int reviewNo);

	//파일업로드
	void upload(int reviewNo, MultipartFile file);

	List<PartyVO> getResList1(String userId);
	List<PartyVO> getResList2(String userId);
}