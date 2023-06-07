package com.spring.yeoreobap.party.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.yeoreobap.command.ParticipantsVO;
import com.spring.yeoreobap.command.PartyVO;
import com.spring.yeoreobap.party.mapper.IPartyMapper;
import com.spring.yeoreobap.util.PageVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PartyService implements IPartyService {

	@Autowired
	private IPartyMapper mapper;

	@Override
	public void register(PartyVO vo, MultipartFile file) {

		// 기본 경로는 C:/test/upload로 사용하겠습니다.
		String uploadPath = "C:/yeoreobap/upload/party";

		// 폴더 없으면 새롭게 생성해 주시라
		File folder = new File(uploadPath);
		if (!folder.exists())
			folder.mkdirs();

		// 저장될 파일명은 UUID를 이용한 파일명으로 저장합니다.
		// UUID가 제공하는 랜덤 문자열에 -을 제거해서 전부 사용하겠습니다.
		String fileRealName = file.getOriginalFilename();

		UUID uuid = UUID.randomUUID();
		String uuids = uuid.toString().replaceAll("-", "");

		// 확장자 추출.
		String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."));

		log.info("저장할 폴더 경로: " + uploadPath);
		log.info("실제 파일명: " + fileRealName);
		log.info("확장자: " + fileExtension);
		log.info("고유랜덤문자: " + uuids);
		String fileName = uuids + fileExtension;
		log.info("변경해서 저장할 파일명: " + fileName);

		// 업로드한 파일을 지정한 로컬 경로로 전송
		File saveFile = new File(uploadPath + "/" + fileName);
		try {
			file.transferTo(saveFile);
		} catch (Exception e) {
			e.printStackTrace();
		}

		vo.setUploadPath(uploadPath);
		vo.setFileName(fileName);
		mapper.regist(vo);
	}

	@Override
	public List<PartyVO> getList(PageVO paging) {
		System.out.println("머시기머시기2: " + mapper.getList(paging).toString());
		return mapper.getList(paging);
	}

	@Override
	public PartyVO getArticle(int partyNo, String userId) {
		return mapper.getArticle(partyNo, userId);
	}

	@Override
	public void update(PartyVO vo) {
		mapper.update(vo);
	}

	@Override
	public void delete(int partyNo) {
		mapper.delete(partyNo);
	}

	@Override
	public void attend(ParticipantsVO vo) {
		mapper.attend(vo);
	}

	@Override
	public void cancelAttend(ParticipantsVO vo) {
		mapper.cancelAttend(vo);		
	}

	@Override
	public int getTotal(PageVO vo) {
		return mapper.getTotal(vo);
	}

}