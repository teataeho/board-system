<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
				</div>

				<!-- 파티 리스트 -->
				<div class="partyContainer">
					<div id="partyList" class="d-inline-flex flex-wrap">
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
							<div class="modal-img-size"><img id="modalImg" src="" alt="이미지"></div>
							<div class="modal-header d-flex align-items-center shadow">
								<input type="hidden" id="hiddenPartyNo">
								<input type="hidden" id="hiddenUserId">
								<h5 class="modal-title me-auto" id="staticBackdropLabel">Modal title</h5>
								<a href="" id="like"><i class="bi bi-heart text-danger"></i></a>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<span class="content"></span> <br>
							</div>
							<div class="modal-footer d-flex flex-nowrap justify-content-between border-top border-light-orange">
								<div class="modal-footer-left">
									<span>식당이름 : </span><span class="res-name"></span> <br>
									<span>정원 : </span><span class="attendedNum"></span> / <span class="max"></span>명
								</div>
								<button type="button" class="modalBtn btn btn-orange"></button>
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
									if (vo.fileName === null) {
										fileStr = `${pageContext.request.contextPath}/party/getImg/thumbnail_3.jpg`;
									} else {
										fileStr = `${pageContext.request.contextPath}/party/getImg/` + vo.fileName;
									}
									str +=
										`<div class="grid">
										<figure class="rounded effect-zoe">
											<div class="position">
												<img id="` + vo.partyNo + `" src="` + fileStr + `" alt="썸네일">
											</div>
											<figcaption class="d-inline-flex flex-wrap justify-content-between align-items-end">
												<h2>
													<span class="text-orange">`+ vo.uptaeNm + ` · ` + (vo.rdnWhlAddr).slice((vo.rdnWhlAddr).indexOf("(") + 1, -1) + `</span> <br>
													<div class="text-truncate">
													` + vo.title + `
													</div>
												</h2>
												<p class="icon-links d-flex justify-content-start align-items-center">
													<i class="bi bi-heart-fill text-danger d-inline-block"></i>
													<span class="likeCount" data-partyNo="`+ vo.partyNo + `">` + vo.likeCount + `</span>
												</p>
											</figcaption>
										</figure>
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
					const $modalBtn = document.querySelector('.modalBtn');

					// 글 상세보기
					let uid = '${userInfo.userId}';
					document.getElementById('partyList').addEventListener('click', e => {
						if (!e.target.matches('img')) return;
						else if (uid === '') {
							alert('로그인이 필요한 서비스입니다. :)');
							location.href = '${pageContext.request.contextPath}/user/userLogin';
							return;
						}

						fetch('content/' + e.target.id + '/' + uid)
							.then(res => res.json())
							.then(data => {
								document.getElementById('hiddenPartyNo').value = data.partyNo
								document.getElementById('hiddenUserId').value = data.writer;
								document.querySelector('.modal-title').textContent = data.title;
								document.querySelector('.res-name').textContent = data.bplcNm;
								document.querySelector('.content').textContent = data.content;
								document.querySelector('.max').textContent = data.max;
								document.querySelector('.attendedNum').textContent = data.attendedNum + 1;
								console.log(data.attended);

								if (data.fileName === null) {
									document.getElementById('modalImg').setAttribute('src', '${pageContext.request.contextPath}/party/getImg/thumbnail_3.jpg');
								} else {
									document.getElementById('modalImg').setAttribute('src', '${pageContext.request.contextPath}/party/getImg/' + data.fileName);
								}

								//좋아요 true, false
								if (data.isLike === 1) { // 하트 채워짐
									document.querySelector('#like i').classList.remove('bi-heart');
									document.querySelector('#like i').classList.add('bi-heart-fill');
								} else {
									document.querySelector('#like i').classList.remove('bi-heart-fill');
									document.querySelector('#like i').classList.add('bi-heart');
								}

								// 버튼 선택
								if ($modalBtn.classList.contains('btn-outline-orange')) {
									$modalBtn.classList.remove('btn-outline-orange');
									$modalBtn.classList.add('btn-orange');
								} else if ($modalBtn.disabled) {
									$modalBtn.disabled = false;
								}

								if (uid === data.writer) {
									$modalBtn.id = 'deleteParty';
									$modalBtn.textContent = '삭제';
								} else if (data.attended === 0) {
									if (data.attendedNum >= data.max - 1) {
										$modalBtn.id = 'attend';
										$modalBtn.disabled = true;
										$modalBtn.textContent = '풀파티';
									} else {
										$modalBtn.id = 'attend';
										$modalBtn.textContent = '참가하기';
									}
								} else {
									$modalBtn.id = 'cancelAttend';
									$modalBtn.classList.remove('btn-orange');
									$modalBtn.classList.add('btn-outline-orange');
									$modalBtn.textContent = '참가 취소';
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
						if (!e.target.matches('i')) return;

						//좋아요
						if (document.querySelector('#like i').classList.contains('bi-heart')) {
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
									if (text !== 'success') {
										alert('이미 좋아요를 한 게시물이거나 알 수 없는 오류로 인해 좋아요가 취소되었습니다.');
									} else {
										for (heart of [...document.querySelectorAll('.likeCount')]) {
											document.querySelector('#like i').classList.remove('bi-heart')
											document.querySelector('#like i').classList.add('bi-heart-fill');
											if (heart.dataset.partyno == document.getElementById('hiddenPartyNo').value) {
												heart.textContent++;
											}
										}
									}
								})
						}

						// 좋아요 삭제
						if (document.querySelector('#like i').classList.contains('bi-heart-fill')) {
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
									if (text !== 'success') {
										alert('삭제가 안됐습니다.');
									} else {
										for (heart of [...document.querySelectorAll('.likeCount')]) {
											document.querySelector('#like i').classList.remove('bi-heart-fill')
											document.querySelector('#like i').classList.add('bi-heart');
											if (heart.dataset.partyno == document.getElementById('hiddenPartyNo').value) {
												heart.textContent--;
											}
										}
									}
								})
						}
					})
				</script>