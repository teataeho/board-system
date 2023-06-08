<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<div class="container p-0 my-4">

			<!-- Footer -->
			<footer class="text-center text-lg-start black" style="background-color: white">

				<div class="container p-0 text-center text-md-start mt-5 border-top border-2 border-orange">
					<!-- Grid row -->
					<div class="row mt-3">
						<!-- Grid column -->
						<div class="d-none d-md-block col-md-2 col-lg-2 col-xl-2 mx-auto mb-0">
							<!-- Content -->
							<h6 class="text-uppercase fw-bold" style="text-align:center">혼밥말고여러밥!</h6>
							<hr class="mb-2 mt-0 d-inline-block mx-auto" />
							<div class="img">
								<img src="${pageContext.request.contextPath}/img/long_logo.png"
									class="d-flex align-items-center mb-3 link-dark text-decoration-none"
									style="width: 100px; margin: 0 auto;"> </img>
							</div>
						</div>
						<!-- Grid column -->

						<!-- Grid column -->
						<div class="d-none d-md-block col-md-3 col-lg-3 col-xl-3 mx-auto mb-3">
							<!-- Links -->
							<h6 class="text-uppercase fw-bold">About</h6>
							<hr class="mb-2 mt-0 d-inline-block mx-auto" />
							<p id="p">대표: 김태호</p>
							<p id="p">Tel : 02-716-1234</p>
							<p id="p">이메일 : yeoreobap@naver.com</p>
							<p id="p">주소 : 서울특별시 마포구 백범로 23, 3층 (우)04108</p>
						</div>
						<!-- Grid column -->

						<!-- Grid column -->
						<div class="col-md-2 col-lg-2 col-xl-2 mx-auto mb-md-0 mb-2">
							<!-- Links -->
							<h6 class="text-uppercase fw-bold">Contact</h6>
							<hr class="mb-2 mt-0 d-inline-block mx-auto" />

							<p id="p">
								<a href="#">Home</a>
							</p>
							<p id="p">
								<a href="#">제휴제안</a>
							</p>
							<p id="p">
								<a href="#">이용약관</a>
							</p>
							<p id="p">
								<a href="#">개인정보처리방침</a>
							</p>
							<p id="p">
								<a href="#">고객센터</a>
							</p>


						</div>
						<!-- Grid column -->
					</div>
					<!-- Grid row -->
				</div>

				<!-- Copyright -->
				<div class="text-center mt-3 d-flex justify-content-center align-items-center"
					style="height: 55px; background-color: #F4B183">
					<p id="p" class="text-white lh-lg">Copyright©yeoreobap ALL Rights Reserved.</p>
				</div>
				<!-- Copyright -->
			</footer>
			<!-- Footer -->

		</div>
		<!-- End of .container -->

		<script>
			document.querySelector('footer').addEventListener('click', e => {
				e.preventDefault();
			});
		</script>