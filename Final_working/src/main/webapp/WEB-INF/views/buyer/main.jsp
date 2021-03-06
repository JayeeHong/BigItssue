<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
.fr{
	float:right;
}
th{
	text-align:center;
}

</style>


<script type="text/javascript">
var height=0;
$(document).ready(function(){


});


//예약페이지 열기
function booking(locNo){
		console.log("locNo:"+locNo);
	//현재창에서 페이지 이동
	$(location).attr("href", "/buyer/locview?locNo="+locNo);
}

//판매처 지도 열기
function mapView(locNo){
	var w = (screen.availWidth)/3;
	var h = (screen.availHeight)/2.5;
	//팝업창 새로 띄우기
	window.open("/sellerLocMap?locNo="+locNo, "판매처지도", "width="+w+'px'+", height="+h+'px'+", left=100, top=50");
	}

//채팅창 열기
function inquire(id,sort){
	console.log("id:"+id);
	console.log("sort:"+sort);
	
	//현재창에서 페이지 이동
	if( ${buyerLogin eq true } ){
		popup = window.open("/createRoom?id="+id+"&sort="+sort, "문의하기", "width=800, height=750, left=100, top=50");
	}else{
		$(location).attr("href", "/buyer/login");
	}
}

//호선으로 검색
function locInfo(){
	
	var zone = $('select[name=zoneSelect]').val();
	console.log("zone:"+zone);
	$.ajax({
        url : '/buyer/locInfo',
        type : 'post',
        data : {'zone':zone},
        dataType: 'html',
        success : function(receive) {
        	$("#locInfo").html(receive);
        },
        error: function(e) {
			console.log("실패");
			console.log(e);
		}        
    });
}


function pagingFunc(curpage){

	var zone = $("select[name=zoneSelect]").val()+"#";
	if($("select[name=stationSelect]").val()==undefined){
		var station = "#";
	}else{
		var station = $("select[name=stationSelect]").val()+"#";
	}

	$.ajax({
        url : '/buyer/pagingAjax',
        type : 'post',
        data : {'curPage':curpage, 'zone':zone, 'station':station},
        dataType: 'html',
        success : function(receive) {
        	$("#sellerLocTable").html(receive);
        },
        error: function(e) {
			console.log("실패");
			console.log(e);
		}        
    });
}
</script>

<hr>
<br>
<jsp:include page="mainBanner.jsp" />



<!-- 판매처 보기를 누르면 여기로 이동! -->
<div id="moveToSellerloc">

	<!-- 현재시간 받아오기 -->
	<fmt:formatDate value="${now }" pattern="HHmm" var="sysTime" />

 		<!-- 장소,위치 검색 (select태그이용) --> 
	<div style="float: right; padding-right: 10px; padding-top: 10px;">
		
<!-- 		<select name="zoneSelect" id="zoneSelect" class="form-control" style="height: 25px; margin-bottom: 6px; padding-top: 0px; padding-bottom: 0px;"> -->
<!-- 			<option value="">지역을 선택하세요</option> -->
<%-- 			<c:forEach var="item" items="${zoneList }" begin="0" end="${zoneList.size() }" step="1"> --%>
<!-- 				한번 검색한 것은 새로고침해도 유지되도록 -->
<%-- 				<c:if test="${paging.zone eq item.zone }"> --%>
<%-- 					<option value="${item.zone }" selected>${item.zone }</option> --%>
<%-- 				</c:if> --%>
<%-- 				<c:if test="${paging.zone ne item.zone }"> --%>
<%-- 					<option value="${item.zone }">${item.zone }</option> --%>
<%-- 				</c:if> --%>
<%-- 			</c:forEach> --%>
<!-- 		</select> -->
		
<!-- 		<select name="stationSelect" class="form-control" style="height: 25px; margin-bottom: 6px; padding-top: 0px; padding-bottom: 0px;"> -->
<!-- 			<option value="">판매위치</option> -->
<%-- 			<c:forEach var="item" items="${stationList }" begin="0" end="${stationList.size() }" step="1"> --%>
<!-- 				한번 검색한 것은 새로고침해도 유지되도록 -->
<%-- 				<c:if test="${paging.station eq item.station }"> --%>
<%-- 					<option value="${item.station }" selected>${item.station }</option> --%>
<%-- 				</c:if> --%>
<%-- 				<c:if test="${paging.station ne item.station }"> --%>
<%-- 					<option value="${item.station }">${item.station }</option> --%>
<%-- 				</c:if> --%>
<%-- 			</c:forEach> --%>
<!-- 		</select> -->
	
