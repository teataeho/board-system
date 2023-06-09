<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ include file="../include/header.jsp" %>

		<section id="section">
			<h2 class="text-center border-bottom border-orange pb-3 mb-4">여러밥 모집글 작성하기</h2>
		</section>

		<form class="container d-flex flex-column align-items-center"
			action="${pageContext.request.contextPath}/party/partyRegister" method="POST" name="partyRegisterForm"
			enctype="multipart/form-data">
			<div class="d-flex justify-content-center">
				<div class="d-flex flex-column me-4">
					<div class="d-flex justify-content-end align-items-center mb-3">
						<p class="partyRegisterTitle">닉네임<span class="text-orange mx-2">|</span></p>
						<input type="text" class="form-control flex-grow-1" id="userNick" readonly>
						<input type="hidden" name="writer" id="writer">
					</div>
					<div class="d-flex justify-content-end align-items-center mb-3">
						<p class="partyRegisterTitle">식당명<span class="text-orange mx-2">|</span></p>
						<input type="text" class="form-control flex-grow-1" name="bplcNm" id="restName" value="${param.bplcnm}"
							readonly>
					</div>
					<div class="d-flex justify-content-end align-items-center mb-3">
						<p class="partyRegisterTitle">제목<span class="text-orange mx-2">|</span></p>
						<input type="text" class="form-title form-control flex-grow-1" name="title" id="title"
							placeholder="ex) OOO 같이 갈 사람 구해요~!" autocomplete="off">
					</div>
					<div class="d-flex justify-content-end align-items-start mb-3">
						<p class="partyRegisterTitle mt-1">내용<span class="text-orange mx-2">|</span></p>
						<textarea class="form-content form-control flex-grow-1" name="content" id="content" cols="10" rows="10"
							placeholder="ex) OO시에 OO에서 만나서 여러밥해요!" autocomplete="off"></textarea>
					</div>
					<div class="d-flex justify-content-end align-items-center">
						<p class="m-0 flex-grow-1 me-2"><span class="text-orange me-1">＃</span>최대 몇 명까지 모이기 원하시나요?</p>
						<select id="partyRegisterMax" name="max" class="form-select">
							<option value="2">2명</option>
							<option value="3">3명</option>
							<option value="4">4명</option>
						</select>
					</div>
				</div>

					<input type="hidden" name="sno" value="${param.sno}">


				<div id="partyRegisterRight"
					class="d-inline-flex flex-column justify-content-center border-start border-orange ps-4">
					<p class="fw-bold mb-1">썸네일 사진을 선택해주세요. <br> <small class="information">(고르지 않으실 시 기본 썸네일로 자동 적용됩니다.)</small>
					</p>

					<!-- 사용자 지정 -->
					<div class="custom">
						<div class="imgSelect">
							<label for="file-upload" class="text-center border border-orange border-2 rounded w-100">
								<input type="file" name="file" id="file-upload" class="invisible"
									accept="image/jpg, image/jpeg, image/png" />

									<img id="file-upload-img" src="${pageContext.request.contextPath}/img/upload.png" alt="이미지 선택" />
								<p class="my-3 text-orange">첨부하기</p>
							</label>
						</div>
						<span class="necessary mt-1">*(jpg, jpeg, png) 파일만 가능합니다.</span>
					</div>
				</div>
			</div>

			<button type="submit" id="writeBtn" class="btn btn-orange mt-4"
					onclick="console.log(document.getElementById('file-upload').value)">등록하기</button>
		</form>

		<%@ include file="../include/footer.jsp" %>

		<style>
			.custom-file-upload {
				display: inline-block;
				cursor: pointer;
			}

			.custom-file-upload input[type="file"] {
				display: none;
			}
		</style>

		<script>
			console.log('${userInfo.userId}');
			document.getElementById('writer').value = '${userInfo.userId}';
			document.getElementById('userNick').value = '${userInfo.userNick}';

			//자바 스크립트 파일 미리보기 기능
			function readURL(input) {
				if (input.files && input.files[0]) {

					var reader = new FileReader(); //비동기처리를 위한 파읽을 읽는 자바스크립트 객체
					//readAsDataURL 메서드는 컨텐츠를 특정 Blob 이나 File에서 읽어 오는 역할 (MDN참조)
					reader.readAsDataURL(input.files[0]);

					reader.onload = e => { //읽기 동작이 성공적으로 완료 되었을 때 실행되는 익명함수
						//$('#fileImg').attr("src", event.target.result);
						document.getElementById('file-upload-img').setAttribute('src', e.target.result);
						document.getElementById('file-upload').value = e.target.result;
						console.log(e.target)//event.target은 이벤트로 선택된 요소를 의미
					}
				}
			}
			document.getElementById('file-upload').onchange = function () {
				readURL(this); //this는 #file자신 태그를 의미	        
			}
		</script>