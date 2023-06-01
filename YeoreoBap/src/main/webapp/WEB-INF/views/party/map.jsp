<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<title>카테고리로 장소 검색하기</title>

</head>

<%@ include file="../include/header.jsp" %>

<body>

	<div class="wrap">
		<div id="map" style="width: 100%; height: 700px;"></div>
		<form action='#' id="uptae">
			<input type="radio" name="uptaeNm" value="한식"> 한식
			<input type="radio" name="uptaeNm" value="경양식"> 경양식
			<input type="radio" name="uptaeNm" value="일식"> 일식
			<input type="radio" name="uptaeNm" value="분식"> 분식
			<input type="radio" name="uptaeNm" value="중국식"> 중국식
			<input type="radio" name="uptaeNm" value="기타"> 기타
		</form>
		<form action="#" method="post">
			<input type="hidden" id="sno" name="sno">
			<input type="hidden" id="bplcNm" name="bplcNm">
		</form>
	</div>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b8a76526619d3746d10b810c5fd28b62&libraries=services"></script>
	<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({
			zIndex: 1
		});

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			mapOption = {
				center: new kakao.maps.LatLng(37.55708901058267, 126.92412692146488), // 지도의 중심좌표
				level: 5 // 지도의 확대 레벨
			};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		//모델객체를 가져와서 반복문 처리합니다
		var restaurants = [];

		// 지도에 표시된 마커 객체를 가지고 있을 배열입니다
		var markers = [];

		//업태명이 클릭되면 실행되는 이벤트
		document.getElementById('uptae').addEventListener('click', e => {
			if(!e.target.matches('input')) return;

			//기존에 있는 마커를 제거
			deleteMarkers(map);

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
											.bplcnm + '</div>'; // 음식점 이름을 표시할 컨텐츠 HTML
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

										if(confirm(restaurant.bplcnm + "를 선택하시겠습니까?")) {
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
	</script>
</body>

</html>
