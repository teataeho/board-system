<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ include file="../include/header.jsp" %>

		<div class="join container">
			<h2 class="title">파티 모집글 작성하기</h2>
			<form action="${pageContext.request.contextPath}/party/partyRegister" method="POST" enctype="multipart/form-data">
				<div class="bigBorder">	
					<div class="smallBorder">
						<div class="border">
							<p>닉네임<span>|</span></p>
							<input type="text" class="form-control userNickName" id="userNick" readonly>
							<input type="hidden" name="writer" id="writer">
						</div>
						<div>
							<div class="border">
								<p>제목<span>|</span></p>
								<input type="text" class="form-title form-control" name="title" id="title"
									placeholder="ex) OOO 같이 갈 사람 구해요~!" autocomplete="off">
							</div>
							<div class="border">
								<p>내용<span>|</span></p>
								<textarea class="form-content form-control" name="content" id="content" cols="10" rows="10"
									placeholder="ex) OO시에 OO에서 만나서 여러밥해요!" autocomplete="off"></textarea>
							</div>
						</div>
						
					<div class="partyPeople">
						<p><span>＃</span>최대 몇 명까지 모이기 원하시나요?</p>
						<select id="max" name="max" class="form-select">
							<option value="2">2명</option>
							<option value="3">3명</option>
							<option value="4">4명</option>
						</select>
					</div>
					<div class="restName">					
						<p><span>＃</span>식당명</p>
						<input type="text" class="form-control restName2" name="bplcNm" id="restName" value="${param.bplcnm}" readonly>
					</div>
				</div>
				
				
				<input type="hidden" name="sno" value="${param.sno}">

				
					<div class="pictures">
						<p>썸네일 사진을 선택해주세요.</p>
						<!-- <input type="checkbox" name="ex-pic1" id="pic1" src="${pageContext.request.contextPath}/img/">
						<input type="image" name="ex-pic2" id="pic2" src="${pageContext.request.contextPath}/img/">
						<input type="image" name="ex-pic3" id="pic3" src="${pageContext.request.contextPath}/img/"> -->
						
						<!-- 사용자 지정 -->
	
						<div class="custom">
							
							<div class="imgSelect">
								<label for="file-upload" class="custom-file-upload">
									<input type="file" name="file" id="file-upload" accept="image/jpg, image/jpeg, image/png"/>
									
									<img id="file-upload-img" src="${pageContext.request.contextPath}/img/upload.png" alt="이미지 선택" />
									<p>첨부하기</p>
								</label>
							</div>
							<span class="warn">*(jpg, jpeg, png) 파일만 가능합니다.</span>
						</div>
					</div>
				</div>

				<button type="submit" id="writeBtn"
					onclick="console.log(document.getElementById('file-upload').value)">등록하기</button>
			</form>
		</div>

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