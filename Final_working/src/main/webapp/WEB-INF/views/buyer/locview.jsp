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

//채팅창 열기
function inquire(id,sort){
	
	console.log("id:"+id);
	console.log("sort:"+sort);
	//현재창에서 페이지 이동
	$(location).attr("href", "/createRoom?id="+id+"&sort="+sort);
	
}

</script>

<!-- 현재시간 가져오기 -->
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="hh" var="sysHour" />
<fmt:formatDate value="${now}" pattern="mm" var="sysMin" />
<fmt:formatDate value="${now}" pattern="hhmm" var="sysTime" />
<fmt:formatDate value="${now}" pattern="a" var="AmPm" />

<%-- ${sysHour }<br> --%>
<%-- ${sysMin }<br> --%>
<%-- ${AmPm }<br> --%>

<div style="text-align: center; margin-bottom:50px;">
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
		<td>
			<c:if test="${sellerLoc.sellerTimeS.length() eq 4 && sellerLoc.sellerTimeE.length() eq 4}">
			${sellerLoc.sellerTimeS.substring( 0, 2 ) }:${sellerLoc.sellerTimeS.substring( 2, 4 ) } ~ ${sellerLoc.sellerTimeE.substring( 0, 2 )}:${sellerLoc.sellerTimeE.substring( 2, 4 )} 
			</c:if>
			
			<c:if test="${sellerLoc.sellerTimeS.length() eq 3 && sellerLoc.sellerTimeE.length() eq 4}">
			${sellerLoc.sellerTimeS.substring( 0, 1 ) }:${sellerLoc.sellerTimeS.substring( 1, 3 ) } ~ ${sellerLoc.sellerTimeE.substring( 0, 2 )}:${sellerLoc.sellerTimeE.substring( 2, 4 )} 
			</c:if>
			
			<c:if test="${sellerLoc.sellerTimeS.length() eq 4 && sellerLoc.sellerTimeE.length() eq 3}">
			${sellerLoc.sellerTimeS.substring( 0, 2 ) }:${sellerLoc.sellerTimeS.substring( 2, 4 ) } ~ ${sellerLoc.sellerTimeE.substring( 0, 1 )}:${sellerLoc.sellerTimeE.substring( 1, 3 )} 
			</c:if>
			
			<c:if test="${sellerLoc.sellerTimeS.length() eq 3 && sellerLoc.sellerTimeE.length() eq 3}">
			${sellerLoc.sellerTimeS.substring( 0, 1 ) }:${sellerLoc.sellerTimeS.substring( 1, 3 ) } ~ ${sellerLoc.sellerTimeE.substring( 0, 1 )}:${sellerLoc.sellerTimeE.substring( 1, 3 )} 
			</c:if>	
		</td>	
		<td>${sellerLoc.sellerId } (판매자)<button class="btn btn-warning btn-sm fr" onclick="inquire('${sellerLoc.sellerId}','판매자')">문의하기</button></td>
		</tr>
		
		<!-- 빅돔 -->
		<tr>
		<td>${sellerLoc.zone }</td>
		<td>${sellerLoc.station } ${sellerLoc.spot }</td>
		<td>
			<c:if test="${sellerLoc.sellerTimeS.length() eq 4 && sellerLoc.sellerTimeE.length() eq 4}">
			${sellerLoc.sellerTimeS.substring( 0, 2 ) }:${sellerLoc.sellerTimeS.substring( 2, 4 ) } ~ ${sellerLoc.sellerTimeE.substring( 0, 2 )}:${sellerLoc.sellerTimeE.substring( 2, 4 )} 
			</c:if>
			
			<c:if test="${sellerLoc.sellerTimeS.length() eq 3 && sellerLoc.sellerTimeE.length() eq 4}">
			${sellerLoc.sellerTimeS.substring( 0, 1 ) }:${sellerLoc.sellerTimeS.substring( 1, 3 ) } ~ ${sellerLoc.sellerTimeE.substring( 0, 2 )}:${sellerLoc.sellerTimeE.substring( 2, 4 )} 
			</c:if>
			
			<c:if test="${sellerLoc.sellerTimeS.length() eq 4 && sellerLoc.sellerTimeE.length() eq 3}">
			${sellerLoc.sellerTimeS.substring( 0, 2 ) }:${sellerLoc.sellerTimeS.substring( 2, 4 ) } ~ ${sellerLoc.sellerTimeE.substring( 0, 1 )}:${sellerLoc.sellerTimeE.substring( 1, 3 )} 
			</c:if>
			
			<c:if test="${sellerLoc.sellerTimeS.length() eq 3 && sellerLoc.sellerTimeE.length() eq 3}">
			${sellerLoc.sellerTimeS.substring( 0, 1 ) }:${sellerLoc.sellerTimeS.substring( 1, 3 ) } ~ ${sellerLoc.sellerTimeE.substring( 0, 1 )}:${sellerLoc.sellerTimeE.substring( 1, 3 )} 
			</c:if>	
		</td>
		<td>${sellerLoc.bigdomId } (빅돔)<button class="btn btn-info btn-sm fr" onclick="inquire('${sellerLoc.bigdomId}','빅돔')">문의하기</button></td>
		</tr>
	</tbody>
