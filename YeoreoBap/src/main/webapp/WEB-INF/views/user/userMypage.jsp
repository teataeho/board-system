<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/header.jsp"%>

<section>
	<!--Toggleable / Dynamic Tabs긁어옴-->
	<div class="container">
		<div class="row">
			<div class="col-sm-9 col-md-9 col-lg-9 myInfo">

				<section id="section">
					<h2
						class="titlebox text-center border-bottom border-orange pb-3 mb-4">MY
						PAGE</h2>
				</section>
				<br>
				<div class="tab-content">

					<form action="${pageContext.request.contextPath}/user/userUpdate"
						method="post" name="updateForm">

						<table class="table" id="mapageTable">
							<tbody class="m-control">
								<tr>
									<td class="m-title">ID<span>|</span></td>
									<td><input class="form-control input-sm" name="userId"
										value="${userInfo.userId}" readonly></td>
								</tr>
								<tr>
									<td class="m-title">이름<span>|</span></td>
									<td><input class="form-control input-sm" name="userName"
										value="${userInfo.userName}" readonly></td>
								</tr>

								<tr>
									<td class="m-title">*닉네임<span>|</span></td>
									<td><input class="form-control input-sm" name="userNick"
										value="${userInfo.userNick}"></td>
								</tr>
								<tr>
									<td class="m-title">E-mail<span>|</span></td>
									<td><input class="form-control input-sm" id="userEmail1"
										name="userEmail1"
										value="${userInfo.userEmail1}@${userInfo.userEmail2}" readonly>
									</td>
								</tr>


								<tr class="locationTr">
									<td class="m-title">*구<span>|</span></td>
									<td><select name="addrGu" id="addrGu"
										onchange="categoryChange(this)" class="form-select">
											<option value="${userInfo.addrGu}">${userInfo.addrGu}</option>
											<c:choose>
												<c:when test="${userInfo.addrGu == '서대문구'}">
													<option value="마포구">마포구</option>
												</c:when>
												<c:when test="${userInfo.addrGu == '마포구'}">
													<option value="서대문구">서대문구</option>
												</c:when>
											</c:choose>
									</select></td>
								</tr>
								<tr class="locationTr">
									<td class="m-title">*동<span>|</span></td>
									<td><select class="form-select" id="addrDong"
										name="addrDong">
											<option value="${userInfo.addrDong}">${userInfo.addrDong}</option>
									</select></td>
								</tr>
							</tbody>
						</table>

					</form>

					<div class="titlefoot" id="mypageBtn">
						<button class="btn mypageBtn" id="updateBtn">수정</button>
					</div>

					<!-- 첫번째 토글 끝 -->
					<hr>
					<br>
					<br>
					<br>
					<br>
					<br>
					<!-- 두번째 토글 메뉴의 시작 -->

					<p>*내 파티 관리</p>
					<form>
						<table class="table" id="partyList">
							<thead>
								<tr>
									<td>번호</td>
									<td>제목</td>
									<td>작성일</td>
								</tr>
							</thead>
							<tbody>

								<c:forEach var="vo" items="${user.userPartyList}">
									<tr>
										<td>${vo.partyNo}</td>
										<td><a href="##" id="${vo.partyNo}">${vo.title}</a></td>
										<td><fmt:parseDate value="${vo.regDate}"
												pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
											<fmt:formatDate value="${parsedDate}"
												pattern="yyyy년 MM월 dd일 HH:mm" /></td>
									</tr>
								</c:forEach>
								<hr>
							</tbody>
						</table>
					</form>

					<!-- 두번째 토글 끝 -->
					<hr>
					<br>
					<br>
					<br>
					<br>
					<br>

					<!-- 세번째 토글 메뉴의 시작 -->
					<p>*참가한 파티</p>
					<form>
						<table class="table">
							<thead>
								<tr>
									<td>번호</td>
									<td>제목</td>
									<td>작성일</td>
								</tr>
							</thead>
							<tbody id="participantsList">
							</tbody>
						</table>
					</form>
					<!-- 세번째 토글 끝 -->
				</div>
				<form action="${pageContext.request.contextPath}/user/deleteUser"
					method="post" name="deleteForm">
					<input type="hidden" value="${userInfo.userId}" name="userId">
					<input type="submit" value="회원 탈퇴" id="deleteUser">
				</form>
				<br>
				<br>
			</div>
		</div>
	</div>
