<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>카테고리로 장소 검색하기</title>

</head>
<body>
	<div id="map" style="width: 100%; height: 700px;"></div>
	<a href="${pageContext.request.contextPath}/store/getList">데이터 받아오기</a>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b8a76526619d3746d10b810c5fd28b62&libraries=services"></script>
	<script>
		// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(37.554487, 126.920528), // 지도의 중심좌표
		        level: 4 // 지도의 확대 레벨
		    };
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);
		
		//모델객체를 가져와서 반복문 처리합니다
		var restaurants= [];
		
		fetch("${pageContext.request.contextPath}/store/getList", {
            method: 'get',
            headers: {
                'Content-Type':'application/json'
             }
        })
		.then(res => res.json())
		.then(data => {
			console.log(data);
			restaurants = data; // 가져온 데이터를 restaurants 배열에 할당합니다.

            // 마커 생성 및 지도에 표시
            for (var i = 0; i < restaurants.length; i++) {
                var restaurant = restaurants[i];
				var geocoder = new kakao.maps.services.Geocoder(); // 좌표계 변환 객체를 생성합니다
				// WTM 좌표를 WGS84 좌표계의 좌표로 변환합니다
				var value = geocoder.transCoord(restaurant.x, restaurant.y, transCoordCB, {
					input_coord: kakao.maps.services.Coords.WTM, // 변환을 위해 입력한 좌표계 입니다
					output_coord: kakao.maps.services.Coords.WGS84 // 변환 결과로 받을 좌표계 입니다 
				});

				console.log(value);

			}
		});
		
		// 좌표 변환 결과를 받아서 처리할 콜백함수 입니다.
		function transCoordCB(result, status) {
		
			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {

				// 마커를 변환된 위치에 표시합니다
				var marker = new kakao.maps.Marker({
					position: new kakao.maps.LatLng(result[0].y, result[0].x), // 마커를 표시할 위치입니다
					map: map // 마커를 표시할 지도객체입니다
				});

				// 마커를 클릭했을 때 인포윈도우를 표시합니다
				kakao.maps.event.addListener(marker, 'click', function () {
					console.log('마커 클릭 이벤트 발생!');
					infowindow.setContent(restaurant.bplcnm);
					infowindow.open(map, marker);
				});

				return result;

			}
		}
		
		    
	</script>
</body>
</html>