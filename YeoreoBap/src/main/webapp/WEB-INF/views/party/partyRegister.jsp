<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ include file="../include/header.jsp" %>

		<div class="join">
			<h2 class="title">파티 모집글 작성하기</h2>
			<form action="${pageContext.request.contextPath}/party/partyRegister" method="POST">
				<p>썸네일 사진을 선택해주세요.</p>
				<div class="pictures">
					<input type="checkbox" name="ex-pic1" id="pic1" src="${pageContext.request.contextPath}/img/">
					<input type="image" name="ex-pic2" id="pic2" src="${pageContext.request.contextPath}/img/">
					<input type="image" name="ex-pic3" id="pic3" src="${pageContext.request.contextPath}/img/">
					<!-- 사용자 지정 -->
					<div class="custom">
						<input type="image" name="custom-pic" id="pic-custom"
							src="${pageContext.request.contextPath}/img/upload.png">
						<p>사용자 지정</p>
						<span>*(jpg, jpeg, png, gif) 파일만 가능합니다.</span>
					</div>
				</div>

				<div>
					<p>제목</p>
					<div class="border"><input type="text" class="form-title" name="title" id="title"
							placeholder="ex) OOO 같이 갈 사람 구해요~!" autocomplete="off">
					</div>
					<p>내용</p>
					<div class="border">
						<textarea class="form-content" name="content" id="content" cols="10" rows="10"
							placeholder="ex) OO시에 OO에서 만나서 여러밥해요!" autocomplete="off"></textarea>
					</div>
				</div>

				<!-- 카카오맵 -->

				<div>
					<p>최대 몇 명까지 모이기 원하시나요?</p>
					<input type="text" name="max" id="max" placeholder="숫자로 입력해주세요. (2~10)">

					<p>식당명</p>
					<input type="text" name="restName" id="restName">
				</div>

				<button type="button" id="writeBtn">등록하기</button>
				<!-- type ="submit"..? -->
			</form>