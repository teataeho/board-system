﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp"%>
<br>
<br>
<br>
<br>
<section>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-9 write-wrap">
				<div class="titlebox">
					<p>상세보기</p>
				</div>

				<form action="${pageContext.request.contextPath}/review/modify"
					method="post" name="form">

					<div>
						<label>DATE</label>
						<c:if test="${article.updateDate == null}">
							<p>
								<fmt:parseDate value="${article.regDate}"
									pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime"
									type="both" />
								<fmt:formatDate value="${parsedDateTime}"
									pattern="yyyy.MM.dd. HH:mm 등록" />

							</p>
						</c:if>
						<c:if test="${article.updateDate != null}">
							<p>
								<fmt:parseDate value="${article.updateDate}"
									pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime"
									type="both" />
								<fmt:formatDate value="${parsedDateTime}"
									pattern="yyyy년 MM월 dd일 HH시 mm분" />

							</p>
						</c:if>
					</div>


					<div class="form-group">
						<label>후기 번호</label> <input id="reviewNo" class="form-control"
							name="reviewNo" value="${article.reviewNo}" readonly>
					</div>
					<div class="form-group">
						<label>작성자</label> <input class="form-control" name="writer"
							value="${article.writer}" readonly>
					</div>
					<div class="form-group">
						<label>제목</label> <input class="form-control" name="title"
							value="${article.title}" readonly>
					</div>

					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" name="content" readonly>${article.content}</textarea>
					</div>


					<button type="submit" class="btn"
						onclick="return confirm('수정 페이지로 이동합니다.')">수정</button>
					<button type="button" class="btn"
						onclick="location.href='${pageContext.request.contextPath}/review/reviewList?pageNum=${p.pageNum}&cpp=${p.cpp}&keyword=${p.keyword}&condition=${p.condition}'">목록</button>
					<!--    목록 누르면 화면 페이지 유지하기    -->
					<button type="button" id="delBtn" class="btn">삭제</button>

				</form>
			</div>
		</div>
	</div>
</section>

<!-- 댓글 영역 시작 -->
<section style="margin-top: 80px;">
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-9 write-wrap">
				<form class="reply-wrap">
					<!--form-control은 부트스트랩의 클래스입니다-->
					<div class="reply-content">

						<div class="reply-group">
							<div class="reply-input">
								<input type="text" class="form-control" id="replyId"
									value="${userInfo.userNick}" readonly>
							</div>
							<textarea class="form-control" rows="3" id="reply"
								placeholder="댓글을 입력해주세요"></textarea>
							<button type="button" id="replyRegist" class="right btn btn-info">등록하기</button>
						</div>

					</div>
				</form>

				<!--여기에 접근 반복-->
				<div id="replyList">댓글리스트가여기나와야하는데말이지</div>
				<button type="button" class="form-control" id="moreList"
					style="display: block;">더보기(페이징)</button>
			</div>
		</div>
	</div>
</section>

<!-- 모달 -->
<div class="modal fade" id="replyModal" role="dialog">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="btn btn-default pull-right"
					data-dismiss="modal">닫기</button>
			</div>
			<div class="modal-body">
				
				<div class="reply-content">
					
					
						<button class="right btn btn-info" id="modalDelBtn">삭제하기</button>
			
				</div>
			
			</div>
		</div>
	</div>
</div>


<br><br><br><br><br><br><br><br><br><br><br><br>

<%@ include file="../include/footer.jsp"%>

<script>

