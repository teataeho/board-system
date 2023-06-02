<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>
<body onkeydown="EnterLogin();">
<div class="login">
	<h2 class="title">로그인</h2>
	<form action="${pageContext.request.contextPath}/user/userLogin"
		method="post" name="loginForm">
		<div class="loginBorder">
			<div class="idPw">
				<input type="text" class="form-id form-control form-control-lg loginId" name="userId" id="userId"
					placeholder="아이디" autocomplete="off"> <input
					type="password" class="form-pw form-control form-control-lg loginPw" name="userPw" id="userPw"
					placeholder="비밀번호">
			</div>
			<div class="login-div">
				<button type="button" id="loginBtn" class="loginBtn">Login</button>
				<button type="button" id="joinBtn" class="joinBtn">
					<a href="${pageContext.request.contextPath}/user/userJoin">회원가입하기</a>
					<!-- a태그 추가 -->
				</button>
			</div>

		</div>


	</form>
</div>
</body>
<%@ include file="../include/footer.jsp"%>

<script>

				//회원 가입 완료 후 addFlashAttribute로 msg 데이터가 전달 되는 지 확인
				const msg = '${msg}';
				if (msg === 'joinSuccess') {
					alert('회원 가입 정상 처리되었습니다.');
				} else if (msg === 'loginFail') {
					alert('로그인에 실패했습니다. 아이디와 비밀번호를 확인하세요.');
				}

				//id, pw 입력란이 공백인 지 아닌지 확인한 후, 공백이 아니라면 submit을 진행하세요.
				//요청 url은 /user/userLogin -> post로 갑니다. (비동기 아니에요!)
				document.getElementById('loginBtn').onclick = () => {
					if (document.getElementById('userId').value === '') {
						alert('아이디를 적어주세요.');
						return;
					}
					if (document.getElementById('userPw').value === '') {
						alert('비밀번호를 작성하세요!');
						return;
					}

					document.loginForm.submit();
				}

				function EnterLogin() {
					var keyCode = window.event.keyCode;
					if(keyCode == 13) {	//Enter
						document.loginForm.submit();
					}
				}
				
			</script>