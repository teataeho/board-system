﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<%@ include file="../include/header.jsp"%>

<section>
	<!--Toggleable / Dynamic Tabs긁어옴-->
	<div class="container">
		<div class="row">
			<div class="col-sm-12 col-md-10 col-lg-9 myInfo">
				<div class="titlebox">MY PAGE</div>

				<ul class="nav nav-tabs tabs-style">
					<li class="active"><a data-toggle="tab" href="#info">내정보</a></li>
					<li><a data-toggle="tab" href="#myBoard">내글</a></li>
				</ul>
				<div class="tab-content">
					<form action="${pageContext.request.contextPath}/user/userUpdate" method="post"
						name="updateForm">

						<table class="table">
							<tbody class="m-control">
								<tr>
									<td class="m-title">ID</td>
									<td><input class="form-control input-sm" name="userId"
										value="${userInfo.userId}" readonly></td>
								</tr>
								<tr>
									<td class="m-title">이름</td>
									<td><input class="form-control input-sm" name="userName"
										value="${userInfo.userName}" readonly></td>
								<tr>
									<td class="m-title">닉네임</td>
									<td><input class="form-control input-sm" name="userNick"
										value="${userInfo.userNick}"></td>
								</tr>
								<!-- <tr>
									<td class="m-title">현재 비밀번호</td>
									<td><input class="form-control input-sm" name="userPw" type="password" id="userPw">
									</td>
								</tr> -->
								<tr>
									<td class="m-title">수정 비밀번호</td>
									<td><input class="form-control input-sm" name="userPw"
										type="password" id="userPw"> <span id="msgPw"></span>
									</td>
								</tr>
								<tr>
									<td class="m-title">수정 비밀번호 확인</td>
									<td><input class="form-control input-sm"
										name="newUserPwChlk" type="password" id="newUserPwCheck"
										onblur="checkCurrentPw()"></td>
								</tr>
								<tr>
									<td class="m-title">E-mail</td>
									<td><input class="form-control input-sm" id="userEmail1"
										name="userEmail1"
										value="${userInfo.userEmail1}@${userInfo.userEmail2}" readonly>
									</td>
								</tr>


								<tr>
									<td class="m-title">구</td>
									<td><select name="addrGu" id="addrGu"
										onchange="categoryChange(this)">
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

									<td class="m-title">동</td>
									<td><select class="form-select" id="addrDong"
										name="addrDong">
											<option value="${userInfo.addrDong}">${userInfo.addrDong}</option>
									</select></td>
								</tr>
							</tbody>
						</table>

					</form>

					<div class="titlefoot">
						<button class="btn" id="updateBtn">수정</button>
						<button class="btn">목록</button>
					</div>

					<!-- 첫번째 토글 끝 -->

					<!-- 두번째 토글 메뉴의 시작 -->
					<div id="myBoard" class="tab-pane fade">
						<p>*내 게시글 관리</p>
						<form>
							<table class="table">
								<thead>
									<tr>
										<td>번호</td>
										<td>제목</td>
										<td>작성일</td>
									</tr>
								</thead>
								<tbody>

									<c:forEach var="vo" items="${userInfo.userPartyList}">
										<tr>
											<td>${vo.partyNo}</td>
											<td><a href="##">${vo.title}</a></td>
											<td><fmt:parseDate value="${vo.regDate}"
													pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate"
													type="both" /> <fmt:formatDate value="${parsedDate}"
													pattern="yyyy년 MM월 dd일 HH:mm" /></td>
										</tr>
									</c:forEach>

									<div class="text-center">
										<hr>
										<ul id="pagination" class="pagination pagination-sm">
											<c:if test="${pc.prev}">
												<li><a href="#" data-pagenum="${pc.beginPage-1}">이전</a></li>
											</c:if>

											<c:forEach var="num" begin="${pc.beginPage}"
												end="${pc.endPage}">
												<li class="${pc.paging.pageNum == num ? 'active' : ''}">
													<a href="#" data-pagenum="${num}">${num}</a>
												</li>
											</c:forEach>

											<c:if test="${pc.next}">
												<li><a href="#" data-pagenum="${pc.endPage+1}">다음</a></li>
											</c:if>
										</ul>
									</div>
								</tbody>
							</table>
						</form>
					</div>
					<!-- 두번째 토글 끝 -->
				</div>
			</div>
		</div>
	</div>
