<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script>
var g_map;
var items;
var mapOption = {
   center : new kakao.maps.LatLng(37.502231, 127.039549),
   level : 2
};
var markers = [];

window.addEventListener("load", function() {
   items = [1,2,3,4,5,6];
   checkbox();
});

function checkbox(){
      items= [];
      $('input[name="menu"]:checked').each(function() {
         items.push($(this).val());
      });

   makeMap(mapOption);
   makeMarkers(items);
   makeMarkerListener();
}


function makeMap(mapOption) {
   var mapContainer = document.getElementById('map');
   g_map = new kakao.maps.Map(mapContainer, mapOption);
   g_map.setMinLevel(1);
   g_map.setMaxLevel(3);
   g_map.setZoomable(true);
};

function makeMarkers(items) {

   var mapBound = g_map.getBounds();
   var latLngNE = mapBound.getNorthEast();
   var latLngSW = mapBound.getSouthWest();



   var bounds = {
         "E" : latLngNE.getLng(),
         "N" : latLngNE.getLat(),
         "S" : latLngSW.getLat(),
         "W" : latLngSW.getLng(),
         items};
   $.ajax({
      url : 'getMarkers.do',
      type : 'post',
      dataType : 'json',
      contentType : 'application/json',
      success : function(data) {
         drawSpot(data);
      },
      data : JSON.stringify(bounds)
   });
};

// 지도 idle 이벤트 시 마커 새로 생성
function makeMarkerListener() {

   kakao.maps.event.addListener(g_map, 'idle', function() {
      makeMarkers(items)
   });
};


// makeMarkerListener() 함수의 ajax이 success일 경우 (DB의 정보를 기반으로 마커 형성하는 함수)
function drawSpot(list) {
   list.forEach(function(d,i) {
      var markerPositionLngLat = new kakao.maps.LatLng(d.store_y,d.store_x);
      var pic = [ 'resources/img/markers/korea.png', 'resources/img/markers/china.png', 'resources/img/markers/japan.png',
         'resources/img/markers/bunsik.png',  'resources/img/markers/cafe.png',  'resources/img/markers/america.png',
         'resources/img/markers/one.png',  'resources/img/markers/res.png', 'resources/img/markers/bread.png' ];
      var imageSize = new kakao.maps.Size(64, 69),
      imageOption = {offset : new kakao.maps.Point(27, 69)};

      var markerImage;
      var category = d.category_id;
      for(var k=1; k<10; k++) {
         if(category==k){
            markerImage = new kakao.maps.MarkerImage(pic[k-1], imageSize, imageOption);
         }
      }
      var marker = new kakao.maps.Marker({
         title : d.store_name,
         position : markerPositionLngLat,
         clickable: true ,
         image:markerImage
      });
      marker.setMap(g_map);
      markers.push(marker);

      kakao.maps.event.addListener(marker, 'click', function(){
         var name = marker.getTitle();
         var y = marker.getPosition().getLat();
         var x = marker.getPosition().getLng();
         
         
         // 인포윈도우<div>의 내부 코드 (String, HTML code 기재 가능)
         var iwContent = '<div class="customoverlay" id="clickmarker">'+marker.getTitle()+
         '<a href="javascript:void(0);" onclick="visibleInfo(this)" store_name='+name+' x='+x+' y='+y+
         '>&nbsp&nbsp<i class="fas fa-chevron-right">&nbsp</i></a></div>';
         
         var customOverlay = new kakao.maps.CustomOverlay({
             map: g_map,
             clickable: true,
             position: markerPositionLngLat,
             content: iwContent
             });
           
         kakao.maps.event.addListener(g_map, 'click', function() {customOverlay.setMap(null);});
      });

   }); // foreach end
};

function setMarkers(map){
   for (var i = 0; i< markers.length; i++) {
      markers[i].setMap(map);
      markers.splice(i,1);
   }
}

function showMarkers(){
   setMarkers(map)
}
function hideMarkers(){
   setMarkers(null)
   
}


