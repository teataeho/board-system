<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="include/header.jsp"%>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Document</title>

<!-- reset css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<!-- css 디자인 -->
<link href="${pageContext.request.contextPath }/css/style.css"
	rel="stylesheet">
<!-- bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

</head>


<body>

	<div class="wrap">

		<div class="container">
			<!--section main-->
			<section class="main">
				<!-- 메인 케러셀 -->
				<div id="carouselExampleControls" class="active carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active" data-bs-interval="3000">
							<img
								src="${pageContext.request.contextPath }/img/ex_carousel1.png"
								class="d-block w-100" alt="메인 이미지1">
						</div>
						<div class="carousel-item" data-bs-interval="3000">
							<img
								src="${pageContext.request.contextPath }/img/ex_carousel2.png"
								class="d-block w-100" alt="메인 이미지2">
						</div>
						<div class="carousel-item" data-bs-interval="3000">
							<img
								src="${pageContext.request.contextPath }/img/ex_carousel3.png"
								class="d-block w-100" alt="메인 이미지3">
						</div>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleControls" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
				<!-- end 메인 케러셀 -->

			</section>
			<!--end section main-->
			<!--section partyList-->
			<div class="partyMenu">
				<h2>파티 모집<a href="${pageContext.request.contextPath}/party/partyList">더 많은 파티 보기</a></h2>
				<div class="hotParty partyList">
					<h3>현재 핫!한 동행!</h3>
					<div class="boxes">
						<div class="hotBox box"
							style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
							<div class="innerBox">
								<div class="profile">사진</div>
								<div class="detail">
									<span class="location">서울 성동구</span>
									<span class="restaurant">코너키친 갈 사람</span>
								</div>
							</div>
						</div>
						<div class="hotBox box"
							style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
							<div class="innerBox">
								<div class="profile">사진</div>
								<div class="detail">
									<span class="location">서울 성동구</span>
									<span class="restaurant">코너키친 갈 사람</span>
								</div>
							</div>
						</div>
						<div class="hotBox box"
							style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
							<div class="innerBox">
								<div class="profile">사진</div>
								<div class="detail">
									<span class="location">서울 성동구</span>
									<span class="restaurant">코너키친 갈 사람</span>
								</div>
							</div>
						</div>
						<div class="hotBox box"
							style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
							<div class="innerBox">
								<div class="profile">사진</div>
								<div class="detail">
									<span class="location">서울 성동구</span>
									<span class="restaurant">코너키친 갈 사람</span>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="hurryParty partyList">
					<h3>마감이 임박한 동행!</h3>
					<div class="boxes">
						<div class="timeBox">
							<div class="hurryBox box"
								style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
								<div class="innerBox">
									<div class="profile">사진</div>
									<div class="detail">
										<span class="location">서울 성동구</span>
										<span class="restaurant">코너키친 갈 사람</span>
									</div>
								</div>
							</div>
							<span class="time">남은시간</span>
						</div>
						<div class="timeBox">
							<div class="hurryBox box"
								style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
								<div class="innerBox">
									<div class="profile">사진</div>
									<div class="detail">
										<span class="location">서울 성동구</span>
										<span class="restaurant">코너키친 갈 사람</span>
									</div>
								</div>
							</div>
							<span class="time">남은시간</span>
						</div>
						<div class="timeBox">
							<div class="hurryBox box"
								style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
								<div class="innerBox">
									<div class="profile">사진</div>
									<div class="detail">
										<span class="location">서울 성동구</span>
										<span class="restaurant">코너키친 갈 사람</span>
									</div>
								</div>
							</div>
							<span class="time">남은시간</span>
						</div>
						<div class="timeBox">
							<div class="hurryBox box"
								style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
								<div class="innerBox">
									<div class="profile">사진</div>
									<div class="detail">
										<span class="location">서울 성동구</span>
										<span class="restaurant">코너키친 갈 사람</span>
									</div>
								</div>
							</div>
							<span class="time">남은시간</span>
						</div>
					</div>
				</div>

				<div class="localParty partyList">
					<h3>우리 동네 동행!</h3>
					<div class="boxes">
						<div class="locBox box"
							style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
							<div class="innerBox">
								<div class="profile">사진</div>
								<div class="detail">
									<span class="location">서울 성동구</span>
									<span class="restaurant">코너키친 갈 사람</span>
								</div>
							</div>
						</div>
						<div class="locBox box"
							style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
							<div class="innerBox">
								<div class="profile">사진</div>
								<div class="detail">
									<span class="location">서울 성동구</span>
									<span class="restaurant">코너키친 갈 사람</span>
								</div>
							</div>
						</div>
						<div class="locBox box"
							style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
							<div class="innerBox">
								<div class="profile">사진</div>
								<div class="detail">
									<span class="location">서울 성동구</span>
									<span class="restaurant">코너키친 갈 사람</span>
								</div>
							</div>
						</div>
						<div class="locBox box"
							style="background-image:url(${pageContext.request.contextPath}/img/party.png); background-size: cover">
							<div class="innerBox">
								<div class="profile">사진</div>
								<div class="detail">
									<span class="location">서울 성동구</span>
									<span class="restaurant">코너키친 갈 사람</span>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>

			<!--end section partyLlist-->
		</div>
	</div>



	<!-- Bootstrap’s JS. -->
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
</body>