</section>
<%@ include file="../include/footer.jsp"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bcryptjs/2.4.3/bcrypt.min.js"></script>
<script>
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

	const userPw = document.getElementById(userPw').value;
	const newUserPwCheck = document.getElementById('newUserPwCheck').value;
	if (userPw === newUserPwCheck) {		
		if (userPw || newUserPwCheck === '') {
			document.getElementById("newUserPwCheck").style.borderColor = "none";
		} else {
			document.getElementById("newUserPwCheck").style.borderColor = "green";
		}
	}

	function checkCurrentPw() {
		if (userPw === newUserPwCheck) {
			//alert('비밀번호가 일치합니다.');
			console.log('비밀번호 일치');
		} else {
			alert('비밀번호가 일치하지 않습니다.');
		}
	}

	let pwFlag;

	/*비밀번호 형식 검사 스크립트*/
	var pw = document.getElementById("userPw");
	pw.onkeyup = function() {
		var regex = /^[A-Za-z0-9+]{8,16}$/;
		if (regex.test(document.getElementById("userPw").value)) {
			document.getElementById("userPw").style.borderColor = "green";
			document.getElementById("msgPw").innerHTML = "변경 가능합니다.";
			pwFlag = true;

		} else {
			document.getElementById("userPw").style.borderColor = "orange";
			document.getElementById("msgPw").innerHTML = "비밀번호를 제대로 입력하세요.";
			pwFlag = false;

		}
	}
	
	document.getElementById('updateBtn').onclick = function() {
		if(pwFlag) {
			if(document.getElementById('userPw').value !== document.getElementById('newUserPwCheck').value) {
				alert('비밀번호를 확인하세요.');
				return;
			}
			
			/*if(document.getElementById('userPw').value || document.getElementById('newUserPwCheck').value === '') {
				alert('입력값을 확인하세요.');
				return;
			} */
			
			if (confirm('정보를 수정합니다.')) {
		        // Ajax를 사용하여 사용자 정보를 업데이트하고, 업데이트된 정보를 화면에 표시
		        var xhr = new XMLHttpRequest();
		        xhr.open('POST', '${pageContext.request.contextPath}/user/userUpdate', true);
		        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		        xhr.onreadystatechange = function() {
		          if (xhr.readyState === 4 && xhr.status === 200) {
		            // 사용자 정보를 다시 조회하여 화면에 표시
		            var updatedUserInfo = JSON.parse(xhr.responseText);
		            document.getElementById('userNick').value = updatedUserInfo.userNick;
		            document.getElementById('userPw').value = updatedUserInfo.userPw;
		            document.getElementById('addrGu').value = updatedUserInfo.addrGu;
		            document.getElementById('addrDong').value = updatedUserInfo.addrDong;
		            
		          }
		        };
		        xhr.send('userPw=' + encodeURIComponent(document.getElementById('userPw').value) + 'userNick=' + encodeURIComponent(document.getElementById('userNick').value) + '&addrGu=' + encodeURIComponent(document.getElementById('addrGu').value) + '&addrDong=' + encodeURIComponent(document.getElementById('addrDong').value));
		      }
		    } else {
		      alert('다시');
		    }
		  }
		</script>
		위의 코드에서는 사용자 정보를 업데이트하는 버튼을 클릭할 때 Ajax를 사용하여 서버에 정보를 전송하고, 업데이트된 정보를 다시 받아와 화면에 표시하도록 수정되었습니다. 이렇게 수정하면 정보 변경이 화면에 반영될 것입니다.






