<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<%@ include file="include/header.jsp" %>
			<div class="wrap">

				<div class="container">
					<!--section main-->
					<section class="main">
						<!-- 메인 케러셀 -->
						<div id="carouselExampleControls" class="active carousel slide" data-bs-ride="carousel">
							<div class="size">
								<div class="carousel-inner">
									<div class="carousel-item active" data-bs-interval="3000">
										<img src="${pageContext.request.contextPath }/img/ex_carousel1.png" class="d-block w-100 h-100"
											alt="메인 이미지1">
									</div>
									<div class="carousel-item" data-bs-interval="3000">
										<img src="${pageContext.request.contextPath }/img/ex_carousel2.png" class="d-block w-100 h-100"
											alt="메인 이미지2">
									</div>
									<div class="carousel-item" data-bs-interval="3000">
										<img src="${pageContext.request.contextPath }/img/ex_carousel3.png" class="d-block w-100 h-100"
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
						<!-- end 메인 케러셀 -->
					</section>
					<!--end section main-->

					<!-- 파티 게시판 -->
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

					<div class="d-inline-flex flex-wrap justify-content-around p-0">
						<c:forEach begin="1" step="+1" end="10">
							<div class="thumbnail-size rounded mb-4">
								<img class="h-100" src="${pageContext.request.contextPath}/img/thumbnail_1.jpg" alt="썸네일">
								<div id="rdnWhlAddr" class="invisible">서울 성동구</div>
								<div id="title" class="invisible">코너키친 갈 사람 여기여기 모여라~!</div>
							</div>
						</c:forEach>
					</div>

					<!-- 후기 게시판 -->
					<div class="page-header border-bottom border-orange mt-5 mb-4">
						<h2 class="ms-2">
							여러밥 후기
							<a href="${pageContext.request.contextPath}/review/reviewList">
								<small class="text-muted">더보기
									<i class="bi bi-chevron-right"></i>
								</small>
							</a>
						</h2>
					</div>

					<%@ include file="include/footer.jsp" %>

						<!-- Bootstrap’s JS. -->
						<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
							integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
							crossorigin="anonymous"></script>
						<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
							integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
							crossorigin="anonymous"></script>
						<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
							integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
							crossorigin="anonymous"></script>