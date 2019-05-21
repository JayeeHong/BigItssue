<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.label {margin-bottom: 96px;}
.label * {display: inline-block;vertical-align: top;}
.label .left {background: url("http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 24px;overflow: hidden;vertical-align: top;width: 7px;}
.label .center {background: url(http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 24px;font-size: 12px;line-height: 24px;}
.label .right {background: url("http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 24px;overflow: hidden;width: 6px;}
</style>

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
	        center: new daum.maps.LatLng(${sellerLoc.lat }, ${sellerLoc.lng }), // 지도의 중심좌표
	        level: 3, // 지도의 확대 레벨
	        draggable : false, //마우스 드래그, 휠, 모바일 터치를 이용한 시점 변경(이동, 확대, 축소) 가능 여부
	        scrollwheel : false, //마우스 휠, 모바일 터치를 이용한 확대 및 축소 가능 여부
	        disableDoubleClick : true, //더블클릭 이벤트 및 더블클릭 확대 가능 여부
	        disableDoubleClickZoom : true //더블클릭 확대 가능 여부
	        
	    };
	
	
	// 지도를 생성합니다    
	var map = new daum.maps.Map(mapContainer, mapOption);
	
	var mapContainer = document.getElementById('map');
	mapContainer.style.width = w+'px';
	mapContainer.style.height = h+'px';
	
	map.relayout();
	// 마우스 드래그로 지도 이동 가능여부를 설정합니다
    map.setDraggable(false);    
		
    // 마커를 생성하고 지도에 표시합니다
    var marker = new daum.maps.Marker({
        map: map,
        position: new daum.maps.LatLng(${sellerLoc.lat }, ${sellerLoc.lng }) 
    });
    // 마커에 z-Index 부여
    marker.setZIndex(3);
    
    
    var content = '<div class ="label"><span class="left"></span><span class="center">'+ "${sellerLoc.station}" +'역 '+ "${sellerLoc.spot}" + '출구' + '</span><span class="right"></span></div>';
    
    var customOverlay = new daum.maps.CustomOverlay({
        position: new daum.maps.LatLng(${sellerLoc.lat }, ${sellerLoc.lng }),
        content: content   
    });
    
    var cnt = 0;
    // 마커에 클릭이벤트를 등록합니다
	daum.maps.event.addListener(marker, 'click', function() {
		if(cnt == 0) {
		   cnt += 1;
	       customOverlay.setMap(map);
		   console.log(cnt);
		} else {
		   cnt -= 1;
		   customOverlay.setMap(null);
	 	   console.log(cnt);
		}    	
	});
	</script>

</body>
</html>