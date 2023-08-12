﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp"%>

<section>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-9 write-wrap">
				<section id="section">
					<h2 class="text-center border-bottom border-orange pb-3 mb-4">상세보기</h2>
					<form action="${pageContext.request.contextPath}/review/modify" method="post" name="form">
						<input type="hidden" name="reviewNo" value="${article.reviewNo}">
						<input type="hidden" name="ref" value="${article.ref}">
						<input type="hidden" name="step" value="${article.step}">
						<input type="hidden" name="refOrder" value="${article.refOrder}">
						<input type="hidden" name="answerCnt" value="${article.answerCnt}">
						<div class="regDate">
							<p class="subTitle">
								DATE <span>|</span>
							</p>
							<c:if test="${article.updateDate == null}">
								<p>${article.parsedRegDate}</p>
							</c:if>
							<c:if test="${article.updateDate != null}">
								<p>${article.parsedUpdateDate} <small class="information">(수정됨)</small></p>
							</c:if>
						</div>
						<div class="form-group">
							<input type="hidden" value="${article.reviewNo}" id="reviewNo" name="reviewNo">
						</div>
						<div class="form-group">
							<p class="subTitle">
								작성자 <span>|</span>
							</p>
							<p class="reviewData"><c:out value="${article.writer}"></c:out></p>
							<input type="hidden" value="${article.writer}" name="writer">
						</div>
						<div class="form-group">
							<p class="subTitle">
								제목 <span>|</span>
							</p>
							<p class="reviewData reviewTitle text-truncate"><c:out value="${article.title}"></c:out></p>
							<input type="hidden" value="${article.title}" name="title">
						</div>
						<div class="form-group">
							<p class="subTitle">
								내용 <span>|</span>
							</p>
							<p class="reviewData dataBorder"><c:out value="${article.content}"></c:out></p>
							<input type="hidden" value="${article.content}" name="content">
						</div>
						<div class="reviewBtns d-flex flex-nowrap justify-content-evenly mx-auto">
							<button type="button" class="btn btn-outline-orange" id="dapBtn">답글</button>
							<button type="button" class="btn btn-orange" id="modiBtn">수정</button>
							<button type="button" class="btn btn-outline-orange" id="delBtn">삭제</button>
							<button type="button" class="btn btn-orange"
								onclick="location.href='${pageContext.request.contextPath}/review/reviewList?pageNum=${p.pageNum}&cpp=${p.cpp}&keyword=${p.keyword}&condition=${p.condition}'">목록</button>
							<!--    목록 누르면 화면 페이지 유지하기    -->
						</div>
					</form>
				</section>
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
									작성자 <span>|</span>
								</p>
								<input class="userNick form-control reply-control" id="replyId"/>
								<p class="subTitle">
									비밀번호 <span>|</span>
								</p>
								<input class="reply_password form-control reply-control" id="replyPw" type="password"/>
								<!-- <p class="userId" id="replyId" style="display: none;">${userInfo.userId}</p> -->
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

	//비밀번호 정규식표현
	const pwRegex =
      /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;

	//답글버튼
	document.getElementById('dapBtn').addEventListener('click', () => {
		$form.setAttribute('action', '${pageContext.request.contextPath}/review/reviewRegistDab');
		$form.submit();
	});

	//삭제버튼
	document.getElementById('delBtn').addEventListener('click', () => {

		const reviewDeleteHandler = () => {
			let insertedPw = prompt('비밀번호를 입력해주세요.');

			// 취소 버튼이 눌렸을 때 처리
			if (insertedPw === null) {
				return; // 함수 실행을 중단합니다.
			}

			const reviewNo = document.getElementById('reviewNo').value;
			console.log('입력된 비번: ' + insertedPw + ' 리뷰번호: ' + reviewNo);
			fetch('${pageContext.request.contextPath}/review/checkPw', {
				method: 'post',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					'reviewNo': reviewNo,
					'password': insertedPw
				})
			})
			.then(res => res.text())
			.then(data => {
				console.log(data);
				if(data == 1) {
					$form.setAttribute('action', '${pageContext.request.contextPath}/review/delete');
					$form.submit();
				} else {
					alert('비밀번호가 틀렸습니다.');
					reviewDeleteHandler();
				}
			})
		};

		reviewDeleteHandler();
	});

	//글수정함수
	const reviewModifyHandler = () => {
		let insertedPw = prompt('비밀번호를 입력해주세요.');		

		// 취소 버튼이 눌렸을 때 처리
		if (insertedPw === null) {
			return; // 함수 실행을 중단합니다.
		}

		const reviewNo = document.getElementById('reviewNo').value;
		fetch('${pageContext.request.contextPath}/review/checkPw', {
			method: 'post',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				'reviewNo': reviewNo,
				'password': insertedPw
			})
		})
		.then(res => res.text())
		.then(data => {
			console.log(data);
			if(data == 1) {
				$form.submit();
			} else {
				alert('비밀번호가 틀렸습니다.');
				reviewModifyHandler();
			}
		})
	};

	//수정버튼
	document.getElementById('modiBtn').addEventListener('click', () => {
		reviewModifyHandler();
	});

	document.getElementById('replyId').addEventListener('keyup', e => {
		if(e.target.value.length > 10) {
			alert('작성자는 10글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 10);
			document.getElementById('replyID').focus();
			return;
		}
	});
	document.getElementById('replyId').addEventListener('input', e => {
		if(e.target.value.length > 10) {
			alert('작성자는 10글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 10);
			document.getElementById('replyID').focus();
			return;
		}
	});
	document.getElementById('replyId').addEventListener('mouseup', e => {
		if(e.target.value.length > 10) {
			alert('작성자는 10글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 10);
			document.getElementById('replyID').focus();
			return;
		}
	});
	
	document.getElementById('reply').addEventListener('keyup', e => {
		if(e.target.value.length > 100) {
			alert('내용 100글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 100);
			document.getElementById('reply').focus();
			return;
		}
	});	
	document.getElementById('reply').addEventListener('input', e => {
		if(e.target.value.length > 100) {
			alert('내용 100글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 100);
			document.getElementById('reply').focus();
			return;
		}
	});
	document.getElementById('reply').addEventListener('mouseup', e => {
		if(e.target.value.length > 100) {
			alert('내용 100글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 100);
			document.getElementById('reply').focus();
			return;
		}
	});

	document.getElementById('replyPw').addEventListener('keyup', e => {
		if(e.target.value.length > 20) {
			alert('8~20글자 영문, 숫자, 특수문자를 포함해 주세요.');
			e.target.value = e.target.value.substr(0, 20);
			document.getElementById('replyPw').focus();
			return;
		}
	});
	document.getElementById('replyPw').addEventListener('input', e => {
		if(e.target.value.length > 20) {
			alert('8~20글자 영문, 숫자, 특수문자를 포함해 주세요.');
			e.target.value = e.target.value.substr(0, 20);
			document.getElementById('replyPw').focus();
			return;
		}
	});
	document.getElementById('replyPw').addEventListener('mouseup', e => {
		if(e.target.value.length > 20) {
			alert('8~20글자 영문, 숫자, 특수문자를 포함해 주세요.');
			e.target.value = e.target.value.substr(0, 20);
			document.getElementById('replyPw').focus();
			return;
		}
	});
	
	window.onload = function () {
		document.getElementById('replyRegist').onclick = () => {
			const reviewNo = document.getElementById('reviewNo').value; //현재 게시글 번호
			const reply = document.getElementById('reply').value;
			const replyId = document.getElementById('replyId').value;
			const replyPw = document.getElementById('replyPw').value;
            // if (uid === '') {
            //     alert('로그인이 필요한 서비스입니다. :)');
            //     location.href = '${pageContext.request.contextPath}/user/userLogin';
            //     return;
            // }

			//쿠키 있으면 리턴
			if(getCookie('replyBlock')) {
				alert('댓글은 30초 이내에 작성이 불가능합니다.')
				return;	
			} else if(replyId.trim() === '') {
				alert('작성자를 입력해주세요.');
				document.getElementById('replyId').focus();
				return;
			} else if(replyPw.trim() === '') {
				alert('비밀번호를를 입력해주세요.');
				document.getElementById('replyPw').focus();
				return;
			} else if(!pwRegex.test(document.getElementById('replyPw').value)) {
				alert('8~20글자 영문, 숫자, 특수문자를 포함해 주세요.');
				document.getElementById('replyPw').focus();
				return;
			} else if (reply.trim() === '') {
				alert('내용을 입력해주세요.');
				document.getElementById('reply').focus();
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
					'replyPw' : replyPw
				})
			};

			fetch('${pageContext.request.contextPath}/reply/regist', reqObj)
				.then(res => res.text())
				.then(data => {
					console.log('통신 성공!: ' + data);
					createCookie();
					document.getElementById('reply').value = '';
					document.getElementById('replyPw').value = '';
					document.getElementById('replyId').value = '';

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
										<p class='left replyId` + i + `'></p> <span>|</span>
										<pre class='clearfix reply` + i + `'></pre>
										<a href='${replyList[i].replyNo}' class='right replyDelete' id='replyDelBtn' onclick=>X삭제</a>
									</div>
								</div>
							</div>`;
					}

					// id가 reviewList라는 div 영역에 문자열 형식으로 모든 댓글을 추가.
					if (!reset) {
						document.getElementById('replyList').insertAdjacentHTML('beforeend', strAdd);
						for (let i = 0; i < replyList.length; i++) {
							document.querySelector(`.replyId` + i).insertAdjacentText('beforeend', replyList[i].replyId);
							document.querySelector(`.reply` + i).insertAdjacentText('beforeend', replyList[i].reply);
						}
					} else {
						document.getElementById('replyList').insertAdjacentHTML('afterbegin', strAdd);
						for (let i = 0; i < replyList.length; i++) {
							document.querySelector(`.replyId` + i).insertAdjacentText('beforeend', replyList[i].replyId);
							document.querySelector(`.reply` + i).insertAdjacentText('beforeend', replyList[i].reply);
						}
					}

				});
		} //end getList(); 

		//댓글삭제함수
		const replyDeleteHandler = e => {

			console.log('delete 요청');
			e.preventDefault();

			const promptForPassword = () => {

				let replyPw = prompt('비밀번호를 입력하세요.');

				// 취소 버튼이 눌렸을 때 처리
				if (replyPw === null) {
					return; // 함수 실행을 중단합니다.
				}
				
				// 삭제 요청을 보내는 AJAX 요청
				fetch('${pageContext.request.contextPath}/reply/delete/' + e.target.getAttribute('href') + '/' + replyPw, {
					method: 'DELETE'
				})
				.then(res => res.text())
				.then(data => {
					if(data === 'replyDeleteSuccess') window.location.reload();
					else {
						alert('비밀번호가 틀렸습니다..');
						// 비밀번호가 틀린 경우 재귀적으로 다시 비밀번호를 입력 받음
						promptForPassword();
					}
				})
				.catch(error => {
					console.error('삭제 요청 중 오류 발생:', error);
				});
			};

			promptForPassword();

		};

		// 이벤트 핸들러 등록 함수 호출
		document.getElementById('replyList').addEventListener('click', function(e) {
			if(e.target.matches('.replyDelete')) {
				replyDeleteHandler(e);
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

	//비밀번호 스페이스바 막기
	document.getElementById('replyPw').addEventListener('keydown', e => {
		// 스페이스바의 keyCode는 32입니다.
		if (e.keyCode === 32) {
			e.preventDefault(); // 기본 동작(스페이스 입력)을 막음
		}
	});

	function createCookie() {
		const date = new Date();
		date.setTime(date.getTime() + 30 * 1000);
		let cookie = '';
		cookie += `replyBlock=true;`; //세미콜론을 반드시 찍으세요.
		cookie += 'expires=' + date.toUTCString();
		document.cookie = cookie;
	}

	function getCookie(name) {
		const cookies = document.cookie.split(';');

		for(let c of cookies) {
			if(c.search(name) !== -1) {
				return true;
			}
		}
	}
</script>