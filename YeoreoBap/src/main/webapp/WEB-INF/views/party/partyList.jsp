<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	<%@ include file="../include/header.jsp" %>

		<div class="container">

			<!-- 파티 모집글 작성을 유도하는 글 -->
			<div class="size">
				<img src="${pageContext.request.contextPath}/img/ex_carousel1.png" class="d-block w-100" alt="메인 이미지1">
			</div>

			<!-- 최상단 이동 버튼 클릭 시 이동 위치 -->
			<a id="top" class="d-block w-100"></a>

			<div class="page-header border-bottom border-orange mb-4 partyList">
				<h2 class="text-center ms-2">
					여러밥 모집
				</h2>

				<!-- 정렬 선택 버튼 -->
				<div id="orderBy" class="dropdown">
					<button class="btn btn-white border-orange dropdown-toggle text-orange" type="button"
						data-bs-toggle="dropdown" aria-expanded="true">
						최신순
					</button>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">최신순</a></li>
						<li><a class="dropdown-item" href="#"><span class="necessary">핫!</span>한 순</a></li>
					</ul>
				</div>
			</div>
			

			<!-- 파티 리스트 -->
			<div class="partyContainer">
				<div id="partyList" class="d-inline-flex flex-wrap p-0">
				</div>
				<div class="partyListStickyBtns">
					<div class="stickyButtons">
						<!-- 최상단 이동 버튼 -->
						<a href="#top" class="toTheTop"><i class="bi bi-arrow-up-short"></i></a>
						<!-- 글 작성 버튼 -->
						<a href="${pageContext.request.contextPath}/party/map" id="register"><i class="bi bi-pencil"></i></a>
					</div>
				</div>
			</div>
			<!-- 파티 리스트 끝 -->
		</div>
		<%@ include file="../include/footer.jsp" %>

			<!-- 모달달 -->
			<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
				aria-labelledby="staticBackdropLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<input type="hidden" id="hiddenPartyNo">
							<input type="hidden" id="hiddenUserId">
							<h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<span>식당이름</span><span class="res-name"></span>		<br>
							<span class="content"></span>		<br>
							<span>정원</span><span class="max"></span>	<br><br>
							<a href="#" id="like" class="text-danger"><i class="bi bi-heart"></i></a>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">모달 누르면 그냥 지워지는 버튼</button>
						</div>
					</div>
				</div>
			</div>
			</div>




			<script>
				// 리스트
				let str = '';
				let fileStr = '';
				let page = 1;
				let isFinish = false;
				const $partyList = document.getElementById('partyList');
				const $stickyButtons = document.querySelector('.stickyButtons');
				getList(1, true);

				function getList(page, reset) {
					str = '';
					console.log('page: ' + page);
					console.log('reset: ' + reset);

					fetch('${pageContext.request.contextPath}/party/partyList/' + page)
						.then(res => res.json())
						.then(list => {
							console.log(list);
							console.log(list.length);
							if (list.length === 0) isFinish = true;

							if (reset) {
								while ($partyList.firstChild) {
									$partyList.firstChild.remove();
								}
								page = 1;
							}

							for (vo of list) {								
								if(vo.fileName === null) {
									fileStr = `${pageContext.request.contextPath}/party/getImg/thumbnail_3.jpg`;
								} else {
									fileStr = `${pageContext.request.contextPath}/party/getImg/` + vo.fileName;
								}
								str +=
									`<div class="thumbnail-size rounded d-flex justify-content-center">
										<div class="gradient"></div>
										<img class="h-100"  id="` + vo.partyNo + `" src="` + fileStr + `" alt="썸네일">
									</div>`;
							}

							if (!reset) {
								$partyList.insertAdjacentHTML('beforeend', str);
							} else {
								$partyList.insertAdjacentHTML('afterbegin', str);
							}

						}); //end fetch

				} //end getList

				const handleScroll = _.throttle(() => {
					console.log('throttle activate!');
					const scrollPosition = window.pageYOffset;
					const height = document.body.offsetHeight;
					const windowHeight = window.innerHeight;

					if (!isFinish) {
						if (scrollPosition + windowHeight >= height * 0.9) {
							console.log('next Page call!');
							getList(++page, false);
						}
					}
				}, 1000);

				window.addEventListener('scroll', handleScroll);

				// 모달달
				var modal = new bootstrap.Modal(document.querySelector('.modal'));
				const $modalFooter = document.querySelector('.modal-footer');

				// 마우스 호버 시 약간의 정보 뜨기
				document.getElementById('partyList').addEventListener('mouseover', e => {
					if (!e.target.matches('img')) return;
					console.log(e.target.previousSibling.previousSibling);

				});

				// 글 상세보기
				let uid = '${userInfo.userId}';
				document.getElementById('partyList').addEventListener('click', e => {
					if (uid === '') {
						alert('로그인 후 이용해주세요! :(');
						location.href = '${pageContext.request.contextPath}/user/userLogin';
						return;
					}
					console.log('e.target : ' + e.target);

					$modalFooter.removeChild($modalFooter.lastElementChild);

					fetch('content/' + e.target.id + '/' + uid)
						.then(res => res.json())
						.then(data => {
							document.getElementById('hiddenPartyNo').value = data.partyNo
							document.getElementById('hiddenUserId').value = data.writer;
							document.querySelector('.modal-title').textContent = data.title;
							document.querySelector('.res-name').textContent = data.bplcNm;
							document.querySelector('.content').textContent = data.content;
							document.querySelector('.max').textContent = data.max + '명';
							console.log(data.attended);
							//좋아요 true, false
							if(data.isLike === 1) {
								document.querySelector('#like i').classList.remove('bi-heart');
								document.querySelector('#like i').classList.add('bi-heart-fill');
							} else {
								document.querySelector('#like i').classList.remove('bi-heart-fill');
								document.querySelector('#like i').classList.add('bi-heart');								
							}

							// 버튼 선택
							if (uid === data.writer) {
								$modalFooter.insertAdjacentHTML('beforeend',
									`<button type="button" class="btn btn-primary" id="deleteParty">삭제</button>`);
							} else if (data.attended === 0) {
								if (data.attendedNum >= data.max - 1) {
									$modalFooter.insertAdjacentHTML('beforeend',
										`<button type="button" class="btn btn-primary" id="attend" disabled>풀파티</button>`);
								} else {
									$modalFooter.insertAdjacentHTML('beforeend',
										`<button type="button" class="btn btn-primary" id="attend">참가</button>`);
								}
							} else {
								$modalFooter.insertAdjacentHTML('beforeend',
									`<button type="button" class="btn btn-primary" id="cancelAttend">참가취소</button>`);
							}
						});

					modal.show();
				});

				$modalFooter.addEventListener('click', e => {
					// 참가
					if (e.target.id === 'attend') {
						fetch('attend', {
							method: 'post',
							headers: {
								'Content-Type': 'application/json'
							},
							body: JSON.stringify({
								'userId': uid,
								'partyNo': document.getElementById('hiddenPartyNo').value
							})
						})
							.then(res => res.text())
							.then(text => {
								if (text === 'success') {
									alert('파티에 참가하셨습니다.');
									modal.hide();
								} else {
									alert('파티 참가에 실패하셨습니다. 다시 시도해주세요.');
								}
							})
					}

					// 참가 취소
					if (e.target.id === 'cancelAttend') {
						fetch('cancelAttend', {
							method: 'delete',
							headers: {
								'Content-Type': 'application/json'
							},
							body: JSON.stringify({
								'userId': uid,
								'partyNo': document.getElementById('hiddenPartyNo').value
							})
						})
							.then(res => res.text())
							.then(text => {
								if (text === 'success') {
									alert('파티에서 나오셨습니다.');
									modal.hide();
								}
							})
					}

					// 삭제
					if (e.target.id === 'deleteParty') {
						if (confirm('정말로 파티를 해체하시겠습니까?')) {
							location.href = 'delete/' + document.getElementById('hiddenPartyNo').value;
						}
					}
				});

				//좋아요
				document.getElementById('like').addEventListener('click', e => {
					e.preventDefault();
					if(!e.target.matches('i')) return;
					//좋아요 등록
					if(document.querySelector('#like i').classList.contains('bi-heart')) {
						fetch('${pageContext.request.contextPath}/like/partyLike', {
								method: 'post',
								headers: {
									'Content-Type': 'application/json'
								},
								body: JSON.stringify({
									'userId': uid,
									'partyNo': document.getElementById('hiddenPartyNo').value
								})
							})
						.then(res => res.text())
						.then(text => {
							if(text !== 'success') {
								alert('이미 좋아요를 한 게시물이거나 알 수 없는 오류로 인해 좋아요가 취소되었습니다.');
							} else {
								document.querySelector('#like i').classList.remove('bi-heart')
								document.querySelector('#like i').classList.add('bi-heart-fill');
							}
						})
					}
					//좋아요 삭제
					if(document.querySelector('#like i').classList.contains('bi-heart-fill')) {
						fetch('${pageContext.request.contextPath}/like/deletePartyLike', {
								method: 'post',
								headers: {
									'Content-Type': 'application/json'
								},
								body: JSON.stringify({
									'userId': uid,
									'partyNo': document.getElementById('hiddenPartyNo').value
								})
							})
						.then(res => res.text())
						.then(text => {
							if(text !== 'success') {
								alert('삭제가 안됐습니다.');
							} else {
								document.querySelector('#like i').classList.remove('bi-heart-fill')
								document.querySelector('#like i').classList.add('bi-heart');
							}
						})
					}
				})
			</script>