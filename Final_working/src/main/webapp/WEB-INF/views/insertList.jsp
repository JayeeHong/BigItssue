<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;height:280px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#station, #zone, #spot, #lat, #lng, #insertBtn{margin:10px 0;}
#insertBtn{float:right;}
</style>
<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9ee94ce212eca2864c7acbe36e0325d7&libraries=services,clusterer,drawing"></script>
</head>
<body>
<div class="map_wrap">
    <div id="map" style="width:100%;height:150%;position:relative;overflow:hidden;"></div>
	    <div id="menu_wrap" class="bg_white">
	        <div class="option">
	            <div>
	                <form action="/insertList" method="GET">
	                	검색 : <input type="text" value="${keyword }" id="keyword" name="keyword" size="15">
	                    <button type="submit">검색하기</button> 
	                </form>
	            </div>
	        </div>
	        <hr>
	<form action="/insertList" method="POST">
		역 &nbsp&nbsp&nbsp: <input type="text" value="${keyword }" id="station" name="station" size="15"><br>
	        라인 : <input type="text" id="zone" name="zone" size="5"><br>
	        출구 : <input type="text" id="spot" name="spot" size="15"><br>
	        경도 : <input type="text" id="lat" name="lat" size="19"><br>
	        위도 : <input type="text" id="lng" name="lng" size="19">
	        <hr>
	    <button type="submit" id="insertBtn" name="insertBtn">추가</button>
	</form>
    </div>
</div>

<script>
// 마커를 담을 배열입니다
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new daum.maps.services.Places(); 

// 키워드로 장소를 검색합니다
if($("#keyword").val() == "") {
	ps.keywordSearch('경복궁', placesSearchCB);	
} else {
	ps.keywordSearch($("#keyword").val(), placesSearchCB); 
}

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === daum.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new daum.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            bounds.extend(new daum.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

//지도를 클릭한 위치에 표출할 마커입니다
var marker = new daum.maps.Marker({ 
    // 지도 중심좌표에 마커를 생성합니다 
    position: map.getCenter() 
}); 
// 지도에 마커를 표시합니다
marker.setMap(map);

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
daum.maps.event.addListener(map, 'click', function(mouseEvent) {        
    
    // 클릭한 위도, 경도 정보를 가져옵니다 
    var latlng = mouseEvent.latLng; 
    
    // 마커 위치를 클릭한 위치로 옮깁니다
    marker.setPosition(latlng);
    
    var lat = latlng.getLat();
    var lng = latlng.getLng();
    
   	document.getElementById('lat').setAttribute("value", lat); 
   	document.getElementById('lng').setAttribute("value", lng);
});
</script>
	
</body>
</html>