<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ include file="../include/header.jsp" %>

		<body onkeydown="EnterLogin()">
			<div class="container">
				<section id="section">
					<h2 class="text-center border-bottom border-orange pb-3 mb-4">로그인</h2>
					<form action="${pageContext.request.contextPath}/user/userLogin" method="post" name="loginForm">
						<div class="loginBorder">
							<div class="idPw has-validation">
								<input type="text" class="form-control form-control-lg loginId" name="userId" id="userId"
									placeholder="아이디" autocomplete="off">
								<input type="password" class="form-pw form-control form-control-lg loginPw" name="userPw" id="userPw"
									placeholder="비밀번호">
							</div>
							<div id="userLoginBtns" class="d-flex flex-column justify-content-center">
								<button type="button" id="loginBtn" class="btn btn-orange loginBtn">Login</button>
								<a class="text-light-orange text-center"
									href="${pageContext.request.contextPath}/user/userJoin">회원가입하기</a>
							</div>
						</div>
					</form>
				</section>
			</div>
		</body>
		<%@ include file="../include/footer.jsp" %>

			<script>

				// 회원 가입 완료 후 addFlashAttribute로 msg 데이터가 전달되는지 확인
				const msg = '${msg}';
				if (msg === 'joinSuccess') {
					alert('회원 가입이 완료되었습니다. :)');
				}

				// 로그인 확인
				document.getElementById('loginBtn').onclick = () => {
					const $userId = document.getElementById('userId');
					const $userPw = document.getElementById('userPw');

					$userId.classList.remove('is-invalid');
					$userPw.classList.remove('is-invalid');

					if ($userId.value === '') {
						alert('아이디를 적어주세요! :(');
						$userId.classList.add('is-invalid');
						$userId.focus();
						return;
					}

					if ($userPw.value === '') {
						alert('비밀번호를 적어주세요! :(');
						$userPw.classList.add('is-invalid');
						$userPw.focus();
						return;
					}

					document.loginForm.submit();
				}

				// 엔터 키 눌러도 로그인 진행되게끔
				function EnterLogin() {
					var keyCode = window.event.keyCode;
					if (keyCode == 13) {	// Enter
						document.getElementById('loginBtn').click();
					}
				}

			</script>