<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>
<!-- css 디자인 -->
<link href="${pageContext.request.contextPath }/css/userJoin.css"
	rel="stylesheet">
	

<div class="join">
	<h2 class="title">회원가입</h2>
	<div class="section">
		<form class="form" action="${pageContext.request.contextPath}/user/userJoin" method="POST">
			<p class="necessary">*표시가 있는 곳은 필수입력값입니다!</p>
			<!-- 아이디 -->
			<div class="block">
				<p>
					<span class="necessary">*</span>아이디
				</p>
				<div class="idBorder">
					<div class="border">
						<input type="text" class="form-id" name="userId" id="userId"
							placeholder="아이디를 입력해주세요. (영문 4~12자)" autocomplete="off">
					</div>
					<button type="button" class="form-idCheckBtn" id="idCheckBtn">아이디
						중복 체크</button>
				</div>
				<span class="msgId"></span>
			</div>

			<!-- 비밀번호 -->
			<div class="block">
				<p>
					<span class="necessary">*</span>비밀번호
				</p>
				<div class="border">
					<input type="password" class="form-pw" name="userPw" id="userPw"
						placeholder="비밀번호를 입력해주세요. (영문, 숫자 포함 8~16자)">
				</div>
				<span class="msgPw"></span>
			</div>

			<!-- 비번체크 -->
			<div class="block">
				<p>
					<span class="necessary">*</span>비밀번호 확인
				</p>
				<div class="border">
					<input type="password" class="form-pwCheck" name="pwCheck"
						id="pwCheck" placeholder="비밀번호를 다시 한 번 입력해주세요.">
				</div>
				<span class="msgPwCheck"></span>
			</div>

			<!-- 이름 -->
			<div class="block">
				<p>
					<span class="necessary">*</span>이름
				</p>
				<div class="border">
					<input type="text" class="form-userName" name="userName"
						id="userName">
				</div>
			</div>

			<!-- 닉네임 -->
			<div class="block">
				<p>
					<span class="necessary">*</span>닉네임
				</p>
				<div class="border">
					<input type="text" class="form-userNick" name="userNick"
						id="userNick">
				</div>
			</div>

			<!-- 이메일 -->
			<div class="block">
				<p>
					<span class="necessary">*</span>이메일
				</p>
				<div class="emailBorder">
					<div class="border">
						<input type="text" class="form-userEmail1" name="userEmail1"
							id="userEmail1">
					</div>
					<p>@</p>
					<div class="border">
						<input type="text" class="form-userEmail2" name="userEmail2"
							id="userEmail2" value="naver.com" readonly>
					</div>
					<div class="border">
						<select class="form-emailSelection" name="emailSelection"
							id="emailSelection">
							<option value="type">직접 입력</option>
							<option>naver.com</option>
							<option>daum.net</option>
							<option>gmail.com</option>
							<option>hanmail.com</option>
							<option>yahoo.co.kr</option>
						</select>
					</div>
				</div>
				<input type="text" class="form-emailCheck" name="emailCheck"
					id="emailCheck" value="인증번호를 입력해주세요." readonly>
				<button type="button" class="form-emailCheckBtn" id="emailCheckBtn">이메일
					인증</button>
			</div>

			<!-- 전화번호 -->
			<div class="block">
				<p>전화번호</p>
				<div class="border">
					<input type="text" class="form-userPhone" name="userPhone"
						id="userPhone">
				</div>
			</div>

			<!-- 거주구 -->
			<div class="block">
				<p>
					<span class="necessary">*</span>현재 거주하고 계신 구가 어디인가요?
				</p>
				<small class="information">입력해주신 구의 동행을 우선적으로 보여드리기 위해 얻는
					정보로, 이외의 용도로 사용되지 않습니다.</small>
				<div class="border">
					<input type="text" class="form-addrMine" name="addrMine"
						id="addrMine" placeholder="ex) 강동구, 성동구, 강남구, ...">
				</div>
			</div>

			<!-- 근처구 -->
			<div class="block">
				<p>거주구 외에 왕래가 편한 구가 어디인가요?</p>
				<small class="information">입력해주신 구의 동행을 우선적으로 보여드리기 위해 얻는
					정보로, 이외의 용도로 사용되지 않습니다.</small>
				<div class="border">
					<input type="text" class="form-addrClose" name="addrClose"
						id="addrClose" placeholder="ex) 강동구, 성동구, 강남구, ...">
				</div>
			</div>

			<!-- 버튼 -->
			<div class="btns">
				<button type="button" class="form-joinBtn" id="joinBtn">회원가입</button>
				<button type="button" class="form-loginBtn" id="loginBtn">로그인</button>
			</div>
		</form>
	</div>
</div>
