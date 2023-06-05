<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
						<c:forEach begin="1" step="+1" end="10">
							<div class="thumbnail-size rounded mb-4">
								<img class="h-100" src="${pageContext.request.contextPath}/img/thumbnail_1.jpg" alt="썸네일">
								<div id="rdnWhlAddr" class="invisible">서울 성동구</div>
								<div id="title" class="invisible">코너키친 갈 사람 여기여기 모여라~!</div>
							</div>
						</c:forEach>
					</div>
					<!-- 파티 리스트 끝 -->

					<!-- 후기 게시판 제목 -->
					<div class="page-header border-bottom border-orange mt-4 mb-4">
						<h2 class="ms-2">
							여러밥 후기
							<a href="${pageContext.request.contextPath}/review/reviewList">
								<small class="text-muted">더보기
									<i class="bi bi-chevron-right"></i>
								</small>
							</a>
						</h2>
					</div>
					<a href="${pageContext.request.contextPath}/store/input">데이터인풋</a>
					<!-- 후기 게시판 제목 끝 -->

					<!-- 모달 -->
					<div class="modal" tabindex="-1">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">Modal title</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<p>Modal body text goes here.</p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary">Save changes</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 모달 끝 -->

					<%@ include file="include/footer.jsp" %>

						<script>

							// 썸네일 클릭 이벤트 설정
							document.getElementById('partyList').addEventListener('click', e => {
								console.log('e.target.currentSrc = ' + e.target.decode());
							});
						</script>