</section>

<%@ include file="../include/footer.jsp"%>
<!-- 모달달 -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<input type="hidden" id="hiddenPartyNo"> <input
					type="hidden" id="hiddenUserId">
				<h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<span>식당이름</span><span class="res-name"></span> <br> <span
					class="content"></span> <br> <span>정원</span><span class="max"></span>
				<br>
				<br> <a href="#" id="like" class="text-danger"><i
					class="bi bi-heart"></i></a>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">모달 누르면 그냥 지워지는 버튼</button>
			</div>
		</div>
	</div>
</div>
<script>

//모달달
var modal = new bootstrap.Modal(document.querySelector('.modal'));
const $modalFooter = document.querySelector('.modal-footer');


//글 상세보기
let uid = '${userInfo.userId}';
document.getElementById('partyList').addEventListener('click', e => {
	if (uid === '') {
		alert('로그인 후 이용해주세요! :(');
		location.href = '${pageContext.request.contextPath}/user/userLogin';
		return;
	}
	console.log('e.target : ' + e.target);

	if($modalFooter) {
		while ($modalFooter.lastElementChild) {
			$modalFooter.removeChild($modalFooter.lastElementChild);
		}
	


	fetch('${pageContext.request.contextPath}/party/content/' + e.target.id + '/' + uid)
		.then(res => res.json())
		.then(data => {
			document.getElementById('hiddenPartyNo').value = data.partyNo
			document.getElementById('hiddenUserId').value = data.writer;
			document.querySelector('.modal-title').textContent = data.title;
			document.querySelector('.res-name').textContent = data.bplcNm;
			document.querySelector('.content').textContent = data.content;
			document.querySelector('.max').textContent = data.max + '명';
			console.log(data.attended);
			//좋아요 true, false
			if(data.isLike === 1) {
				document.querySelector('#like i').classList.remove('bi-heart');
				document.querySelector('#like i').classList.add('bi-heart-fill');
			} else {
				document.querySelector('#like i').classList.remove('bi-heart-fill');
				document.querySelector('#like i').classList.add('bi-heart');								
			}

			// 버튼 선택
			if (uid === data.writer) {
				$modalFooter.insertAdjacentHTML('beforeend',
					`<button type="button" class="btn btn-primary" id="deleteParty">삭제</button>`);
			} else if (data.attended === 0) {
				if (data.attendedNum >= data.max - 1) {
					$modalFooter.insertAdjacentHTML('beforeend',
						`<button type="button" class="btn btn-primary" id="attend" disabled>풀파티</button>`);
				} else {
					$modalFooter.insertAdjacentHTML('beforeend',
						`<button type="button" class="btn btn-primary" id="attend">참가</button>`);
				}
			} else {
				$modalFooter.insertAdjacentHTML('beforeend',
					`<button type="button" class="btn btn-primary" id="cancelAttend">참가취소</button>`);
			}
		});

	modal.show();
} else {
	console.log('modal-footer 없다');
}
});

$modalFooter.addEventListener('click', e => {
	// 참가
	if (e.target.id === 'attend') {
		fetch('attend', {
			method: 'post',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				'userId': uid,
				'partyNo': document.getElementById('hiddenPartyNo').value
			})
		})
			.then(res => res.text())
			.then(text => {
				if (text === 'success') {
					alert('파티에 참가하셨습니다.');
					modal.hide();
				} else {
					alert('파티 참가에 실패하셨습니다. 다시 시도해주세요.');
				}
			})
	}

	// 참가 취소
	if (e.target.id === 'cancelAttend') {
		fetch('cancelAttend', {
			method: 'delete',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				'userId': uid,
				'partyNo': document.getElementById('hiddenPartyNo').value
			})
		})
			.then(res => res.text())
			.then(text => {
				if (text === 'success') {
					alert('파티에서 나오셨습니다.');
					modal.hide();
				}
			})
	}

	// 삭제
	if (e.target.id === 'deleteParty') {
		if (confirm('정말로 파티를 해체하시겠습니까?')) {
			location.href = 'delete/' + document.getElementById('hiddenPartyNo').value;
		}
	}
});

