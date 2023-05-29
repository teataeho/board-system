<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="../include/header.jsp" %>

<div class="join">
	<h2 class="title">회원가입</h2>
	<form action="" method="POST">
		<p class="necessary">*표시가 있는 곳은 필수입력값입니다!</p>
		<!-- 아이디 -->
		<div class="block">
			<p><span class="necessary">*</span>아이디</p>
			<div class="border"><input type="text" class="form-id" name="userId" id="userId"
					placeholder="아이디를 입력해주세요. (영문 4~12자)" autocomplete="off">
			</div>
			<button type="button" class="form-idCheckBtn" id="idCheckBtn">아이디 중복 체크</button>
			<span class="msgId"></span>
		</div>

		<!-- 비밀번호 -->
		<div class="block">
			<p><span class="necessary">*</span>비밀번호</p>
			<div class="border"><input type="password" class="form-pw" name="userPw" id="userPw"
					placeholder="비밀번호를 입력해주세요. (영문, 숫자 포함 8~16자)">
			</div>
			<span class="msgPw"></span>
		</div>

		<!-- 비번체크 -->
		<div class="block">
			<p><span class="necessary">*</span>비밀번호 확인</p>
			<div class="border"><input type="password" class="form-pwCheck" name="pwCheck" id="pwCheck"
					placeholder="비밀번호를 다시 한 번 입력해주세요.">
			</div>
			<span class="msgPwCheck"></span>
		</div>

		<!-- 이름 -->
		<div class="block">
			<p><span class="necessary">*</span>이름</p>
			<div class="border"><input type="text" class="form-userName" name="userName" id="userName">
			</div>
		</div>

		<!-- 닉네임 -->
		<div class="block">
			<p><span class="necessary">*</span>닉네임</p>
			<div class="border"><input type="text" class="form-userNick" name="userNick" id="userNick">
			</div>
		</div>

		<!-- 이메일 -->
		<div class="block">
			<p><span class="necessary">*</span>이메일</p>
			<div class="border"><input type="text" class="form-userEmail1" name="userEmail1" id="userEmail1">
			</div>
			<p>@</p>
			<div class="border"><input type="text" class="form-userEmail2" name="userEmail2" id="userEmail2"
					value="naver.com" readonly></div>
			<div class="border">
				<select class="form-emailSelection" name="emailSelection" id="emailSelection">
					<option value="type">직접 입력</option>
					<option>naver.com</option>
					<option>daum.net</option>
					<option>gmail.com</option>
					<option>hanmail.com</option>
					<option>yahoo.co.kr</option>
				</select>
			</div>
			<input type="text" class="form-emailCheck" name="emailCheck" id="emailCheck" value="인증번호를 입력해주세요." readonly>
			<button type="button" class="form-emailCheckBtn" id="emailCheckBtn">이메일 인증</button>
		</div>

		<!-- 전화번호 -->
		<div class="block">
			<p>전화번호</p>
			<div class="border"><input type="text" class="form-userPhone" name="userPhone" id="userPhone">
			</div>
		</div>

		<!-- 거주구 -->
		<div class="block">
			<p><span class="necessary">*</span>현재 거주하고 계신 구가 어디인가요?</p>
			<small class="information">입력해주신 구의 동행을 우선적으로 보여드리기 위해 얻는 정보로, 이외의 용도로 사용되지 않습니다.</small>
			<div class="border"><input type="text" class="form-addrMine" name="addrMine" id="addrMine"
					placeholder="ex) 강동구, 성동구, 강남구, ...">
			</div>
		</div>

		<!-- 근처구 -->
		<div class="block">
			<p>거주구 외에 왕래가 편한 구가 어디인가요?</p>
			<small class="information">입력해주신 구의 동행을 우선적으로 보여드리기 위해 얻는 정보로, 이외의 용도로 사용되지 않습니다.</small>
			<div class="border"><input type="text" class="form-addrClose" name="addrClose" id="addrClose"
					placeholder="ex) 강동구, 성동구, 강남구, ...">
			</div>
		</div>

		<!-- 버튼 -->
		<button type="button" class="form-joinBtn" id="joinBtn">회원가입</button>
		<button type="button" class="form-loginBtn" id="loginBtn">로그인</button>

	</form>
</div>

