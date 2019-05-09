<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
//예약페이지 열기
function bookingCancel(magazineNo){
	
	console.log("magazineNo:"+magazineNo);
	//현재창에서 페이지 이동
	$(location).attr("href", "/buyer/bookingCancel?magazineNo="+magazineNo);
}

</script>

<div class="container">
<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_buyer.jsp" />

<div style="text-align: center;" class="col-sm-9">

<table class="table table-bordered table-striped">

<thead>
<tr>
	<td>날짜</td>
	<td>찾아갈 장소</td>
	<td>시간</td>
	<td>상태</td>
	<td>예약부수</td>
	<td>결제예정금액</td>
	<td>예약취소</td>
</tr>
</thead>

<tbody>
<c:forEach items="${reservationList }" var="b">
<tr>
	<td><fmt:formatDate value="${b.pickupDate }" pattern="yy-MM-dd(E)"/></td>
	<td>${b.spot }</td>
	<td><fmt:formatDate value="${b.pickupDate }" pattern="HH:mm"/></td>
	<td>${b.status }</td>
	<td>${b.bookNumber }</td>
	<td><fmt:formatNumber value="${b.total}" pattern="#,###,###"/>[원]</td>
	<td>
	<c:if test="${b.status eq '예약' }">
		<button class="btn btn-danger btn-sm" onclick="bookingCancel(${b.magazineNo})">예약취소</button>
	</c:if>
	</td>
</tr>
</c:forEach>
</tbody>

</table>
<jsp:include page="bookingPaging.jsp" />

</div>
</div>
</div>