//좋아요
document.getElementById('like').addEventListener('click', e => {
	e.preventDefault();
	if(!e.target.matches('i')) return;
	//좋아요
	if(document.querySelector('#like i').classList.contains('bi-heart')) {
		fetch('${pageContext.request.contextPath}/like/partyLike', {
				method: 'post',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					'userId': uid,
					'partyNo': document.getElementById('hiddenPartyNo').value
				})
			})
		.then(res => res.text())
		.then(text => {
			if(text !== 'success') {
				alert('이미 좋아요를 한 게시물이거나 알 수 없는 오류로 인해 좋아요가 취소되었습니다.');
			} else {
				document.querySelector('#like i').classList.remove('bi-heart')
				document.querySelector('#like i').classList.add('bi-heart-fill');
			}
		})
	}
	//좋아요 삭제
	if(document.querySelector('#like i').classList.contains('bi-heart-fill')) {
		fetch('${pageContext.request.contextPath}/like/deletePartyLike', {
				method: 'post',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					'userId': uid,
					'partyNo': document.getElementById('hiddenPartyNo').value
				})
			})
		.then(res => res.text())
		.then(text => {
			if(text !== 'success') {
				alert('삭제가 안됐습니다.');
			} else {
				document.querySelector('#like i').classList.remove('bi-heart-fill')
				document.querySelector('#like i').classList.add('bi-heart');
			}
		})
	}
})



	function categoryChange(e) {
		var addrDong_mapo = [ "상암동", "성산동", "망원동", "연남동", "동교동", "서교동", "합정동",
				"상수동", "창전동", "신수동", "노고산동", "대흥동", "염리동", "용강동", "도화동", "공덕동",
				"아현동", "신공덕동" ];
		var addrDong_seodaemun = [ "북가좌동", "남가좌동", "홍은동", "홍제동", "연희동", "신촌동",
				"봉원동", "북아현동", "현저동", "천연동" ];

		var target = document.getElementById("addrDong");

		if (e.value == "마포구")
			var d = addrDong_mapo;
		else if (e.value == "서대문구")
			var d = addrDong_seodaemun;

		target.options.length = 0;

		for (x in d) {
			var opt = document.createElement("option");
			opt.value = d[x];
			opt.innerHTML = d[x];
			target.appendChild(opt);
		}
	}
document.getElementById('updateBtn').onclick = function() {
			if (confirm('정보를 수정합니다. 다시 로그인해 주세요.')) {
				document.updateForm.submit();
			} else {
				alert('정보 수정을 취소합니다.');
			}
		
	}

document.getElementById('deleteUser').onclick = function() {
	if (confirm('정보를 삭제하고 회원 탈퇴를 진행합니다.')) {
			document.deleteForm.submit();
			location.reload();
		} else {
			alert('회원 탈퇴를 취소합니다.');
			return false;
		}
}

//참여한 파티 보이기
let parStr = '';
fetch('${pageContext.request.contextPath}/party/getParticipantsParty/' + uid)
.then(res => res.json())
.then(data => {
	for(let vo of data) {
		parStr += `<tr>
						<td>${vo.partyNo}</td>
						<td><a href="##" id="${vo.partyNo}">${vo.title}</a></td>
						<td><fmt:parseDate value="${vo.regDate}"
								pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
							<fmt:formatDate value="${parsedDate}"
								pattern="yyyy년 MM월 dd일 HH:mm" /></td>
					</tr>`;
	}
	document.getElementById('participantsList').insertAdjacentHTML('beforeend', parStr);
});
	</script>
