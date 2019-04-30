<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9ee94ce212eca2864c7acbe36e0325d7&libraries=services,clusterer,drawing"></script>
</head>
<body>
	<div id="map" style="margin:-12px;width:505px;height:385px;"></div>
	<script>
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new daum.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(${sellerLoc.lat }, ${sellerLoc.lng }), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption); 
	// 마우스 드래그로 지도 이동 가능여부를 설정합니다
    map.setDraggable(false);    
		
    // 마커를 생성하고 지도에 표시합니다
    var marker = new daum.maps.Marker({
        map: map,
        position: new daum.maps.LatLng(${sellerLoc.lat }, ${sellerLoc.lng }) 
    });

    // 마커에 클릭이벤트를 등록합니다
    daum.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + "${sellerLoc.station}" +'역 '+ "${sellerLoc.spot}" + '</div>');
        infowindow.open(map, marker);
    });
	
	</script>
</body>
</html>