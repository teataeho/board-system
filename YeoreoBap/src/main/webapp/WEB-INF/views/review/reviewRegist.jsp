<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../include/header.jsp"%>

<section>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 content-wrap" style="align-content: center;">
				<div class="titlebox registTitle">
					<h2>후기게시판</h2>
				</div>

				<form action="${pageContext.request.contextPath}/review/regist" method="post" name="reviewForm" enctype="multipart/form-data">
					<div id="file-upload-container">
						<label class="upload-label">업로드할 파일</label>
						<button type="button" class="btn" id="uploadPlusBtn">+</button>
						<button type="button" class="btn" id="uploadMinusBtn">-</button>
					</div>
					<table class="table" id="reviewTable">
						<tbody class="t-control riviewControl">
							<tr>
								<td class="t-title">작성자<span>|</span></td>
								<td><input class="form-control input-sm" name="writer" id="writer" placeholder="작성자는 10글자 이내로 제한됩니다."></td>
							</tr>
							<tr>
								<td class="t-title">제목<span>|</span></td>
								<td><input class="form-control input-sm" name="title" id="title" placeholder="제목은 100글자 이내로 제한됩니다."></td>
							</tr>
							<tr>
								<td class="t-title">비밀번호<span>|</span></td>
								<td id="resName">
									<!-- <c:set var="party" value="${party}" />
									<c:set var="attendedParty" value="${attendedParty}" />
									<select name="sno" id="sno">
										<c:forEach items="${party}" var="party" varStatus="status">
											<option value="${party.sno}">${party.bplcNm}</option>
										</c:forEach>
										<c:forEach items="${attendedParty}" var="attendedParty" varStatus="status">
											<option value="${attendedParty.sno}">${attendedParty.bplcNm}</option>
										</c:forEach>
									</select> -->
									<input class="form-control input-sm" type="password" name="password" id="password" placeholder="8~20글자 영문, 숫자, 특수문자를 포함해 주세요.">
									<div id="pwValidMsg" class="valid-feedback">사용 가능한 비밀번호입니다!</div>
									<div id="pwInvalidMsg" class="invalid-feedback">부적합한 비밀번호입니다.</div>
								</td>
							</tr>
							<tr>
								<td class="t-title">내용<span>|</span></td>
								<td><textarea class="form-control" rows="7" name="content" id="content" type='text'></textarea></td>
							</tr>
							<tr>
								<td></td>
								<td id="content_cnt">(0/1000)</td>
							</tr>
						</tbody>
					</table>
					<div class="titlefoot reviewTitleFoot">
						<button class="btn register" id="registBtn" type="button">등록</button>
						<button class="btn" id="listBtn" type="button" onclick="location.href='${pageContext.request.contextPath}/review/reviewList'">목록</button>
					</div>

				</form>

			</div>
		</div>
	</div>
</section>

<!-- 모달 -->
<!-- <div id="ratingModal" class="modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">가게의 별점을 매겨주세요!</h5>
				<p>*별점은 내부 데이터에만 수집되고 글에는 명시 되지 않습니다.</p>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="rating-stars">
					<span class="star" data-value="1"><i class="bi bi-star-fill"></i></span>
					<span class="star" data-value="2"><i class="bi bi-star-fill"></i></span>
					<span class="star" data-value="3"><i class="bi bi-star-fill"></i></span>
					<span class="star" data-value="4"><i class="bi bi-star-fill"></i></span>
					<span class="star" data-value="5"><i class="bi bi-star-fill"></i></span>
				</div>
			</div>
		</div>
	</div>
</div> -->

<%@ include file="../include/footer.jsp"%>

