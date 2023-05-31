<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ include file="../include/header.jsp" %>

		<div class="container">
			<div class="size"><img src="${pageContext.request.contextPath}/img/ex_carousel1.png" class="d-block w-100"
					alt="메인 이미지1"></div>
			<div class="page-header border-bottom border-orange mb-4">
				<h2 class="text-center ms-2">
					여러밥 모집
				</h2>
			</div>
			<div class="dropdown">
				<button class="btn btn-white border-orange dropdown-toggle" type="button" data-bs-toggle="dropdown"
					aria-expanded="false">
					최신순
				</button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item" href="#">최신순</a></li>
					<li><a class="dropdown-item" href="#"><span class="necessary">핫!</span>한 순</a></li>
				</ul>
			</div>

			<div class="row">
				<div class="col-sm-3">
					<!-- 썸네일 -->
					<img src="${pageContext.request.contextPath}/img/thumbnail_1.jpg" class="d-block w-50">
					<!-- hover 시에 보이게 해줄 예정인 정보들을 미리 담아줄게요. -->
					<p id="rdnWhlAddr" style="display: none;">서울 성동구</p>
					<p id="title" style="display: none;">코너키친 갈 사람 여기여기 붙어라!</p>
					<!-- 긴급할 시 시간 표시 예정 -->
					<p class="time" id="time"></p>
				</div>
			</div>

			<!-- 최상단 이동 버튼 -->
			<button type="button"><img src="${pageContext.request.contextPath}/img/up-arrow.png" alt="위 화살표"></button>

			<!-- 글 작성 버튼 -->
			<button type="button"><img src="${pageContext.request.contextPath}/img/register.png" alt="작성"></button>
		</div>