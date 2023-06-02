<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ include file="../include/header.jsp" %>


		<h2 class="title">회원가입</h2>
		<div class="container">
			<section id="section">
				<form action="${pageContext.request.contextPath}/user/join" method="POST" name="joinForm">
					<p class="necessary">*모든 값이 필수입력값입니다!</p>
					<!-- 아이디 -->
					<div id="block">
						<p>아이디 (※ 추후 변경 불가합니다.)</p>
						<div class="idBorder">
							<input class="form_id form-control form-control-lg" name="userId" id="userId" type="text"
								placeholder="아이디를 입력해주세요. (영문 4~12자)" aria-label=".form-control-lg example" autocomplete="off">
							<button class="btn btn-outline-secondary form-idCheckBtn" type="button" id="idCheckBtn">아이디 중복
								체크</button>

						</div>
					</div>
					<span id="msgId"></span>

					<!-- 비밀번호 -->
					<div id="block">
						<p>
							비밀번호 (※ 추후 변경 불가합니다.)
						</p>

						<input class="form-control form-control-lg" name="userPw" id="userPw" type="password"
							placeholder="비밀번호를 입력해주세요. (영문, 숫자 포함8~16자)" aria-label=".form-control-lg example" autocomplete="off">

						<span id="msgPw"></span>
					</div>

					<!-- 비번 체크 -->
					<div id="block">
						<p>
							비밀번호 확인
						</p>

						<input class="form-control form-control-lg" name="pwCheck" id="pwCheck" type="password"
							placeholder="비밀번호를 다시 한 번 입력해주세요." aria-label=".form-control-lg example" autocomplete="off">

						<span id="msgPwCheck"></span>
					</div>

					<!-- 이름 -->
					<div id="block">
						<p>
							이름
						</p>

						<input class="form-control form-control-lg" name="userName" id="userName" type="text">

					</div>

					<!-- 닉네임 -->
					<div id="block">
						<p>
							닉네임
						</p>


						<input class="form-control form-control-lg" name="userNick" id="userNick" type="text">
					</div>

					<!-- 이메일 -->
					<div class="block">
						<p>이메일</p>
						<div class="emailBorder">
							<div class="border">
								<input type="text" class="form-control form-control-lg" name="userEmail1" id="userEmail1">
							</div>
							<p>@</p>
							<div class="border">
								<input type="text" class="form-control form-control-lg" name="userEmail2" id="userEmail2" value="">

								<div class="border">
									<select class="form-emailSelection" name="emailSelection" id="emailSelection">
										<option value="direct">직접 입력</option>
										<option value="naver.com">naver.com</option>
										<option value="daum.net">daum.net</option>
										<option value="gmail.com">gmail.com</option>
										<option value="hanmail.com">hanmail.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
									</select>
								</div>
							</div>
						</div>

						<div class="emailCheck">
							<input class="form-control-lg" type="text" placeholder="인증번호를 입력해주세요." aria-label="Disabled input example"
								id="emailCheck" name="emailCheck" disabled>
							<button class="btn btn-outline-secondary" type="button" id="emailCheckBtn">이메일 인증</button>
						</div>
					</div>

					<!-- 거주구 -->
					<div class="block">
						<p>활동하고싶은 동네가 어디인가요?</p>
						<small class="information">입력해주신 동네의 동행을 우선적으로 보여드리기 위해 얻는
							정보로, 이외의 용도로 사용되지 않습니다.</small>
						<div class="border">
							<select onchange="categoryChange(this)" name="addrGu">
								<option value="" disabled selected hidden>구</option>
								<option value="마포구">마포구</option>
								<option value="서대문구">서대문구</option>
							</select> <select id="addrDong" name="addrDong">
								<option>동을 선택해주세요</option>
							</select>
						</div>
					</div>

					<!-- 버튼 -->
					<div class="btns">
						<button type="button" class="form-joinBtn" id="joinBtn">회원가입</button>
						<button type="button" class="form-loginBtn" id="loginBtn">로그인</button>
					</div>

				</form>
			</section>
		</div>


		<%@ include file="../include/footer.jsp" %>


			<script>
				let code = '';
				let idFlag, pwFlag; //유효성 검사
				//아이디 중복체크
				document.getElementById('idCheckBtn').onclick = function () {
					const userId = document.getElementById('userId').value;
					if (userId === '') {
						alert('아이디는 필수값입니다!') //확인
						return;
					}

					//아이디 중복확인 비동기 요청 준비
					const xhr = new XMLHttpRequest();

					//서버 요청 정보 설정
					xhr.open('POST', '${pageContext.request.contextPath}/user/idCheck');

					//요청 정보를 헤더에 설정
					xhr.setRequestHeader('content-type', 'text/plain');
					xhr.send(userId);

					xhr.onload = () => {
						console.log(xhr.status);
						console.log(xhr.response);
					}


					//요청에 관련된 정보 객체
					const reqObj = {
						method: 'post',
						headers: {
							'Content-Type': 'text/plain'
						},
						body: userId
					};


					// 비동기 요청 보내기
					fetch('${pageContext.request.contextPath}/user/idCheck', reqObj)
						.then(res => res.text()) //요청 완료 후 응답 정보에서 텍스트만 빼기
						.then(data => { //텍스트만 뺀 Promise 객체로부터 data 전달받음.
							if (data === 'available') {
								console.log('available');
								alert('사용 가능!')
								//더 이상 아이디를 작성할 수 없도록 막아주겠다.
								document.getElementById('userId').setAttribute('readonly', true);
								//더 이상 버튼을 누를 수 없도록 버튼 비활성화.
								document.getElementById('idCheckBtn').setAttribute('disabled', true);
								//메세지 남기기
								document.getElementsByClassName('msgId').textContent = '사용 가능한 아이디 입니다.';
							} else if (data == 'duplicated') {
								console.log('duplicated');
								alert('중복 아이디!');
								document.getElementsByClassName('msgId').textContent = '중복된 아이디 입니다.';
							} else {
								console.log('???');
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

				/*부적합한 아이디일 때 아이디 중복체크가 가능한 오류를 발견
				-> '아이디 중복체크는 필수입니다' 나오기 전까지 아이디 중복체크 버튼 비활성화*/
				document.getElementById('idCheckBtn').disabled = true;

				/*아이디 형식 검사 스크립트*/
				var id = document.getElementById("userId");
				id.onkeyup = function () {
					/*test메서드를 통해 비교하며, 매칭되면 true, 아니면 false 반환*/
					var regex = /^[A-Za-z0-9+]{4,12}$/;
					if (regex.test(document.getElementById("userId").value)) {
						document.getElementById("userId").style.borderColor = "green";
						document.getElementById("msgId").innerHTML = "아이디 중복체크는 필수 입니다.";
						idFlag = true;
						document.getElementById('idCheckBtn').disabled = false;
					} else {
						document.getElementById("userId").style.borderColor = "orange";
						document.getElementById("msgId").innerHTML = "부적합한 아이디 입니다.";
						idFlag = false;
						document.getElementById('idCheckBtn').disabled = true;
					}
				}


				/*비밀번호 형식 검사 스크립트*/
				var pw = document.getElementById("userPw");
				pw.onkeyup = function () {
					var regex = /^[A-Za-z0-9+]{8,16}$/;
					if (regex.test(document.getElementById("userPw").value)) {
						document.getElementById("userPw").style.borderColor = "green";
						document.getElementById("msgPw").innerHTML = "사용가능합니다.";
						pwFlag = true;

					} else {
						document.getElementById("userPw").style.borderColor = "orange";
						document.getElementById("msgPw").innerHTML = "비밀번호를 제대로 입력하세요.";
						pwFlag = false;

					}
				}

				/*비밀번호 확인검사*/
				var pwCheck = document.getElementById("pwCheck");
				pwCheck.onkeyup = function () {
					var regex = /^[A-Za-z0-9+]{8,16}$/;
					if (document.getElementById("pwCheck").value == document
						.getElementById("userPw").value) {
						document.getElementById("pwCheck").style.borderColor = "green";
						document.getElementById("msgPw2").innerHTML = "비밀번호가 일치합니다.";

					} else {
						document.getElementById("pwCheck").style.borderColor = "red";
						document.getElementById("msgPw2").innerHTML = "비밀번호 확인란을 확인하세요.";
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