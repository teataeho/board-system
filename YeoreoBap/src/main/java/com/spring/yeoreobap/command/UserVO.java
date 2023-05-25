package com.spring.yeoreobap.command;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UserVO {
	
	private String userId;
	private String userPw;
	private String userName;
	private String userPhone1;
	private String userPhone2;
	private String userEmail1;
	private String userEmail2;
	private String addrBasic;
	private String addrDetail;
	private String addrZipNum;
	private LocalDateTime regDate;
	
	/*
	 한 명의 회원은 글을 여러개 작성할 수 있다.
	 MyPage에서 특정 회원이 작성한 글 목록을 나타내야 한다.
	 회원 정보와 글 목록은 서로 다른 테이블로 이루어져 있다.
	 MyPage에선 해당 정보를 한 번의 DB연동으로 가져올 수 있도록 하기 위해
	 JOIN 문법으로 테이블 합친 뒤 원하는 컬럼을 선택해서 가져올 예정이다.
	 */
	
	//1이 UserVO 이기 때문에 UserVO 안에 N의 값을 뜻하는 
	//FreeBoardVO 객체의 모음을 저장할 수 있는 리스트 선언
	//1 : N 관계의 테이블을 list 형태로 선언
//	private List<FreeBoardVO> userBoardList;
}
