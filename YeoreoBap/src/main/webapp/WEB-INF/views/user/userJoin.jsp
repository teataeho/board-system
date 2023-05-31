<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>

		<div class="join">
			<h2 class="title">회원가입</h2>
			<form action="" method="POST">
				<p class="necessary">*모든 값이 필수입력값입니다!</p>
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
			<p>
				<span class="necessary">*</span>비밀번호
			</p>
			<div class="border">
				<input type="password" class="form-pw" name="userPw" id="userPw"
					placeholder="비밀번호를 입력해주세요. (영문, 숫자 포함 8~16자)">
			</div>
			<span id="msgPw"></span>
		</div>

		<!-- 비번체크 -->
		<div class="block">
			<p>
				<span class="necessary">*</span>비밀번호 확인
			</p>
			<div class="border">
				<input type="password" class="form-pwCheck" name="pwCheck" id="pwCheck"
					placeholder="비밀번호를 다시 한 번 입력해주세요.">
			</div>
			<span id="msgPwCheck"></span>
		</div>

		<!-- 이름 -->
		<div class="block">
			<p>
				<span class="necessary">*</span>이름
			</p>
			<div class="border">
				<input type="text" class="form-userName" name="userName" id="userName">
			</div>
		</div>

		<!-- 닉네임 -->
		<div class="block">
			<p>
				<span class="necessary">*</span>닉네임
			</p>
			<div class="border">
				<input type="text" class="form-userNick" name="userNick" id="userNick">
			</div>
		</div>

		<!-- 이메일 -->
		<div class="block">
			<p>
				<span class="necessary">*</span>이메일
			</p>
			<div class="border">
				<input type="text" class="form-userEmail1" name="userEmail1" id="userEmail1">
				<p>@</p>


				<!-- <div class="border">
				<input type="text" class="form-userEmail2" name="userEmail2" id="userEmail2" value="naver.com">
			</div> 수정 했습니다-->
				<div class="border">
					<!-- emailSelection -->
					<select class="form-emailSelection" name="emailSelection" id="userEmail2">
						<option value="type">직접 입력</option>
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>hanmail.com</option>
						<option>yahoo.co.kr</option>
					</select>
				</div>
				<input type="text" class="form-emailCheck" name="emailCheck" id="emailCheck" placeholder="인증번호를 입력해주세요."
					disabled="disabled">
				<button type="button" class="form-emailCheckBtn" id="emailCheckBtn">
					이메일 인증</button>
			</div>
		</div>

		<!-- 전화번호 -->
		<div class="block">
			<p>전화번호</p>
			<div class="border">
				<input type="text" class="form-userPhone" name="userPhone" id="userPhone">
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
				<!--  <input type="text" class="form-addrMine" name="addrMine" id="addrMine"
					placeholder="ex) 강동구, 성동구, 강남구, ...">-->
				<select class="form-addrMine" name="addrMine" id="addrMine">
						<option value="" disabled selected>거주구</option>
						<!-- '거주구'라는 글이 들어가는게 좋을지,
							아예 다른 '현재 거주하는 자치구' 라고 들어가는게 좋을지,
							빈값이 들어가는게 좋을지('근처구'도 마찬가지) -->
						<option>강남구</option>
						<option>강동구</option>
						<option>강북구</option>
						<option>강서구</option>
						<option>관악구</option>
						<option>광진구</option>
						<option>구로구</option>
						<option>금천구</option>
						<option>노원구</option>
						<option>도봉구</option>
						<option>동대문구</option>
						<option>동작구</option>
						<option>마포구</option>
						<option>서대문구</option>
						<option>서초구</option>
						<option>성동구</option>
						<option>성북구</option>
						<option>송파구</option>
						<option>양천구</option>
						<option>영등포구</option>
						<option>용산구</option>
						<option>은평구</option>
						<option>종로구</option>
						<option>중구</option>
						<option>중랑구</option>
					</select>
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
    if (!idFlag || !pwFlag) {
        alert('입력값을 다시 한 번 확인하세요!');
        return;
    }

    if (!document.getElementById('userId').getAttribute('readonly')) {
        alert('아이디 중복체크는 필수입니다.');
        return;
    }

    if (document.getElementById('userPw').value !== document.getElementById('pwCheck').value) {
        alert('비밀번호 확인란을 확인하세요!');
        return;
    }

    if (document.getElementById('userName').value === '') {
        alert('이름은 필수값입니다.');
        return;
    }

    if (!document.getElementById('emailCheckBtn').disabled) {
        alert('이메일 인증을 완료해주세요.');
        return;
    }

    if (confirm('회원가입을 진행합니다.')) {
        document.joinForm.submit();
    } else {
        return;
    }
}

	/*아이디 형식 검사 스크립트*/
	var id = document.getElementById("userId");
	id.onkeyup = function () {
		/*test메서드를 통해 비교하며, 매칭되면 true, 아니면 false 반환*/
		var regex = /^[A-Za-z0-9+]{4,12}$/;
		if (regex.test(document.getElementById("userId").value)) {
			document.getElementById("userId").style.borderColor = "green";
			document.getElementById("msgId").innerHTML = "아이디 중복체크는 필수 입니다.";
			idFlag = true;
		} else {
			document.getElementById("userId").style.borderColor = "orange";
			document.getElementById("msgId").innerHTML = "부적합한 아이디 입니다.";
			idFlag = false;
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
			document.getElementById("msgPwCheck").innerHTML = "비밀번호가 일치합니다.";

		} else {
			document.getElementById("pwCheck").style.borderColor = "red";
			document.getElementById("msgPwCheck").innerHTML = "비밀번호 확인란을 확인하세요.";
		}
	}
	/*'거주구'선택 불가*/
	document.getElementById('addrMine').onchange = function() {
	    if (this.value === '') {
	        this.selectedIndex = -1;
	    }
	};
	/*'근처구'선택 불가*/
	document.getElementById('addrClose').onchange = function() {
	    if (this.value === '') {
	        this.selectedIndex = -1;
	    }
	};
	
	/*거주구, 근처구 중복 선택 불가*/
	document.getElementById('addrMine').addEventListener('change', function() {
		  var addrMineValue = this.value; // addrMine의 선택된 값 가져오기
		  
		  // addrMine의 값에 따라 addrClose 조작
		  var addrCloseSelect = document.getElementById('addrClose');
		  var addrCloseOptions = addrCloseSelect.options;
		  
		  for (var i = 0; i < addrCloseOptions.length; i++) {
		    var option = addrCloseOptions[i];
		    
		    if (option.value === addrMineValue) {
		      option.disabled = true; // addrMine과 동일한 값을 가진 option 비활성화
		    } else {
		      option.disabled = false; // 나머지 option 활성화
		    }
		  }
		});
	
	document.getElementById('addrMine').addEventListener('click', function() {
		console.log('선택된 거주구: ' + addrMine.value);
	});
	
	document.getElementById('addrClose').addEventListener('click', function() {
		console.log('선택된 근처구: ' + addrClose.value);
	});

	/*제일 아래 로그인 버튼 누르면 로그인창 호출*/
	document.getElementById('loginBtn').addEventListener('click', function() {
		window.location.href= "${pageContext.request.contextPath}/user/userLogin";
	});
</script>
