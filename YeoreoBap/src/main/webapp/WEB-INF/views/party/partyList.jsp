<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ include file="../include/header.jsp" %>

		<div class="container">
			<div class="size"><img src="${pageContext.request.contextPath}/img/ex_carousel1.png" class="d-block w-100"
					alt="메인 이미지1"></div>
			<div class="page-header border-bottom border-orange mb-4 partyList">
				<h2 class="text-center ms-2">
					여러밥 모집
				</h2>

				<!-- 정렬 선택 버튼 -->
				<div id="orderBy" class="dropdown">
					<button class="btn btn-white border-orange dropdown-toggle text-orange" type="button"
						data-bs-toggle="dropdown" aria-expanded="false">
						최신순
					</button>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#">최신순</a></li>
						<li><a class="dropdown-item" href="#"><span class="necessary">핫!</span>한 순</a></li>
					</ul>
				</div>
			</div>

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

			<!-- <div class="row">
						<div class="col-sm-3">
							썸네일
							<img src="${pageContext.request.contextPath}/img/thumbnail_1.jpg" class="d-block w-50">
					hover 시에 보이게 해줄 예정인 정보들을 미리 담아줄게요.
								<p id="rdnWhlAddr" style="display: none;">서울 성동구</p>
								<p id="title" style="display: none;">코너키친 갈 사람 여기여기 붙어라!</p>
					긴급할 시 시간 표시 예정 
							<p class="time" id="time"></p>
						</div>
			</div> -->

			<!-- 최상단 이동 버튼 -->
			<button type="button" class="text-orange border border-orange"><i class="bi bi-arrow-up-short"></i></button>

			<!-- 글 작성 버튼 -->
			<button type="button" class="text-orange border border-orange"><i class="bi bi-pencil"></i></button>

			<%@ include file="../include/footer.jsp" %>
		</div>

		<script>
			document.getElementById('register').addEventListener('click', () => {
				location.href = '${pageContext.request.contextPath}/party/map';
			})
		</script>