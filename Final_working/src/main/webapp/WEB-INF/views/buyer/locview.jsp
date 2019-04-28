<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
.fr{
	float:right;
}
</style>

<script type="text/javascript">

$(document).ready(function() {
	
});

//채팅창 열기
function inquire(id,sort){
	
	console.log("id:"+id);
	console.log("sort:"+sort);
	//현재창에서 페이지 이동
	$(location).attr("href", "/createRoom?id="+id+"&sort="+sort);
	
}

</script>

<h1>locview페이지</h1>
<div class="wrap container">
<div style="padding: 10px;">
<!-- 판매자,빅돔 테이블 -->
<table class="table table-bordered">
	<thead>
	<tr>
	<th style="width: 25%">장소</th>
	<th style="width: 25%">세부위치(지도)</th>
	<th style="width: 25%">시간</th>
	<th style="width: 25%">판매자</th>

	</tr>
	</thead>
	<tbody>
	
		<!-- 판매자 -->
		<tr>
		<td>${sellerLoc.zone }</td>
		<td>${sellerLoc.station } ${sellerLoc.spot }</td>
		<td>${sellerLoc.sellerTimeS } ~ ${sellerLoc.sellerTimeE}</td>
		<td>${sellerLoc.sellerId } (판매자)<button class="btn btn-warning btn-sm fr" onclick="inquire('${sellerLoc.sellerId}','판매자')">문의하기</button></td>
		</tr>
		
		<!-- 빅돔 -->
		<tr>
		<td>${sellerLoc.zone }</td>
		<td>${sellerLoc.station } ${sellerLoc.spot }</td>
		<td>${sellerLoc.sellerTimeS } ~ ${sellerLoc.sellerTimeE}</td>
		<td>${sellerLoc.bigdomId } (빅돔)<button class="btn btn-info btn-sm fr" onclick="inquire('${sellerLoc.bigdomId}','빅돔')">문의하기</button></td>
		</tr>
	</tbody>
</table>

<!-- 예약테이블 -->
<table class="table table-bordered">
	<thead>
	<tr>
	<th style="width: 33%">호수</th>
	<th style="width: 33%">보유부수</th>
	<th style="width: 33%">부수선택</th>
	</tr>
	</thead>
	<tbody>
	
		<!-- 판매자 -->
		<tr>
		<td>${sellerLoc.zone }</td>
		<td>${sellerLoc.station } ${sellerLoc.spot }</td>
		<td>${sellerLoc.sellerTimeS } ~ ${sellerLoc.sellerTimeE}</td>
		<td>${sellerLoc.sellerId } (판매자)<button class="btn btn-warning btn-sm fr" onclick="inquire('${sellerLoc.sellerId}','판매자')">문의하기</button></td>
		</tr>
		
	</tbody>
</table>
</div>
</div>