<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ include file="../include/header.jsp" %>

		<div class="container">
			<section id="section">
				<h2 class="text-center border-bottom border-orange pb-3 mb-4">회원가입</h2>
				<form action="${pageContext.request.contextPath} /user/join" method="POST" name="joinForm">
					<p class="necessary">*모든 값이 필수입력값입니다!</p>

					<!-- 아이디 -->
					<div class="row justify-content-between has-validation mb-4">
						<label for="userId" class="form-label">아이디</label>
						<div class="w-100 d-flex">
							<input id="userId" class="col form-control form-control-lg" name="userId" type="text"
								placeholder="아이디를 입력해주세요. (영문 4~12자)" autocomplete="off" required>
							<button id="idCheckBtn" class="col-3 btn btn-orange" type="button">아이디 중복 체크</button>
						</div>
						<div id="idValidMsg" class="valid-feedback">아이디 중복 체크를 진행해주세요! :)</div>
						<div id="idInvalidMsg" class="invalid-feedback">부적합한 아이디입니다. :(</div>
					</div>

					<!-- 비밀번호 -->
					<div class="row justify-content-between has-validation mb-4">
						<label for="userPw" class="form-label">비밀번호 <span class="necessary">(※ 추후 변경 불가합니다.)</span></label>
						<div class="w-100 d-flex">
							<input id="userPw" class="col form-control form-control-lg" name="userPw" type="password"
								placeholder="비밀번호를 입력해주세요. (영문, 숫자 포함 8~16자)" required>
						</div>
						<div id="pwValidMsg" class="valid-feedback">사용 가능한 비밀번호입니다! :)</div>
						<div id="pwInvalidMsg" class="invalid-feedback">부적합한 비밀번호입니다! :(</div>
					</div>

					<!-- 비번 체크 -->
					<div class="row justify-content-between has-validation mb-4">
						<label for="pwCheck" class="form-label">비밀번호 확인</label>
						<div class="w-100 d-flex">
							<input id="pwCheck" class="col form-control form-control-lg" name="pwCheck" type="password"
								placeholder="비밀번호를 다시 한 번 입력해주세요." required>
						</div>
						<div id="pwCValidMsg" class="valid-feedback">일치하는 비밀번호입니다! :)</div>
						<div id="pwCInvalidMsg" class="invalid-feedback">불일치하는 비밀번호입니다! :(</div>
					</div>

					<!-- 이름 -->
					<div class="mb-3">
						<p class="m-1">이름</p>
						<input class="form-control form-control-lg" name="userName" id="userName" type="text">
					</div>

					<!-- 닉네임 -->
					<div class="mb-3">
						<p class="m-1">닉네임</p>
						<input class="form-control form-control-lg" name="userNick" id="userNick" type="text">
					</div>

					<!-- 이메일 -->
					<div class="mb-3">
						<p class="m-1">이메일</p>
						<div id="emailBorder">
							<input type="text" class="form-control form-control-lg" name="userEmail1" id="userEmail1">
							<p>@</p>
							<input type="text" class="form-control form-control-lg" name="userEmail2" id="userEmail2" value="">

							<select class="form-emailSelection form-select " name="emailSelection" id="emailSelection">
								<option value="direct">직접 입력</option>
								<option value="naver.com">naver.com</option>
								<option value="daum.net">daum.net</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.com">hanmail.com</option>
								<option value="yahoo.co.kr">yahoo.co.kr</option>
							</select>
						</div>

						<div class="emailCheck">
							<input class="form-control-lg" type="text" placeholder="인증번호를 입력해주세요." id="emailCheck" name="emailCheck"
								disabled>
							<button class="btn btn-orange" type="button" id="emailCheckBtn">이메일 인증</button>
						</div>
					</div>

					<!-- 거주구 -->
					<div class="mb-3">
						<p class="m-1">활동하고 싶은 동네가 어디인가요?</p>
						<small class="information">입력해주신 동네의 동행을 우선적으로 보여드리기 위해 얻는
							정보로, 이외의 용도로 사용되지 않습니다.</small>
						<div id="locBorder">
							<select class="form-select locGu" onchange="categoryChange(this)" name="addrGu">
								<option value="" disabled selected hidden>구</option>
								<option value="마포구">마포구</option>
								<option value="서대문구">서대문구</option>
							</select> <select class="form-select" id="addrDong" name="addrDong">
								<option>동을 선택해주세요</option>
							</select>
						</div>
					</div>

					<!-- 버튼 -->
					<div class="btns">
						<button type="button" class="form-joinBtn btn btn-outline-secondary" id="joinBtn">회원가입</button>
						<button type="button" class="form-loginBtn btn btn-outline-secondary" id="loginBtn">
							<!-- 로그인 화면으로 이동 -->
							<a href="${pageContext.request.contextPath}/user/userLogin">로그인</a>
						</button>
					</div>

				</form>
			</section>
		</div>

		<%@ include file="../include/footer.jsp" %>

			<script>
				let code = '';
				let pwFlag;

				// 아이디 중복 체크 버튼 클릭 이벤트
				document.getElementById('idCheckBtn').onclick = function () {
					const userId = document.getElementById('userId').value;

					// 아이디 중복 확인 비동기 요청 준비
					const xhr = new XMLHttpRequest();

					// 서버 요청 정보 설정
					xhr.open('POST', '${pageContext.request.contextPath}/user/idCheck');

					// 요청 정보를 헤더에 설정
					xhr.setRequestHeader('content-type', 'text/plain');
					xhr.send(userId);

					xhr.onload = () => {
						console.log(xhr.status);
						console.log(xhr.response);
					}

					// 요청에 관련된 정보 객체
					const reqObj = {
						method: 'post',
						headers: {
							'Content-Type': 'text/plain'
						},
						body: userId
					};

					// 비동기 요청 보내기
					fetch('${pageContext.request.contextPath}/user/idCheck', reqObj)
						.then(res => res.text())
						.then(data => {
							const $userId = document.getElementById('userId');
							if (data === 'available') {
								$userId.style.color = '#198754';
								$userId.setAttribute('disabled', true);
								document.getElementById('idCheckBtn').setAttribute('disabled', true);
								document.getElementById('idValidMsg').textContent = '사용 가능한 아이디입니다. :)';
							} else {
								$userId.classList.remove('is-valid');
								$userId.classList.add('is-invalid');
								document.getElementById('idValidMsg').style.display = 'none';
								document.getElementById('idInvalidMsg').textContent = '중복되는 아이디입니다. :(';
								document.getElementById('idInvalidMsg').style.display = 'block';
								$userId.value = '';
								$userId.focus();
							}
						});
				}

				document.getElementById('emailSelection').onchange = function () {
					var userEmail2 = document.getElementById('userEmail2');
					var emailSelection = document.getElementById('emailSelection');

					if (emailSelection.value === 'direct') {
						userEmail2.disabled = false;
						userEmail2.value = '';
					} else {
						userEmail2.disabled = true;
						userEmail2.value = emailSelection.value;
					}
				};


				//인증번호 이메일 전송
				document.getElementById('emailCheckBtn').addEventListener('click', function () {
					const email = document.getElementById('userEmail1').value + '@' + document.getElementById('userEmail2')
						.value;
					console.log('완성된 email: ' + email);
					fetch('${pageContext.request.contextPath}/user/mailCheck?email=' + email)
						.then(res => res.text())
						.then(data => {
							console.log('인증번호: ' + data)
							code = data;
							alert('인증번호가 전송되었습니다. 확인 후 입력란에 정확히 입력해주세요.');
							// 인증번호를 입력할 수 있는 입력란 활성화
							document.getElementById('emailCheck').disabled = false;
						});
				});

				//인증번호 검증
				//blur -> focus가 벗어나는 경우  발생.
				document.getElementById('emailCheck').addEventListener('blur', function () {
					console.log('blur 이벤트 발생');
					const inputCode = this.value; // 인증번호 입력값 가져오기
					console.log('사용자가 입력한 값: ' + inputCode);

					if (inputCode === String(code)) {
						// 인증번호가 일치하는 경우의 처리 로직
						console.log('인증번호 일치');
						document.getElementById('emailCheckBtn').disabled = true;
						document.getElementById('userEmail1').setAttribute('readonly', true);
						document.getElementById('userEmail2').setAttribute('readonly', true);
						document.getElementById('emailCheck').style.display = 'none';

						const email2 = document.getElementById('userEmail2');
						email2.setAttribute('onFocus', 'this.initialSelect = this.selectedIndex');
						email2.setAttribute('onChange', 'this.selectedIndex = this.initialSelect');
					} else {
						// 인증번호가 일치하지 않는 경우의 처리 로직
						console.log('인증번호 불일치');
						document.getElementById('emailCheck').focus();
					}
				});

				//폼 데이터 검증 (회원 가입 버튼 눌렀을 시)
				document.getElementById('joinBtn').onclick = function () {

					if (idFlag && pwFlag) {
						if (!document.getElementById('userId').getAttribute('readonly')) {
							alert('아이디 중복체크는 필수입니다.');
							return;
						}

						if (document.getElementById('userPw').value !== document.getElementById('pwCheck').value) {
							alert('비밀번호 확인란을 확인하세요!');
							return;
						}

						if (document.getElementById('userName').value === '') {
							alert('이름을 필수값입니다.')
							return;
						}

						if (!document.getElementById('emailCheckBtn').disabled) {
							alert('이메일 인증을 완료해주세요.')
							return;
						}

						if (confirm('회원가입을 진행합니다.')) {
							document.joinForm.submit();
						} else return;

					} else {
						alert('입력값을 다시 한 번 확인하세요!');
					}
				}

				/* 부적합한 아이디일 때 아이디 중복체크가 가능한 오류를 발견
				-> '아이디 중복체크는 필수입니다' 나오기 전까지 아이디 중복체크 버튼 비활성화 */
				document.getElementById('idCheckBtn').disabled = true;

				/* 아이디 형식 검사 */
				document.getElementById("userId").onkeyup = function () {
					var regex = /^[A-Za-z0-9+]{4,12}$/;
					const $userId = document.getElementById('userId');
					document.getElementById('idInvalidMsg').textContent = '부적합한 아이디입니다. :(';

					if (regex.test($userId.value)) {
						$userId.classList.remove('is-invalid');
						$userId.classList.add('is-valid');
						document.getElementById('idInvalidMsg').style.display = 'none';
						document.getElementById('idValidMsg').style.display = 'block';
						document.getElementById('idCheckBtn').disabled = false;
					} else {
						$userId.classList.remove('is-valid');
						$userId.classList.add('is-invalid');
						document.getElementById('idValidMsg').style.display = 'none';
						document.getElementById('idInvalidMsg').style.display = 'block';
						document.getElementById('idCheckBtn').disabled = true;
					}
				}

				/* 비밀번호 형식 검사 */
				document.getElementById("userPw").onkeyup = function () {
					var regex = /^[A-Za-z0-9+]{8,16}$/;
					const $userPw = document.getElementById('userPw');

					if (regex.test($userPw.value)) {
						$userPw.classList.remove('is-invalid');
						$userPw.classList.add('is-valid');
						document.getElementById('pwInvalidMsg').style.display = 'none';
						document.getElementById('pwValidMsg').style.display = 'block';
					} else {
						$userPw.classList.remove('is-valid');
						$userPw.classList.add('is-invalid');
						document.getElementById('pwValidMsg').style.display = 'none';
						document.getElementById('pwInvalidMsg').style.display = 'block';
					}
				}

				/* 비밀번호 확인 */
				document.getElementById('pwCheck').onkeyup = () => {
					const $pwCheck = document.getElementById('pwCheck');

					if (document.getElementById('userPw').value === $pwCheck.value) {
						$pwCheck.classList.remove('is-invalid');
						$pwCheck.classList.add('is-valid');
						document.getElementById('pwCInvalidMsg').style.display = 'none';
						document.getElementById('pwCValidMsg').style.display = 'block';
					} else {
						$pwCheck.classList.add('is-invalid');
						$pwCheck.classList.remove('is-valid');
						document.getElementById('pwCValidMsg').style.display = 'none';
						document.getElementById('pwCInvalidMsg').style.display = 'block';
					}
				}

				/*'거주구' 선택 불가*/
				document.getElementById('addrGu').onchange = function () {
					if (this.selectedIndex === 0) {
						this.selectedIndex = -1;
					}
				};

				document.getElementById('addrGu').addEventListener('click', function () {
					console.log('선택된 거주구: ' + addrGu.value);
				});

				document.getElementById('addrDong').addEventListener('click', function () {
					console.log('선택된 거주동: ' + addrDong.value);
				});

				function categoryChange(e) {
					var addrDong_mapo = ["상암동", "성산동", "망원동", "연남동", "동교동", "서교동", "합정동", "상수동", "창전동", "신수동", "노고산동", "대흥동", "염리동",
						"용강동", "도화동", "공덕동", "아현동", "신공덕동"
					];
					var addrDong_seodaemun = ["북가좌동", "남가좌동", "홍은동", "홍제동", "연희동", "신촌동", "봉원동", "북아현동", "현저동", "천연동"];

					var target = document.getElementById("addrDong");

					if (e.value == "마포구") var d = addrDong_mapo;
					else if (e.value == "서대문구") var d = addrDong_seodaemun;

					target.options.length = 0;

					for (x in d) {
						var opt = document.createElement("option");
						opt.value = d[x];
						opt.innerHTML = d[x];
						target.appendChild(opt);
					}
				}


				/*제일 아래 로그인 버튼 누르면 로그인창 호출*/
				document.getElementById('loginBtn').addEventListener('click', function () {
					window.location.href = "${pageContext.request.contextPath}/user/userLogin";
				});
			</script>