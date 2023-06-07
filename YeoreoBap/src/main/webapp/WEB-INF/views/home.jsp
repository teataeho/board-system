<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
		<%@ include file="include/header.jsp" %>
			<div class="wrap">

				<div class="container">
					<!-- 메인 캐러셀 -->
					<div id="carouselExampleControls" class="active carousel slide" data-bs-ride="carousel">
						<div class="size mb-5">
							<div class="carousel-inner">
								<div class="carousel-item active" data-bs-interval="3000">
									<img src="${pageContext.request.contextPath}/img/ex_carousel1.png" class="d-block w-100 h-100"
										alt="메인 이미지1">
								</div>
								<div class="carousel-item" data-bs-interval="3000">
									<img src="${pageContext.request.contextPath}/img/ex_carousel2.png" class="d-block w-100 h-100"
										alt="메인 이미지2">
								</div>
								<div class="carousel-item" data-bs-interval="3000">
									<img src="${pageContext.request.contextPath}/img/ex_carousel3.png" class="d-block w-100 h-100"
										alt="메인 이미지3">
								</div>
							</div>
						</div>
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls"
							data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls"
							data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
					<!-- 메인 캐러셀 끝 -->

					<!-- 파티 게시판 제목 -->
					<div class="page-header border-bottom border-orange mb-4">
						<h2 class="ms-2">
							여러밥 모집
							<a href="${pageContext.request.contextPath}/party/partyList">
								<small class="text-muted">더보기
									<i class="bi bi-chevron-right"></i>
								</small>
							</a>
						</h2>
					</div>
					<!-- 파티 게시판 제목 끝 -->

					<!-- 파티 리스트 -->
					<div id="partyList" class="d-inline-flex flex-wrap justify-content-around p-0">
					</div>
					<!-- 파티 리스트 끝 -->

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
									<span>식당 이름 : </span><span class="res-name"></span> <br>
									<span class="content"></span> <br>
									<span>정원 : </span><span class="max"></span> <br><br>
									<a href="" id="like"><i class="bi bi-heart text-danger"></i></a>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">모달 누르면 그냥 지워지는 버튼</button>
								</div>
							</div>
						</div>
					</div>

					<!-- 후기 게시판 제목 -->
        <div class="page-header border-bottom border-orange mt-4 mb-4">
            <h2 class="ms-2">
                여러밥 후기
                <a href="${pageContext.request.contextPath}/review/reviewList">
                    <small class="text-muted">더보기 <i class="bi bi-chevron-right"></i></small>
                </a>
            </h2>
        </div>
        <!-- 후기 게시판 제목 끝 -->

        <table class="table table-bordered table-hover" id="table">
			
		</table>
    </div>
</div>

					<%@ include file="include/footer.jsp" %>

				</div>

				<script>
					// 리스트
					let str = '';
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
														<span class="text-orange">`+ vo.rdnWhlAddr.slice(-4, -1) + `</span> <br>
														<div class="text-truncate">
														` + vo.title + `
														</div>
													</h2>
													<p class="icon-links d-flex justify-content-start align-items-center">
														<i class="bi bi-heart-fill text-danger d-inline-block"></i>
														<span>` + vo.likeCount + `</span>
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

					fetch('${pageContext.request.contextPath}/review/reviewList2/')
							.then(res => res.text())
							.then(data => {
								const table = document.getElementById('table');
								table.innerHTML = data;
							});
				</script>