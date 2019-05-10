<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9ee94ce212eca2864c7acbe36e0325d7&libraries=services,clusterer,drawing"></script>
</head>
<body>
	<div id="map" style="margin:-12px;width:505px;height:385px;"></div>
	
	<script>
	//사용자 화면 크기 각각 '너비/3' '높이/2.5'
	var w = (screen.availWidth)/3;
	var h = (screen.availHeight)/2.5;
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption);
	
	var mapContainer = document.getElementById('map');
	mapContainer.style.width = w+'px';
	mapContainer.style.height = h+'px';
	
	map.relayout();
	
 	// 지도를 클릭한 위치에 표출할 마커입니다
    var marker = new daum.maps.Marker({ 
    	
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
        
        var adminInputSpot = prompt("변경할 출구는 몇번입니까?");
        
        if(adminInputSpot != null) {
        	opener.document.getElementById("spot").value = adminInputSpot;
        	opener.document.getElementById("lat").value = latlng.getLat();
        	opener.document.getElementById("lng").value = latlng.getLng();
        	window.close();	
        } else if(adminInputSpot == false) {
        	
        }
        
    });
	
	// 장소 검색 객체를 생성합니다
    var ps = new daum.maps.services.Places(); 

    // 키워드로 장소를 검색합니다
    ps.keywordSearch('${sellerLoc.station }역', placesSearchCB); 

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
    
    

	</script>
</body>
</html>