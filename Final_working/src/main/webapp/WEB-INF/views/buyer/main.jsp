<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
.fr{
	float:right;
}
th{
	text-align:center;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	
});
//예약페이지 열기
function booking(locNo){
	
	console.log("locNo:"+locNo);
	//현재창에서 페이지 이동
	$(location).attr("href", "/buyer/locview?locNo="+locNo);
	
}
//판매처 지도 열기
function mapView(locNo){
	
	//팝업창 새로 띄우기
	window.open("/sellerLocMap?locNo="+locNo, "판매처지도", "width=400, height=300, left=100, top=50");
	
}
//채팅창 열기
function inquire(id,sort){
	
	console.log("id:"+id);
	console.log("sort:"+sort);
	//현재창에서 페이지 이동
	$(location).attr("href", "/createRoom?id="+id+"&sort="+sort);
	
}
</script>

<!-- 현재시간 받아오기 -->
<fmt:formatDate value="${now}" pattern="HHmm" var="sysTime" />

<div style="text-align: center; margin-bottom:50px;">
<div class="wrap container">
<div style="padding: 10px;">
<table class="table table-bordered">
	<thead>
	<tr>
	<th style="width: 25%;">장소</th>
	<th style="width: 25%">세부위치(지도)</th>
	<th style="width: 25%">시간</th>
	<th style="width: 25%">판매자</th>
 
	</tr>
	</thead>
	<tbody>
	<c:forEach var="item" items="${sellerLocList}" begin="0" end="${sellerLocList.size()}" step="1">
		<tr>
		<td>${item.zone }</td>

		<td>${item.station } ${item.spot }<button class="btn btn-success btn-sm fr" onclick="mapView(${item.locNo })">지도보기</button></td>
		<td>
			<c:if test="${item.sellerTimeS.length() eq 4 && item.sellerTimeE.length() eq 4}">
			${item.sellerTimeS.substring( 0, 2 ) }:${item.sellerTimeS.substring( 2, 4 ) } ~ ${item.sellerTimeE.substring( 0, 2 )}:${item.sellerTimeE.substring( 2, 4 )} 
			</c:if>
			
			<c:if test="${item.sellerTimeS.length() eq 3 && item.sellerTimeE.length() eq 4}">
			${item.sellerTimeS.substring( 0, 1 ) }:${item.sellerTimeS.substring( 1, 3 ) } ~ ${item.sellerTimeE.substring( 0, 2 )}:${item.sellerTimeE.substring( 2, 4 )} 
			</c:if>
			
			<c:if test="${item.sellerTimeS.length() eq 4 && item.sellerTimeE.length() eq 3}">
			${item.sellerTimeS.substring( 0, 2 ) }:${item.sellerTimeS.substring( 2, 4 ) } ~ ${item.sellerTimeE.substring( 0, 1 )}:${item.sellerTimeE.substring( 1, 3 )} 
			</c:if>
			
			<c:if test="${item.sellerTimeS.length() eq 3 && item.sellerTimeE.length() eq 3}">
			${item.sellerTimeS.substring( 0, 1 ) }:${item.sellerTimeS.substring( 1, 3 ) } ~ ${item.sellerTimeE.substring( 0, 1 )}:${item.sellerTimeE.substring( 1, 3 )} 
			</c:if>	
			
			<c:if test="${item.sellerTimeE le intNow}">
				<button class="btn btn-info btn-sm fr" onclick="booking(${item.locNo})">예약하기</button>
			</c:if>
			
			<c:if test="${item.sellerTimeE gt intNow}">		
				<button class="btn btn-info btn-sm fr" disabled>예약하기</button>
			</c:if>
		</td>
		
		<c:if test="${item.sellerTimeE le intNow}">
			<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" onclick="inquire('${item.sellerId}','판매자')">문의하기</button></td>
		</c:if>
		<c:if test="${item.sellerTimeE gt intNow}">
			<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" disabled>문의하기</button></td>
		</c:if>
		
	</c:forEach>
	</tbody>
</table>

<jsp:include page="sellerLocPaging.jsp" />
</div>
</div>
</div>