function visibleInfo(obj){

   var storeName = document.getElementById('store_name');
   // 상점 객체 호출에 필요한 JSON 생성
   var name = $(obj).attr('store_name');
   var x = ($(obj).attr('x')).substring(0,9);
   var y = ($(obj).attr('y')).substring(0,8);
   var store = {'store_name':name,'store_x':x,'store_y':y};

   // (비동기) 상점 상세 (store)정보 호출
   $.ajax({
      url: 'getStoreDetail.do',
      type: 'post',
      dataType: 'json',
      contentType:'application/json',
      data : JSON.stringify(store),
      success : function(data){
         // 제목 변경
         sikgu_id = data.sikgu_id;
         document.getElementById('store_name').innerHTML = data.store_name;
         document.getElementById('StoreDescription').innerHTML = data.store_profile;
         document.getElementById('StoreTime').innerHTML = data.store_op_time;
         document.getElementById('StorePhone').innerHTML = data.store_phone;
         
         document.getElementById('store_face_id').innerHTML = data.store_face_id;
         document.getElementById('store_face_id').setAttribute( 'href', data.store_face_id );
         document.getElementById('store_face_pwd').innerHTML = data.store_face_pwd;
         document.getElementById('store_face_pwd').setAttribute( 'href', data.store_face_pwd );
//         document.getElementById('store_naver_id').innerHTML = data.store_naver_id;
//         document.getElementById('store_naver_id').setAttribute( 'href', data.store_naver_id );
//         document.getElementById('store_naver_pwd').innerHTML = data.store_naver_pwd;
//         document.getElementById('store_naver_pwd').setAttribute( 'href', data.store_naver_pwd );

            
         
         document.getElementById('store_detail').style.display = 'block';
         
         getMenu(data.sikgu_id);
         getStoreContent(data.sikgu_id);
      },error : function(){console.log("fail")}

   })
}

function getMenu(searchKey) {
   
   var searchKeys = {menu_id: searchKey}
   $("#MenuList").empty();
   $("#line").empty();
   $("#PriceList").empty();
   console.log(searchKeys);
   $.ajax({
      url: 'getMenu.do', type: 'post', dataType: 'json', contentType:'application/json', async: false,
      data : JSON.stringify(searchKeys),
      success : function(data){
               if (data != null) {
                  
                   for (i = 0; i < data.length; i++) {
                       
                          document.getElementById('MenuList').innerHTML +="<div>"+data[i].menu_name+"</div>"
                          document.getElementById('line').innerHTML +="<div>-----</div>"
                        document.getElementById('PriceList').innerHTML +="<div>"+data[i].menu_price+"&nbsp;원</div>"                          
                      }   
         }         
      },error : function() {console.log("fail to load menuboard")}

   })
}


function getStoreContent(searchKey) {
   var result;
   var defaultimg = "resources/img/noimage.png"
   var img_select=0;
   var cloneaddimg;
   
   $("#img_container").find( 'img' ).attr("src",defaultimg);
   $("#img_container").find( 'img' ).attr("href",defaultimg);
   $("#store_main_video").attr("href", "");
   $("#main_thum").attr("src", defaultimg);
   
   
   var searchKeys = {store_id: searchKey}
   $.ajax({
      url: 'getStoreContent.do', type: 'post', dataType: 'json', contentType:'application/json', async: 'false',
      data : JSON.stringify(searchKeys),
      success : function(data){
         
            if (data != null) {
               console.log(data.length);
                for (i = 0; i < data.length; i++) {
                   console.log(data[i]);
                   
                     if((data[i].content_type == 'jpg'|| data[i].content_type == 'png') && img_select==0){
                        result = data[i].content_url.replace( /c\:/gi, '/external');
                        result = result.replace( /content/gi, 'img');
                        
                        $("#main_img_1").attr("src",result);
                        $("#main_img_1_2").attr("href",result);
                        img_select = 1;
                        console.log(img_select);
                     }
                     else if ((data[i].content_type == 'jpg' || data[i].content_type == 'png') && img_select==1) {
                        result = data[i].content_url.replace( /c\:/gi, '/external');
                        result = result.replace( /content/gi, 'img');
                        
                        $("#main_img_2").attr("src",result);
                        $("#main_img_2_2").attr("href",result);
                        img_select = 2;
                        console.log(img_select);
                     }
                     else if ((data[i].content_type == 'jpg' || data[i].content_type == 'png') && img_select==2) {
                        result = data[i].content_url.replace( /c\:/gi, '/external');
                        result = result.replace( /content/gi, 'img');
                        
                        $("#main_thum").attr("src",result);
                        $("#store_main_video").attr("href",result);
                        img_select = 3;
                        console.log(img_select);
                     }
                     
                     else if (data[i].content_type == 'mp4') {
                        result = data[i].content_url.replace( /c\:/gi, '/external');
                        result = result.replace( /content/gi, 'img');
                        $("#store_main_video").attr("href", result);
                        $("#store_main_video").html(' <img src="resources/assets/custom/images/play-button.png" alt="play button" class="img-fluid">');
                        result = result.replace( /vid/gi, 'vid/thumbnail');
                        result = result.replace( /mp4/gi, data[i].thumb_name);
                        $("#main_thum").attr("src", result);
                        console.log(data[i].thumb_name);
                     }else{               
                        cloneaddimg =  $('#hiddendiv').clone(true);
                        result = data[i].content_url.replace( /c\:/gi, '/external');
                        cloneaddimg.find("#extra_2").attr("href",result);
                        cloneaddimg.appendTo('#img_container');
                     }                    
                   }   
      }
      },error : function() {console.log("fail to load content")}

   })
}


</script>

</body>
</html>