</table>

<!-- 예약테이블 -->
<table class="table table-bordered">
	<thead>
	<tr>
	<th style="width: 25%">호수</th>
	<th style="width: 25%">보유부수</th>
	<th style="width: 25%">부수선택</th>
	</tr>
	</thead>
	<tbody>
	
		<!-- 예약 -->		
		<form action="/buyer/booking" method="POST">
			<c:forEach var="item" items="${bookListInfo}" begin="0" end="${bookListInfo.size()}" step="1" varStatus="index">
				<tr>
				<td>${item.month }</td>
				<input type="hidden" name="month" value="${item.month}"/>
				<td>${item.circulation }</td>
				<td>
				<c:if test="${item.circulation ge 2}">
					<select name="selectBookingNum">
						<c:forEach var="i" begin="0" end="2" step="1">
							<option value="${i }">${i }</option>
						</c:forEach>
					</select>
				</c:if>
				<c:if test="${item.circulation lt 2}">
					<select name="selectBookingNum">
						<c:forEach var="i" begin="0" end="${item.circulation}" step="1">
							<option value="${i }">${i }</option>
						</c:forEach>
					</select>
				</c:if>
				</td>
				<c:if test="${index.first && cntReservation le 0}">
					<td rowspan="${bookListInfo.size()}" style="border-bottom:hidden;border-right:hidden;border-top:hidden;">
						<br>
						<c:if test="${AmPm eq '오전'}">
							<input type="radio" name="AmPm" value="오전" checked="checked">오전
							<input type="radio" name="AmPm" value="오후">오후<br>
						</c:if>
  						<c:if test="${AmPm eq '오후'}">
  							<input type="radio" name="AmPm" value="오전">오전
  							<input type="radio" name="AmPm" value="오후" checked="checked">오후<br>
  						</c:if>
						

  						<select name="bookingTimeHour">
							<c:forEach var="i" begin="1" end="12" step="1">
								<c:if test="${sysHour eq i }">
								<option value="${sysHour }" selected>${sysHour }</option>
								</c:if>
								<c:if test="${sysHour ne i }">
								<option value="${i }">${i }</option>
								</c:if>
							</c:forEach>
						</select>
						:
						<select name="bookingTimeMin">
							<c:forEach var="i" begin="00" end="59" step="01">
								<c:if test="${sysMin eq i }">
								<option value="${sysMin }" selected>${sysMin }</option>
								</c:if>
								<c:if test="${sysMin ne i }">
									<c:if test="${i lt 10 }">
									<option value="${i }">0${i }</option>
									</c:if>
									<c:if test="${i ge 10 }">
									<option value="${i }">${i }</option>
									</c:if>
								</c:if>
							</c:forEach>
						</select>
  						
						<button class="btn btn-info btn-sm">예약하기</button>
					</td>
				</c:if>
				<c:if test="${index.first && cntReservation ge 1}">
					<td rowspan="${bookListInfo.size()}" style="border-bottom:hidden;border-right:hidden;border-top:hidden;">
					<div>*이미 예약을 하셨습니다. 예약취소를  하고싶으면 마이페이지로 가십시오.</div>
					</td>
				</c:if>
				</tr>
			</c:forEach>
			<input type="hidden" name="locNo" value="${sellerLoc.locNo}"/>
		</form>

	</tbody>
</table>
<div style="text-align:right;">*예약할 수 있는 부수의 개수는 최대 2권입니다.</div>
</div>
</div>
</div>