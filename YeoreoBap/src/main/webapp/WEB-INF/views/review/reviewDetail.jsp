﻿﻿﻿﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp"%>




<section>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-9 write-wrap">
				<div class="titlebox">
					<h3>상세보기</h3>
				</div>

				<form action="${pageContext.request.contextPath}/review/modify"
					method="post" name="form">

					<div class="regDate">
						<p class="subTitle">
							DATE <span>|</span>
						</p>
						<c:if test="${article.updateDate == null}">
							<p>${article.parsedRegDate}</p>
						</c:if>
						<c:if test="${article.updateDate != null}">
							<p>${article.parsedUpdateDate}</p>
						</c:if>
					</div>


					<div class="form-group">
						<p class="subTitle">
							후기 번호 <span>|</span>
						</p>
						<p class="reviewData" id="reviewNo">${article.reviewNo}</p>
						<input type="hidden" value="${article.reviewNo}" name="reviewNo">
					</div>
					<div class="form-group">
						<p class="subTitle">
							작성자 <span>|</span>
						</p>
						<p class="reviewData">${article.userNick}(${article.writer})</p>
						<input type="hidden" value="${article.userNick}" name="userNick">
						<input type="hidden" value="${article.writer}" name="writer">
					</div>
					<div class="form-group">
						<p class="subTitle">
							제목 <span>|</span>
						</p>
						<p class="reviewData reviewTitle text-truncate">${article.title}</p>
						<input type="hidden" value="${article.title}" name="title">
					</div>

					<div class="form-group">
						<p class="subTitle">
							내용 <span>|</span>
						</p>
						<p class="reviewData dataBorder">${article.content}</p>
						<input type="hidden" value="${article.content}" name="content">
					</div>

					<div class="reviewBtns">
						<c:if test="${userInfo.userId == article.writer}">
							<button type="submit" class="btn"
								onclick="return confirm('수정 페이지로 이동합니다.')">수정</button>
							<button class="delBtn" type="button" id="delBtn" class="btn">삭제</button>
						</c:if>
						<button type="button" class="btn"
							onclick="location.href='${pageContext.request.contextPath}/review/reviewList?pageNum=${p.pageNum}&cpp=${p.cpp}&keyword=${p.keyword}&condition=${p.condition}'">목록</button>
						<!--    목록 누르면 화면 페이지 유지하기    -->



					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<!-- 댓글 영역 시작 -->
<section style="margin-top: 80px;">
	<div class="container">

		<hr>
		<h5>댓글</h5>
		<div class="row">
			<div class="col-xs-9 col-md-9 write-wrap">
				<form class="reply-wrap">
					<!--form-control은 부트스트랩의 클래스입니다-->
					<div class="reply-content">

						<div class="reply-group">
							<div class="replyUser">
								<p class="subTitle">
									닉네임 <span>|</span>
								</p>
								<p class="userNick" id="replyNick">${userInfo.userNick}</p>
								<p class="userId" id="replyId" style="display: none;">${userInfo.userId}</p>
							</div>
							<div class="reply-input">
								<textarea class="form-control" rows="3" id="reply"
									placeholder="댓글을 입력해주세요"></textarea>
								<button type="button" id="replyRegist"
									class="right btn btn-info">등록하기</button>

							</div>
						</div>

					</div>
				</form>

				<!--여기에 접근 반복-->
				<div id="replyList"></div>
				<button type="button" class="form-control" id="moreList"
					style="display: none;">더보기(페이징)</button>
			</div>
		</div>
	</div>
</section>




<%@ include file="../include/footer.jsp"%>

<script>

	const $form = document.form;
	const uid = '${userInfo.userId}';

	document.querySelector('.reviewBtns').addEventListener('click', e => {
		if (e.target.matches('.delBtn')) {
			if (confirm('정말 삭제하시겠습니까?')) {
				$form.setAttribute('action', '${pageContext.request.contextPath}/review/delete');
				$form.submit();
			}
		}
	});


	window.onload = function () {
		document.getElementById('replyRegist').onclick = () => {
			const reviewNo = document.getElementById('reviewNo').textContent //현재 게시글 번호
			const reply = document.getElementById('reply').value;
			const replyId = document.getElementById('replyId').textContent;
            if (uid === '') {
                alert('로그인이 필요한 서비스입니다. :)');
                location.href = '${pageContext.request.contextPath}/user/userLogin';
                return;
            }

			if (reply === '') {
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

		} //댓글 등록 이벤트 끝


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
					let replyList = data.list; //후기 리스트


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
					if (total <= page * 10) {
						document.getElementById('moreList').style.display = 'none';
					} else {
						document.getElementById('moreList').style.display = 'block';
					}

					for (let i = 0; i < replyList.length; i++) {
					    strAdd += `
					        <div class='reply-wrap'>
					            <div class="reply-content">
					                <div class='my-reply-group'>
					                    <p class='left'>` + replyList[i].userNick + `</p> <span>|</span>
					                    <p class='clearfix' >` + replyList[i].reply + `</p>
					                    <a href='` + replyList[i].replyNo + `' class='right replyDelete'
					                        id='replyDelBtn'>X삭제</a>
					                </div>
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
		} //end getList(); 


		function registerReplyDeleteHandlers(e) {
					            console.log('delete 요청');
					            e.preventDefault();

					            // 삭제 요청을 보내는 AJAX 요청
					            fetch('${pageContext.request.contextPath}/reply/delete/' + e.target.getAttribute('href'), {
					                method: 'DELETE'
					            })
					            .then(res => res.text())
					            .then(data => {
									if(data === 'replyDeleteSuccess') window.location.reload();
									else {
										alert('본인의 댓글만 지울 수 있습니다.');
									}
					            })
					            .catch(error => {
					                console.error('삭제 요청 중 오류 발생:', error);
					            });
				};
					    
					

					// 이벤트 핸들러 등록 함수 호출
					document.getElementById('replyList').addEventListener('click', function(e) {
						if(e.target.matches('.replyDelete')) {
							registerReplyDeleteHandlers(e);
						} else {
							return;
						}
					});

		const $replyListWrap = document.getElementById('replyListWrap');
		$replyList.addEventListener('click', function (e) {
			e.preventDefault(); //태그의 고유 기능을 중지
			if (!e.target.matches('a')) return;


		})




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

	} //window.onload
</script>