const $form = document.form;
document.getElementById('delBtn').onclick = () => {
    if (confirm('정말 삭제하시겠습니까?')) {
        $form.setAttribute('action', '${pageContext.request.contextPath}/review/delete');
        $form.submit();
    }
}


						window.onload = function () {
							document.getElementById('replyRegist').onclick = () => {
								const reviewNo = document.getElementById('reviewNo').value //현재 게시글 번호
								const reply = document.getElementById('reply').value;
								const replyId = document.getElementById('replyId').value;

								if(reply === '') {
									alert('내용을 입력해주세요.');
									return;
								}
								//요청에 관련된 정보 객체
								const reqObj = {
									method: 'post',
									headers: {
										'Content-Type': 'application/json'
									},
									body: JSON.stringify({
										'reviewNo': reviewNo,
										'reply': reply,
										'replyId': replyId,
									})
								};

								fetch('${pageContext.request.contextPath}/reply/regist', reqObj)
									.then(res => res.text())
									.then(data => {
										console.log('통신 성공!: ' + data);
										document.getElementById('reply').value = '';
										
										//등록 완료 후 댓글 목록 함수를 호출해서 비동기식으로 목록 표현
										getList(1, true);
							
									});

							}   //댓글 등록 이벤트 끝

						
							document.getElementById('moreList').onclick = () => {
								
								getList(++page, false);
							}


							let page = 1;   
							let strAdd = '';   
							const $replyList = document.getElementById('replyList');

							
							getList(1, true);

							function getList(pageNum, reset) {
								strAdd = '';
								const reviewNo = '${article.reviewNo}'; //게시글 번호

								//get방식으로 댓글 목록을 요청(비동기)
								fetch('${pageContext.request.contextPath}/reply/getList/' + reviewNo + '/' + pageNum)
									.then(res => res.json())
									.then(data => {
										console.log(data);

										let total = data.total; //총 댓글 수
										let replyList = data.list;  //후기 리스트

										
										if (reset) {
											while ($replyList.firstChild) {
												$replyList.firstChild.remove();
											}
											page = 1;
										}

										//응답 데이터의 길이가 0과 같거나 더 작으면 함수를 종료
										if (replyList.length <= 0) return;

										//페이지번호 * 이번 요청으로 받은 댓글 수보다 전체 댓글 개수가 적다면 더보기 버튼 없어도 된다.
										console.log('현재 페이지: ' + page);
										if (total <= page * 5) {
											document.getElementById('moreList').style.display = 'none';
										} else {
											document.getElementById('moreList').style.display = 'block';
										}

										for (let i = 0; i < replyList.length; i++) {
											strAdd += `
												<div class='reply-wrap'>
                       
                        <div class='reply-content'>
                            <div class='reply-group'>
                                <strong class='left'>` + replyList[i].replyId + `</strong> 
                                
                                <a href='` + replyList[i].replyNo + `' class='right replyDelete'><span class='glyphicon glyphicon-remove'></span>삭제</a>
                                
                            </div>
                            <p class='clearfix'>` + replyList[i].reply + `</p>
                        </div>
                    </div>`;
										}

										//id가 reviewList라는 div 영역에 문자열 형식으로 모든 댓글을 추가.
										if (!reset) {
											document.getElementById('replyList').insertAdjacentHTML('beforeend', strAdd);
										} else {                                                     
											document.getElementById('replyList').insertAdjacentHTML('afterbegin', strAdd);
										}                                                           

									});
							}   //end getList(); 




							//삭제
							




							 document.getElementById('replyList').addEventListener('click', function(e){
									e.preventDefault(); //태그의 고유 기능을 중지
								  
									//1. 이벤트가 발생한 target이 a태그가 아니라면 이벤트 종료
									if (!e.target.matches('a')) {
											return;
									}
					
									//2. a태그가 두개(수정, 삭제)이므로 어떤 링크인지를 확인
									//댓글 여러개 -> 수정,삭제가 발생하는 댓글이 몇 번인지도 확인
									const rno = e.target.getAttribute('href');
									console.log('댓글 번호: ' + replyNo);
									document.getElementById('modalReplyNo').value = ReplyNo;
									//모달 내부에 숨겨진 input 태그에 댓글 번호 담기
					
									const content = e.target.parentNode.nextElementSibling.textContent;
									console.log('댓글 내용: ' + content);
					
									//3. 모달 창 하나를 이용해서 상황에 따라 삭제 모달을 구분하기 위해
									//조건문을 작성(삭제를 처리. 디자인 조정)
									if(e.target.classList.contains('replyDelete')){
											//삭제 버튼을 눌렀으므로 삭제 모달 형식으로 꾸며준다
											document.querySelector('.modal-title').textContent = '댓글 삭제';
											document.getElementById('modalReply').style.display = 'none';    //댓글창
											document.getElementById('modalDelBtn').style.display = 'inline';    //삭제 버튼
											$('#replyModal').modal('show');
									}
							}); //삭제 버튼 클릭 이벤트 끝 


							//삭제 이벤트
							document.getElementById('modalDelBtn').onclick = () => {
							
								const replyNo = document.getElementById('modalReplyNo').value;
								const replyId = document.getElementById('modalId').value;

								
								fetch('${pageContext.request.contextPath}/reply/' + replyNo, {
									method: 'delete',
									headers: {
										'Content-Type': 'application/json'
									},
									body: JSON.stringify({
										// 'rno' : rno,
										'replyPw': replyPw
									})
								})
									.then(res => res.text())
									.then(data => {
										if (data === 'delSuccess') {
											alert('댓글이 삭제되었습니다.');
											document.getElementById('modalId').value = '';
											$('#replyModal').modal('hide');
											getList(1, true);
										}
									});
							}   //end delete

							//댓글 날짜 변환 함수
							function parseTime(regDateTime) {
								let year, month, day, hour, minute, second;
								if (regDateTime.length === 5) {
									[year, month, day, hour, minute] = regDateTime;
									second = 0;
								} else {
									[year, month, day, hour, minute, second] = regDateTime;
								}

								//원하는 날짜로 객체를 생성
								const regTime = new Date(year, month - 1, day, hour, minute, second);
								console.log(regTime);
								const date = new Date();
								console.log(date);
								const gap = date.getTime() - regTime.getTime();

								let time;
								if (gap < 60 * 60 * 24 * 1000) {
									if (gap < 60 * 60 * 1000) {
										time = '방금 전';
									} else {
										time = parseInt(gap / (1000 * 60 * 60)) + '시간 전';
									}
								} else if (gap < 60 * 60 * 24 * 30 * 1000) {
									time = parseInt(gap / (1000 * 60 * 60 * 24)) + '일 전';
								} else {
									time = `${regTime.getFullYear()}년 ${regTime.getMonth() + 1}월 ${regTime.getDate()}일`;
								}
								return time;
							}

						}   //window.onload

					</script>