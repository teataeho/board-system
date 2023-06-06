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
			<div class="col-sm-12 col-md-10 col-lg-9 myInfo">
			<br><br>
				<div class="titlebox">MY PAGE</div>
				<br>
				<div class="tab-content">

					<form action="${pageContext.request.contextPath}/user/userUpdate"
						method="post" name="updateForm">

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
								</tr>

								<tr>
									<td class="m-title">*닉네임</td>
									<td><input class="form-control input-sm" name="userNick"
										value="${userInfo.userNick}"></td>
								</tr>
								<tr>
									<td class="m-title">E-mail</td>
									<td><input class="form-control input-sm" id="userEmail1"
										name="userEmail1"
										value="${userInfo.userEmail1}@${userInfo.userEmail2}" readonly>
									</td>
								</tr>


								<tr>
									<td class="m-title">*구</td>
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

									<td class="m-title">*동</td>
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
						
					</div>

					<!-- 첫번째 토글 끝 -->
					<hr><br><br><br><br><br>
					<!-- 두번째 토글 메뉴의 시작 -->
					
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

									<c:forEach var="vo" items="${user.userPartyList}">
										<tr>
											<td>${vo.partyNo}</td>
											<td><a href="##">${vo.title}</a></td>
											<td><fmt:parseDate value="${vo.regDate}"
													pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate"
													type="both" /> <fmt:formatDate value="${parsedDate}"
													pattern="yyyy년 MM월 dd일 HH:mm" /></td>
										</tr>
									</c:forEach>
										<hr>
								</tbody>
							</table>
						</form>
					
					<!-- 두번째 토글 끝 -->
				</div>
				<br><br>
			</div>
		</div>
	</div>
</section>

<%@ include file="../include/footer.jsp"%>

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
document.getElementById('updateBtn').onclick = function() {
			if (confirm('정보를 수정합니다.')) {
				document.updateForm.submit();
			} else {
				alert('정보 수정을 취소합니다.');
			}
		
	}
	</script>
