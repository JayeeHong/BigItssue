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
	<div id="map" style="width:450px;height:350px;"></div>
	<script>
	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new daum.maps.InfoWindow({zIndex:1});

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  

	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption); 
	// 마우스 드래그로 지도 이동 가능여부를 설정합니다
    map.setDraggable(false);    
	// 장소 검색 객체를 생성합니다
	var ps = new daum.maps.services.Places(map); 

	// 키워드로 장소를 검색합니다
	if('${map.zone}'=="1"||'${map.zone}'=="2"||'${map.zone}'=="3"||'${map.zone}'=="4"||'${map.zone}'=="5"||'${map.zone}'=="6"||'${map.zone}'=="7"||'${map.zone}'=="8"||'${map.zone}'=="9"){
		ps.keywordSearch('${map.zone}'+"호선 "+'${map.station}'+"역 "+ '${map.spot }'+"출구", placesSearchCB); 
	} else {
		if("${map.station }".equals("부천")) {
			ps.keywordSearch("부천역 4번출구 ", placesSearchCB);
		} else {
		ps.keywordSearch('${map.station}'+"역 "+ '${map.spot }'+"출구", placesSearchCB);
		}
	}

	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	function placesSearchCB (data, status, pagination) {
	    if (status === daum.maps.services.Status.OK) {

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        var bounds = new daum.maps.LatLngBounds();

	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new daum.maps.LatLng(data[i].y, data[i].x));
	        }       

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        map.setBounds(bounds);
	    } 
	}
	
	// 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {
	    
	    // 마커를 생성하고 지도에 표시합니다
	    var marker = new daum.maps.Marker({
	        map: map,
	        position: new daum.maps.LatLng(place.y, place.x) 
	    });

	    // 마커에 클릭이벤트를 등록합니다
	    daum.maps.event.addListener(marker, 'click', function() {
	        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
	        infowindow.open(map, marker);
	    });
	}
	
	</script>
</body>
</html>