<!-- 		<button onclick="pagingFunc(0)" style="height: 25px;margin-bottom: 6px; padding-top: 0px; padding-bottom: 0px;" class="btn btn-default btn-sm">검색</button> -->
	
	</div><br>
	<h4>호선/장소선택</h4>
	<!-- 호선검색  -->		
	<select onchange="locInfo()" name="zoneSelect" id="zoneSelect" class="form-control" style="height: 30px; width:180px; margin-bottom: 6px; padding-top: 0px; padding-bottom: 0px;">
		<option value="">호선을 선택하세요</option>
		<option value="1호선">1호선</option>
		<option value="2호선">2호선</option>
		<option value="3호선">3호선</option>
		<option value="4호선">4호선</option>
		<option value="5호선">5호선</option>
		<option value="6호선">6호선</option>
		<option value="7호선">7호선</option>
		<option value="8호선">8호선</option>
		<option value="9호선">9호선</option>
		<option value="부산">부산</option>
	</select>

<!-- 호선검색 결과 -->
<div id="locInfo"></div>	
	
<!-- sellecrLoc테이블 -->
<div id="sellerLocTable" style="text-align: center; margin-bottom:50px;">

<div style="padding: 10px;">
	<table class="table table-bordered">
		<thead style="background: #cccccc6e;">
		<tr>
		<th style="width: 10%;">장소(호선)</th>
		<th style="width: 40%">세부위치(지도)</th>
		<th style="width: 25%">판매시간</th>
		<th style="width: 25%">판매자</th>
	 	</tr>
		</thead>
		<tbody>
		<c:forEach var="item" items="${sellerLocList }" begin="0" end="${sellerLocList.size() }" step="1">
			<tr>
			<td>${item.zone }</td>
			<td>${item.station } ${item.spot }<button class="btn btn-success btn-sm fr" onclick="mapView(${item.locNo })">지도보기</button></td>
			<td>
				<c:if test="${item.sellerTimeS.length() eq 4 && item.sellerTimeE.length() eq 4 }">
				${item.sellerTimeS.substring( 0, 2 ) }:${item.sellerTimeS.substring( 2, 4 ) } ~ ${item.sellerTimeE.substring( 0, 2 )}:${item.sellerTimeE.substring( 2, 4 )} 
				</c:if>
				
				<c:if test="${item.sellerTimeS.length() eq 3 && item.sellerTimeE.length() eq 4 }">
				${item.sellerTimeS.substring( 0, 1 ) }:${item.sellerTimeS.substring( 1, 3 ) } ~ ${item.sellerTimeE.substring( 0, 2 )}:${item.sellerTimeE.substring( 2, 4 )} 
				</c:if>
				
				<c:if test="${item.sellerTimeS.length() eq 4 && item.sellerTimeE.length() eq 3 }">
				${item.sellerTimeS.substring( 0, 2 ) }:${item.sellerTimeS.substring( 2, 4 ) } ~ ${item.sellerTimeE.substring( 0, 1 )}:${item.sellerTimeE.substring( 1, 3 )} 
				</c:if>
				
				<c:if test="${item.sellerTimeS.length() eq 3 && item.sellerTimeE.length() eq 3 }">
				${item.sellerTimeS.substring( 0, 1 ) }:${item.sellerTimeS.substring( 1, 3 ) } ~ ${item.sellerTimeE.substring( 0, 1 )}:${item.sellerTimeE.substring( 1, 3 )} 
				</c:if>	
				
				<!-- sellerId가 null이 아닐때 -->
				<c:if test="${item.sellerId ne null }">
					<!-- 예약시간이 지나지 않았을 때 -->
					<c:if test="${item.sellerTimeE ge intNow }">
						<button class="btn btn-info btn-sm fr" onclick="booking(${item.locNo })">예약하기</button>
					</c:if>
					<!-- 예약시간이 지났을 떄 -->
					<c:if test="${item.sellerTimeE lt intNow }">		
						<button class="btn btn-info btn-sm fr" disabled>예약하기</button>
					</c:if>
				</c:if>
				<!-- sellerId가 null이 일때 -->
				<c:if test="${item.sellerId eq null }">
					<button class="btn btn-info btn-sm fr" disabled>예약하기</button>
				</c:if>
			</td>
			<!-- sellerId가 null이 아닐때 -->
			<c:if test="${item.sellerId ne null }">
				<!-- 예약시간이 지나지 않았을 때 -->
				<c:if test="${item.sellerTimeE ge intNow}">
					<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" onclick="inquire('${item.sellerId}','판매자')">문의하기</button></td>
				</c:if>
				<!-- 예약시간이 지났을 떄 -->
				<c:if test="${item.sellerTimeE lt intNow}">
					<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" disabled>문의하기</button></td>
				</c:if>		
			</c:if>
			<!-- sellerId가 null이 일때 -->
			<c:if test="${item.sellerId eq null }">
				<td><button class="btn btn-warning btn-sm fr" disabled>문의하기</button></td>
			</c:if>
		
	</c:forEach>
	</tbody>
</table>

<!-- 페이징 -->
<jsp:include page="sellerLocPaging.jsp" />
<div id="pagingResult"></div>

</div> <!-- 판매처보기로 이동을 위한 div -->

</div>
</div>

