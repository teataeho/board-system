package com.spring.yeoreobap.review.service;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.FileVO;
import com.spring.yeoreobap.command.ReviewVO;
import com.spring.yeoreobap.review.mapper.IReviewMapper;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReviewService implements IReviewService {

	@Autowired
	private IReviewMapper mapper;
	
	@Override
	public void regist(ReviewVO vo, List<MultipartFile> list) {	
		mapper.regist(vo);
		
		//날짜별로 폴더를 생성해서 관리할 예정입니다.
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		String fileLoca = now.format(dtf);
				
		//기본 경로는 C:/test/upload로 사용하겠습니다.
		String uploadPath = "C:/Work/upload/";
			
		//폴더 없으면 새롭게 생성해 주시라
		File folder = new File(uploadPath + fileLoca);
		if(!folder.exists()) folder.mkdirs();
		
		log.info("과연 들어온 List의 값들은???? -> " + list.toString());
		
		int i = 0;
        while (i < list.size()) {
            if (list.get(i).isEmpty()) {
                list.remove(i);
            } else {
                i++;
            }
        }
        
        log.info("과연 들어온 List의 값들은???? -> " + list.toString());
		
		for(MultipartFile file : list) {
			//저장될 파일명은 UUID를 이용한 파일명으로 저장합니다.
			//UUID가 제공하는 랜덤 문자열에 -을 제거해서 전부 사용하겠습니다.
			String fileRealName = file.getOriginalFilename();
			
			UUID uuid = UUID.randomUUID();
			String uuids = uuid.toString().replaceAll("-", "");
			
			//확장자 추출.
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."));
			
			log.info("저장할 폴더 경로: " + uploadPath);
			log.info("실제 파일명: " + fileRealName);
			log.info("폴더명: " + fileLoca);
			log.info("확장자: " + fileExtension);
			log.info("고유랜덤문자: " + uuids);
			String fileName = uuids + fileExtension;
			log.info("변경해서 저장할 파일명: " + fileName);
			
			//업로드한 파일을 지정한 로컬 경로로 전송
			File saveFile = new File(uploadPath + fileLoca + "/" + fileName);
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			FileVO fileVO = new FileVO();
			fileVO.setUploadPath(uploadPath);
			fileVO.setFileLoca(fileLoca);
			fileVO.setFileName(fileName);
			fileVO.setFileRealName(fileRealName);
			
			mapper.fileUpload(fileVO);
		}		
		
	}

	@Override
	public List<ReviewVO> getList(PageVO vo) {
		return mapper.getList(vo);
	}
	@Override
	public List<ReviewVO> getList2() {
		return mapper.getList2();
	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}

	@Override
	public ReviewVO getArticle(int reviewNo) {
		return mapper.getContent(reviewNo);
	}

	@Override
	public void update(ReviewVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(ReviewVO vo) {
		if(vo.getAnswerCnt() == 0 && vo.getStep() == 0) mapper.delete(vo);			
		else mapper.hide(vo);
	}

	@Override
	public int checkPw(ReviewVO vo) {
		return mapper.checkPw(vo);
	}

	@Override
	public void registDab(ReviewVO vo) {
		int maxRefOrder;
		log.info("vo는 모야:" +vo);
		//중간에 들어갈 자리 찾기
		if(vo.getAnswerCnt() == 0) {
			maxRefOrder = vo.getRefOrder();
		} else {
			ReviewVO tmp = mapper.findStep(vo);
			maxRefOrder = tmp.getRefOrder() +tmp.getAnswerCnt();
		}
		
		//들어갈 자리 마련하기
		mapper.increaseRefOrder(vo.getRef(), maxRefOrder);
		
		//부모글의 답변수 증가
		mapper.increaseAnswer(vo.getParentNo());
		
		//답글등록
		ReviewVO result = new ReviewVO();
		result.setTitle(vo.getTitle());
		result.setPassword(vo.getPassword());
		result.setContent(vo.getContent());
		result.setWriter(vo.getWriter());
		result.setRef(vo.getRef());
		result.setStep(vo.getStep() + 1);
		result.setRefOrder(maxRefOrder + 1);
		result.setParentNo(vo.getParentNo());
		
		mapper.registDap(result);		
		
	}

	@Override
	public List<ReviewVO> getAllList() {
		return mapper.getAllList();
	}

	@Override
	public List<FileVO> getFiles(int reviewNo) {
		return mapper.getFiles(reviewNo);		
	}

//	@Override
//	public List<PartyVO> getResList1(String userId) {
//		return mapper.getResList1(userId);
//	}
//	
//	@Override
//	public List<PartyVO> getResList2(String userId) {
//		return mapper.getResList2(userId);
//	}
}