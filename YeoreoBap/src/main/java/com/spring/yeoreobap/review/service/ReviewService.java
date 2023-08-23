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
import com.spring.yeoreobap.reviewReply.mapper.IReviewReplyMapper;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ReviewService implements IReviewService {

	@Autowired
	private IReviewMapper mapper;
	@Autowired
	private IReviewReplyMapper replyMapper;
	
	@Override
	public void regist(ReviewVO vo, List<MultipartFile> list) {	
		mapper.regist(vo);			
		if(list != null) uploadFiles(list);
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
	public void update(ReviewVO vo, List<MultipartFile> list, List<String> fileName) {
		if(list != null) uploadModifyFiles(list, vo.getReviewNo());
		if(fileName != null) {
			for(String name : fileName) {
				deleteFile(name);
			}
		}
		mapper.update(vo);		
	}

	@Override
	public void delete(ReviewVO vo) {
		deleteFiles(vo.getReviewNo());
		if(vo.getAnswerCnt() == 0 && vo.getStep() == 0) {
			mapper.delete(vo);
		}
		else mapper.hide(vo);
		replyMapper.deleteAll(vo.getReviewNo());
		
		//다 숨겨진건지 검증 후 전부 삭제
		if(mapper.getDeleteCondition(vo.getRef()) == 0) {
			mapper.deleteAllRef(vo.getRef());
		}
	}

	@Override
	public int checkPw(ReviewVO vo) {
		return mapper.checkPw(vo);
	}

	@Override
	public void registDab(ReviewVO vo, List<MultipartFile> list) {
		int maxRefOrder = mapper.findStep(vo);
		log.info("vo는 모야:" +vo);
		//중간에 들어갈 자리 찾기
		if(maxRefOrder == 0) {
			maxRefOrder = mapper.findMax(vo.getRef());
		} else {			
			//들어갈 자리 마련하기
			mapper.increaseRefOrder(vo.getRef(), maxRefOrder);
		}
		
		//답글등록
		ReviewVO result = new ReviewVO();
		result.setTitle(vo.getTitle());
		result.setPassword(vo.getPassword());
		result.setContent(vo.getContent());
		result.setWriter(vo.getWriter());
		result.setRef(vo.getRef());
		result.setStep(vo.getStep() + 1);
		result.setRefOrder(maxRefOrder);
		
		mapper.registDab(result);
		mapper.increaseAnswer(vo.getReviewNo());
		if(list != null) uploadFiles(list);
		
	}

	@Override
	public List<ReviewVO> getAllList() {
		return mapper.getAllList();
	}

	@Override
	public List<FileVO> getFiles(int reviewNo) {
		return mapper.getFiles(reviewNo);		
	}

	@Override
	public void uploadFiles(List<MultipartFile> list) {
		//기본 경로는 C:/test/upload로 사용하겠습니다.
		String uploadPath = "C:/Work/upload/";

		//폴더 없으면 새롭게 생성해 주시라
		File folder = new File(uploadPath);
		if(!folder.exists()) folder.mkdirs();

		int i = 0;
		while (i < list.size()) {
			if (list.get(i).isEmpty()) {
				list.remove(i);
			} else {
				i++;
			}
		}

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
			log.info("확장자: " + fileExtension);
			log.info("고유랜덤문자: " + uuids);
			String fileName = uuids + fileExtension;
			log.info("변경해서 저장할 파일명: " + fileName);

			//업로드한 파일을 지정한 로컬 경로로 전송
			File saveFile = new File(uploadPath + fileName);
			try {
				file.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			}

			FileVO fileVO = new FileVO();
			fileVO.setUploadPath(uploadPath);
			fileVO.setFileName(fileName);
			fileVO.setFileRealName(fileRealName);

			mapper.fileUpload(fileVO);
		}
		
	}

	@Override
	public void deleteFiles(int reviewNO) {
		List<FileVO> list = mapper.getFiles(reviewNO);
		if(list != null) {
			mapper.deleteFiles(reviewNO);
			for(FileVO vo : list) {
				File file = new File(vo.getUploadPath() + vo.getFileName());
				if(file.isFile()) file.delete();
			}
		}
	}

	@Override
	public void deleteFile(String fileName) {
		File file = new File("C:/Work/upload/" + fileName);
		if(file.isFile()) file.delete();
		mapper.deleteFile(fileName);
	}

	@Override
	public void uploadModifyFiles(List<MultipartFile> list, int reviewNo) {
		//기본 경로는 C:/test/upload로 사용하겠습니다.
				String uploadPath = "C:/Work/upload/";

				//폴더 없으면 새롭게 생성해 주시라
				File folder = new File(uploadPath);
				if(!folder.exists()) folder.mkdirs();

				int i = 0;
				while (i < list.size()) {
					if (list.get(i).isEmpty()) {
						list.remove(i);
					} else {
						i++;
					}
				}

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
					log.info("확장자: " + fileExtension);
					log.info("고유랜덤문자: " + uuids);
					String fileName = uuids + fileExtension;
					log.info("변경해서 저장할 파일명: " + fileName);

					//업로드한 파일을 지정한 로컬 경로로 전송
					File saveFile = new File(uploadPath + fileName);
					try {
						file.transferTo(saveFile);
					} catch (Exception e) {
						e.printStackTrace();
					}

					FileVO fileVO = new FileVO();
					fileVO.setReviewNo(reviewNo);
					fileVO.setUploadPath(uploadPath);
					fileVO.setFileName(fileName);
					fileVO.setFileRealName(fileRealName);

					mapper.fileModifyUpload(fileVO);
				}
		
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