<script>
	let code = '';
	let idFlag, pwFlag; //유효성 검사
	//아이디 중복체크
	document.getElementById('idCheckBtn').onclick = function () {
		const userId = document.getElementById('userId').value;
		if (userId === '') {
			alert('아이디는 필수값입니다!')
			return;
		}
		// if (!idFlag) {
		// 	alert('아이디 확인')
		// 	return;
		// }


		//요청에 관련된 정보 객체
		const reqObj = {
			method: 'post',
			headers: {
				'Content-Type': 'text/plain'
			},
			body: userId
		};


		// if(data === 'available') {
		// 	alert('사용 가능한 아이디!')
		// } else {
		// 	alert('중복된 아이디')
		// }
		// 비동기 요청 보내기
		fetch('${pageContext.request.contextPath}/user/idCheck', reqObj)
			.then(res => res.text()) //요청 완료 후 응답 정보에서 텍스트만 빼기
			.then(data => { //텍스트만 뺀 Promise 객체로부터 data 전달받음.
				if (data === 'available') {
					//더 이상 아이디를 작성할 수 없도록 막아주겠다.
					document.getElementById('userId').setAttribute('readonly', true);
					//더 이상 버튼을 누를 수 없도록 버튼 비활성화.
					document.getElementById('idCheckBtn').setAttribute('disabled', true);
					//메세지 남기기
					document.getElementById('msgId').textContent = '사용 가능한 아이디 입니다.';
				} else {
					document.getElementById('msgId').textContent = '중복된 아이디 입니다.';
				}
			});
	}


	//인증번호 이메일 전송
	document.getElementById('mail-check-btn').onclick = function () {
		const email = document.getElementById('userEmail1').value + document.getElementById('userEmail2').value;
		console.log('완성된 email: ' + email);
		fetch('${pageContext.request.contextPath}/user/mailCheck?email=' + email)
			.then(res => res.text())
			.then(data => {
				console.log('인증번호: ' + data)

				//비활성된 인증번호 입력창을 활성화
				//인증번호 disabled 풀림
				document.querySelector('.mail-check-input').disabled = false;
				//클래스...('.')

				code = data;
				alert('인증번호가 전송되었습니다. 확인 후 입력란에 정확히 입력해주세요.');
			}); //비동기 끝

	}; //인증번호 이벤트 끝

	//인증번호 검증
	//blur -> focus가 벗어나는 경우 발생.
	document.querySelector('.mail-check-input').onblur = function (e) {
		// console.log('blur 이벤트 발생');
		const inputCode = e.target.value; //사용자가 입력한 인증번호
		const $resultMsg = document.getElementById('mail-check-warn'); //span
		console.log('사용자가 입력한 값: ' + inputCode);

		if (inputCode === code) {
			$resultMsg.textContent = '인증번호가 일치합니다.';
			$resultMsg.style.color = 'green';
			//이메일 인증을 더이상 못하게 버튼 비활성화
			document.getElementById('mail-check-btn').disabled = true;
			document.getElementById('userEmail1').setAttribute('readonly', true);

			document.getElementById('userEmail2').setAttribute('readonly', true);
			//인증번호 받아도 Email2가 바뀔 수 있는 문제 발생
			e.target.style.display = 'none'; //인증번호 입력창 숨기기



			//초기값을 사용자가 선택한 값으로 무조건 설정하는 방법(select에서 readonly 대용)
			//항상 2개 같이 써야한다.
			const email2 = document.getElementById('userEmail2');
			email2.setAttribute('onFocus', 'this.initialSelect = this.selectedIndex');
			email2.setAttribute('onChange', 'this.selectedIndex = this.initialSelect');

		} else {
			$resultMsg.textContent = '인증번호를 다시 확인해주세요.';
			$resultMsg.style.color = 'red';
			e.target.focus(); //다시 입력할 수 있도록 포커싱 주기
		}
	} //인증번호 검증 끝

	//폼 데이터 검증 (회원 가입 버튼 눌렀을 시)
	document.getElementById('joinBtn').onclick = function () {

		if (idFlag && pwFlag) {
			if (!document.getElementById('userId').getAttribute('readonly')) {
				alert('아이디 중복체크는 필수입니다.');
				return;
			}

			if (document.getElementById('userPw').value !== document.getElementById('pwConfirm').value) {
				alert('비밀번호 확인란을 확인하세요!');
				return;
			}

			if (document.getElementById('userName').value === '') {
				alert('이름을 필수값입니다.')
				return;
			}

			if (!document.getElementById('mail-check-btn').disabled) {
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
</script>