<script>
	// var myModal = new bootstrap.Modal(document.getElementById("ratingModal"));

	// document.querySelector('.register').addEventListener('click', () => {
	// 	myModal.show();
	// });

	// const $stars = document.querySelectorAll("#ratingModal .rating-stars .star");
	// let rating = 0;

	// $stars.forEach(function (star) {
	// 	star.addEventListener('click', function () {
	// 		var starValue = parseInt(this.getAttribute('data-value'));
	// 		rating = starValue;
	// 		$stars.forEach(function (s, index) {
	// 			if (index < starValue) {
	// 				s.classList.add('active');
	// 			} else {
	// 				s.classList.remove('active');
	// 			}
	// 		});

	// 		console.log('별점: ' + rating);
	// 		setTimeout(() => {
	// 			if (!confirm('별점을 매기시겠습니까?')) {
	// 				return;
	// 			} else {
	// 				fetch('${pageContext.request.contextPath}/star/insertStar', {
	// 						method: 'post',
	// 						headers: {
	// 							'Content-Type': 'application/json'
	// 						},
	// 						body: JSON.stringify({
	// 							'userId': document.getElementById('userId').value,
	// 							'sno': document.getElementById('sno').value,
	// 							'starRate': rating
	// 						})
	// 					})
	// 					.then(res => res.text())
	// 					.then(text => {
	// 						if (text !== 'success') {
	// 							console.log(text);
	// 						} else {
	// 							document.reviewForm.submit();
	// 						}
	// 					});
	// 			}
	// 		}, 500);
	// 	});
	// });


	//글자수 제한 함수 jquery
	//화면 넓게 하면 300자까지 들어갑니다. max 늘리시려면 숫자 300으로 돼있는거 다 한 숫자로 바꾸면 됩니다.
	// $(document).ready(function () {
	// 	$('#content').on('keyup', function () {
	// 		$('#content_cnt').html("(" + $(this).val().length + "/1000)");
	// 		if ($(this).val().length > 1000) {
	// 			$(this).val($(this).val.substring(0, 1000));
	// 			$('#content_cnt').html("(1000/1000)");
	// 		}
	// 	});
	// })

	//비밀번호 정규식표현
	const pwRegex =
      /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;

	document.getElementById('registBtn').onclick = function () {
		if(document.getElementById('writer').value.trim() === '') {
			alert('작성자는 공백일 수 없습니다.');
			document.getElementById('writer').focus();
			return;
		} else if(document.getElementById('title').value.trim() === '') {
			alert('제목은 공백일 수 없습니다.');
			document.getElementById('title').focus();
			return;
		} else if(document.getElementById('password').value.trim() === '') {
			alert('비밀번호를 입력해주세요.');
			document.getElementById('password').focus();
			return;
		} else if(!pwRegex.test(document.getElementById('password').value)) {
			alert('8~20글자 영문, 숫자, 특수문자를 포함해 주세요.');
			document.getElementById('password').focus();
			return;
		} else if(document.getElementById('content').value.trim() === '') {
			alert('내용은 공백일 수 없습니다.');
			document.getElementById('content').focus();
			return;
		} else {
			document.reviewForm.submit();
		};
	}

	document.getElementById('writer').addEventListener('keyup', e => {
		if(e.target.value.length > 10) {
			alert('작성자는 10글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 10);
			document.getElementById('writer').focus();
			return;
		}
	});
	document.getElementById('writer').addEventListener('mouseup', e => {
		if(e.target.value.length > 10) {
			alert('작성자는 10글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 10);
			document.getElementById('writer').focus();
			return;
		}
	});
	document.getElementById('writer').addEventListener('input', e => {
		if(e.target.value.length > 10) {
			alert('작성자는 10글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 10);
			document.getElementById('writer').focus();
			return;
		}
	});
	// document.getElementById('writer').addEventListener('paste', e => {
	// 	// 붙여넣기된 텍스트 가져오기
	// 	const pastedText = (e.clipboardData || window.clipboardData).getData('text');

	// 	if(pastedText > 10) {
	// 		alert('작성자는 10글자 이내로 제한됩니다.');
	// 		pastedText = pastedText.substr(0, 10);
	// 		e.target.value += pastedText;
	// 		document.getElementById('writer').focus();
	// 		return;
	// 	}
	// });

	document.getElementById('title').addEventListener('keyup', e => {
		if(e.target.value.length > 100) {
			alert('제목은 100글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 100);
			document.getElementById('title').focus();
			return;
		}
	});
	document.getElementById('title').addEventListener('input', e => {
		if(e.target.value.length > 100) {
			alert('제목은 100글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 100);
			document.getElementById('title').focus();
			return;
		}
	});
	document.getElementById('title').addEventListener('mouseup', e => {
		if(e.target.value.length > 100) {
			alert('제목은 100글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 100);
			document.getElementById('title').focus();
			return;
		}
	});

	document.getElementById("password").onkeyup = function () {
		const $password = document.getElementById('password');

		if (pwRegex.test($password.value)) {
			$password.classList.remove('is-invalid');
			$password.classList.add('is-valid');
			document.getElementById('pwInvalidMsg').style.display = 'none';
			document.getElementById('pwValidMsg').style.display = 'block';
		} else {
			$password.classList.remove('is-valid');
			$password.classList.add('is-invalid');
			document.getElementById('pwValidMsg').style.display = 'none';
			document.getElementById('pwInvalidMsg').style.display = 'block';
		}
		if($password.value.length > 20) {
			alert('비밀번호는 20글자 이내로 제한됩니다.');
			$password.value = $password.value.substr(0, 20);
			if (pwRegex.test($password.value)) {
				$password.classList.remove('is-invalid');
				$password.classList.add('is-valid');
				document.getElementById('pwInvalidMsg').style.display = 'none';
				document.getElementById('pwValidMsg').style.display = 'block';
			} else {
				$password.classList.remove('is-valid');
				$password.classList.add('is-invalid');
				document.getElementById('pwValidMsg').style.display = 'none';
				document.getElementById('pwInvalidMsg').style.display = 'block';
			}
			$password.focus();
			return;
		}
	};
	document.getElementById("password").oninput = function () {
		const $password = document.getElementById('password');

		if (pwRegex.test($password.value)) {
			$password.classList.remove('is-invalid');
			$password.classList.add('is-valid');
			document.getElementById('pwInvalidMsg').style.display = 'none';
			document.getElementById('pwValidMsg').style.display = 'block';
		} else {
			$password.classList.remove('is-valid');
			$password.classList.add('is-invalid');
			document.getElementById('pwValidMsg').style.display = 'none';
			document.getElementById('pwInvalidMsg').style.display = 'block';
		}
		if($password.value.length > 20) {
			alert('비밀번호는 20글자 이내로 제한됩니다.');
			$password.value = $password.value.substr(0, 20);
			if (pwRegex.test($password.value)) {
				$password.classList.remove('is-invalid');
				$password.classList.add('is-valid');
				document.getElementById('pwInvalidMsg').style.display = 'none';
				document.getElementById('pwValidMsg').style.display = 'block';
			} else {
				$password.classList.remove('is-valid');
				$password.classList.add('is-invalid');
				document.getElementById('pwValidMsg').style.display = 'none';
				document.getElementById('pwInvalidMsg').style.display = 'block';
			}
			$password.focus();
			return;
		}
	};
	document.getElementById("password").onmouseup = function () {
		const $password = document.getElementById('password');

		if (pwRegex.test($password.value)) {
			$password.classList.remove('is-invalid');
			$password.classList.add('is-valid');
			document.getElementById('pwInvalidMsg').style.display = 'none';
			document.getElementById('pwValidMsg').style.display = 'block';
		} else {
			$password.classList.remove('is-valid');
			$password.classList.add('is-invalid');
			document.getElementById('pwValidMsg').style.display = 'none';
			document.getElementById('pwInvalidMsg').style.display = 'block';
		}
		if($password.value.length > 20) {
			alert('비밀번호는 20글자 이내로 제한됩니다.');
			$password.value = $password.value.substr(0, 20);
			if (pwRegex.test($password.value)) {
				$password.classList.remove('is-invalid');
				$password.classList.add('is-valid');
				document.getElementById('pwInvalidMsg').style.display = 'none';
				document.getElementById('pwValidMsg').style.display = 'block';
			} else {
				$password.classList.remove('is-valid');
				$password.classList.add('is-invalid');
				document.getElementById('pwValidMsg').style.display = 'none';
				document.getElementById('pwInvalidMsg').style.display = 'block';
			}
			$password.focus();
			return;
		}
	}
	// document.getElementById('password').addEventListener('paste', e => {
	// 	// 붙여넣기된 텍스트 가져오기
	// 	const pastedText = (e.clipboardData || window.clipboardData).getData('text');

	// 	if(pastedText > 20) {
	// 		alert('비밀번호는 20글자 이내로 제한됩니다.');
	// 		pastedText = pastedText.substr(0, 20);
	// 		e.target.value += pastedText;
	// 		document.getElementById('title').focus();
	// 		if(pwRegex.test(e.target.value)) {
	// 			e.target.classList.remove('is-invalid');
	// 			e.target.classList.add('is-valid');
	// 			document.getElementById('pwInvalidMsg').style.display = 'none';
	// 			document.getElementById('pwValidMsg').style.display = 'block';
	// 		} else {
	// 			e.target.classList.remove('is-valid');
	// 			e.target.classList.add('is-invalid');
	// 			document.getElementById('pwValidMsg').style.display = 'none';
	// 			document.getElementById('pwInvalidMsg').style.display = 'block';
	// 		}
	// 		return;
	// 	}
	// });

	document.getElementById('content').addEventListener('keyup', e => {
		if(e.target.value.length > 1000) {
			alert('내용은 1000글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 1000);
			document.getElementById('content').focus();
			document.getElementById('content_cnt').textContent = '(' + e.target.value.length + '/1000)';
			return;
		}
	});
	document.getElementById('content').addEventListener('mouseup', e => {
		if(e.target.value.length > 1000) {
			alert('내용은 1000글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 1000);
			document.getElementById('content').focus();
			document.getElementById('content_cnt').textContent = '(' + e.target.value.length + '/1000)';
			return;
		}
	});
	document.getElementById('content').addEventListener('input', e => {
		document.getElementById('content_cnt').textContent = '(' + e.target.value.length + '/1000)';
		if(e.target.value.length > 1000) {
			alert('내용은 1000글자 이내로 제한됩니다.');
			e.target.value = e.target.value.substr(0, 1000);
			document.getElementById('content').focus();
			document.getElementById('content_cnt').textContent = '(' + e.target.value.length + '/1000)';
			return;
		}
	});
	// document.getElementById('content').addEventListener('paste', e => {
	// 	// 붙여넣기된 텍스트 가져오기
	// 	const pastedText = (e.clipboardData || window.clipboardData).getData('text');

	// 	if(pastedText > 1000) {
	// 		alert('내용은 1000글자 이내로 제한됩니다.');
	// 		pastedText = pastedText.substr(0, 1000);
	// 		e.target.value += pastedText;
	// 		document.getElementById('content').focus();
	// 		document.getElementById('content_cnt').textContent = '(' + e.target.value.length + '/1000)'
	// 		return;
	// 	}
	// });

	//비밀번호 스페이스바 막기
    document.getElementById('password').addEventListener('keydown', e => {
      // 스페이스바의 keyCode는 32입니다.
      if (e.keyCode === 32) {
        e.preventDefault(); // 기본 동작(스페이스 입력)을 막음
      }
	});

	const $fileUploadContainer = document.getElementById('file-upload-container');

	//파일 업로드 추가
	document.getElementById('uploadPlusBtn').addEventListener('click', e => {
		e.preventDefault();
		const str = `<br><input type="file" name="file">`;
		$fileUploadContainer.insertAdjacentHTML('beforeend', str);
	});

	//파일 업로드 빼기
	document.getElementById('uploadMinusBtn').addEventListener('click', e => {
		e.preventDefault();
		if($fileUploadContainer.lastElementChild.tagName === 'INPUT') {
			$fileUploadContainer.lastElementChild.remove();
			$fileUploadContainer.lastElementChild.remove();
		}
	});

	//파일 확장자 제어
	document.getElementById('file-upload-container').addEventListener('change', e=> {
		if(!e.target.matches('input')) return;
		const ext = e.target.value.slice(e.target.value.indexOf('.')+1).toLowerCase();

		if(ext !== 'docx' && ext !== 'xls' && ext !== 'hwp' && ext !== 'pdf' && ext !== 'xlsx') {
			alert('문서파일(docx, hwp, pdf, xls, xlsx)만 등록이 가능합니다.');
			e.target.value = '';
			return;
		}
		if(e.target.size > 5*1024*1024) {
			alert('첨부파일의 사이즈는 5MB 이내로 가능합니다.');
			e.target.value = '';
			return;
		}
	});
</script>