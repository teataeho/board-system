<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ include file="../include/header.jsp" %>

		<div class="container">
			<section id="section">
				<h2 class="text-center border-bottom border-orange pb-3 mb-4">어디서 여러밥하시겠습니까?</h2>
			</section>
			<div class="d-flex justify-content-center">
				<div id="map" class="border border-thick-orange rounded mt-10" style="width: 70%; height: 500px;"></div>
				<select class="form-select" name="uptaeNm" id="uptaeNm">
					<option value="한식">한식</option>
					<option value="경양식">경양식</option>
					<option value="일식">일식</option>
					<option value="분식">분식</option>
					<option value="중국식">중국식</option>
					<option value="기타">기타</option>
				</select>
				<select class="form-select locGu" onchange="categoryChange(this)">
					<option value="" disabled selected hidden>구</option>
					<option value="마포구">마포구</option>
					<option value="서대문구">서대문구</option>
				</select> <select class="form-select" id="addrDong" name="addrDong">
					<option>동을 선택해주세요</option>
				</select>
				<button type="button" id="search">검색</button>
			</div>
			<form action="#" method="post">
				<input type="hidden" id="sno" name="sno">
				<input type="hidden" id="bplcNm" name="bplcNm">
			</form>
		</div>

		<%@ include file="../include/footer.jsp" %>

			<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center: new kakao.maps.LatLng(37.557434302, 126.926960224), // 지도의 중심좌표
						level: 7 // 지도의 확대 레벨
					};

				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center: new kakao.maps.LatLng(37.557434302, 126.926960224), // 지도의 중심좌표
						level: 5 // 지도의 확대 레벨
					};

				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption);

				//모델객체를 가져와서 반복문 처리합니다
				var restaurants = [];

				//검색버튼이 클릭되면 실행되는 이벤트
				document.getElementById('search').addEventListener('click', () => {
					//기존에 있는 마커를 제거
					deleteMarkers(map);

					fetch("${pageContext.request.contextPath}/store/getList/" + document.getElementById('uptaeNm').value + '/' + document.getElementById('addrDong').value, {
						method: 'get',
						headers: {
							'Content-Type': 'application/json'
						}
					})
						.then(res => res.json())
						.then(data => {
							console.log(data);
							restaurants = data; // 가져온 데이터를 restaurants 배열에 할당합니다.

							fetch("${pageContext.request.contextPath}/store/getList/" + e.target.value, {
								method: 'get',
								headers: {
									'Content-Type': 'application/json'
								}
							})
								.then(res => res.json())
								.then(data => {
									console.log(data);
									restaurants = data; // 가져온 데이터를 restaurants 배열에 할당합니다.

									// 마커 생성 및 지도에 표시
									for (var i = 0; i < restaurants.length; i++) {
										(function (restaurant) { // 클로저로 각 마커의 정보 유지

											var geocoder = new kakao.maps.services.Geocoder(); // 좌표계 변환 객체를 생성합니다

											geocoder.addressSearch(restaurant.rdnwhladdr, transCoordCB);

											// 좌표 변환 결과를 받아서 처리할 콜백함수 입니다.
											function transCoordCB(result, status) {
												// 정상적으로 검색이 완료됐으면 
												if (status === kakao.maps.services.Status.OK) {
													// 마커를 변환된 위치에 표시합니다
													var marker = new kakao.maps.Marker({
														position: new kakao.maps.LatLng(result[0].y, result[0]
															.x), // 마커를 표시할 위치입니다
														map: map // 마커를 표시할 지도객체입니다
													});

													// 생성된 마커를 배열에 추가합니다
													markers.push(marker);

										// 마커에 마우스 오버 이벤트를 등록합니다
										kakao.maps.event.addListener(marker, 'mouseover', function () {
											var content = '<div style="padding:5px;font-size:12px;">' + restaurant
												.bplcnm + '<br>★: ' + restaurant.avgRate + '</div>'; // 음식점 이름을 표시할 컨텐츠 HTML
											infowindow.setContent(content); // 인포윈도우에 컨텐츠를 설정합니다
											infowindow.open(map, marker); // 인포윈도우를 표시합니다
										});

													// 마커에 마우스 아웃 이벤트를 등록합니다
													kakao.maps.event.addListener(marker, 'mouseout', function () {
														infowindow.close(); // 인포윈도우를 닫습니다
													});

													// 마커에 클릭 이벤트를 등록합니다.
													kakao.maps.event.addListener(marker, 'click', () => {
														//document.getElementById('sno').value = restaurant.sno;
														//document.getElementById('bplcNm').value = restaurant.bplcnm;

														if (confirm(restaurant.bplcnm + "에서 여러밥하시겠습니까? :)")) {
															location.href = "partyRegister?sno=" + restaurant.sno + "&bplcnm=" + restaurant.bplcnm;
														}
													});
												}
											}

										})(restaurants[i]);
									}
								});

						});

					//기존에 있는 마커를 제거하는 함수
					function deleteMarkers(map) {
						for (var i = 0; i < markers.length; i++) {
							markers[i].setMap(null);
						}
					}
				});

				//셀렉트에 동을 추가하는 함수
				function categoryChange(e) {
					var addrDong_mapo = ["상암동", "성산동", "망원동", "연남동", "동교동", "서교동", "합정동", "상수동", "창전동", "신수동", "노고산동", "대흥동",
						"염리동",
						"용강동", "도화동", "공덕동", "아현동", "신공덕동"
					];
					var addrDong_seodaemun = ["북가좌동", "남가좌동", "홍은동", "홍제동", "연희동", "신촌동", "봉원동", "북아현동", "현저동", "천연동"];

					var target = document.getElementById("addrDong");

					if (e.value == "마포구") var d = addrDong_mapo;
					else if (e.value == "서대문구") var d = addrDong_seodaemun;

					target.options.length = 0;

					for (x in d) {
						var opt = document.createElement("option");
						opt.value = d[x];
						opt.innerHTML = d[x];
						target.appendChild(opt);
					}
				}
			</script>