<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
	.table {
		text-align: center;
	}
	
	.table thead {
		font-weight: bold;
		background: #cccccc6e;
	}
	
	.table>tbody>tr>td {
		vertical-align: middle;
	}
	
	.table>thead>tr>td {
		vertical-align: middle;
	}
</style>

<script type="text/javascript">

function bookCancel(reserveNo) {
	result = confirm('예약을 취소하시겠습니까?'+'\n'+
						'취소 후에는 변경할 수 없습니다.');
// 	console.log(result);
	if(result==true) {
		$(location).attr("href", "/seller/bookCancel?reserveNo="+reserveNo);
	} else {
		return false;
	}
}

function bookUpdate(reserveNo) {
	result = confirm('예약자가 수령한 경우에만 변경하세요!'+'\n'+
						'상태 변경 후에는 변경할 수 없습니다.');
// 	console.log(result);
	if(result==true) {
		$(location).attr("href", "/seller/bookUpdate?reserveNo="+reserveNo);
	} else {
		return false;
	}
}

</script>

<div style="padding: 10px;">

<h3>예약내역</h3>
1. 구매자가 예약하고 찾아가지 않은 경우, 상태가 '예약취소(시간초과)' 로 변경됩니다.<br>
2. 수령, 취소 버튼으로 판매자가 구매자의 예약상태를 변경할 수 있습니다. 변경 후에는 취소할 수 없으므로 유의하시기 바랍니다.<br>
<div style="text-align: center;">

<table class="table table-bordered table-striped">

<thead>
<tr>
	<td>예약 번호</td>
	<td>예약한 날짜</td>
	<td>예약 호수(권수)</td>
	<td>예약자</td>
	<td>수령할 날짜</td>
	<td>상태</td>
	<td>상태변경</td>
</tr>
</thead>

<tbody>
<c:if test="${bookListInfo.size() eq 0 }">
<tr>
	<td colspan="7">예약된 빅이슈가 없습니다.</td>
</tr>
</c:if>

<c:if test="${bookListInfo.size() ne 0 }">
<c:forEach items="${bookListInfo }" var="b">
<tr>
	<td>${b.reserveNo }</td>
	<td><fmt:formatDate value="${b.bookDate }" pattern="yy-MM-dd(E) HH:mm"/></td>
	<td>${b.bookMonth }(${b.bookNumber }권)</td>
	<td>${b.buyerId }</td>
	<td><fmt:formatDate value="${b.pickupDate }" pattern="yy-MM-dd(E) HH:mm"/></td>
	<td>${b.status }</td>
	<td>
	<c:if test="${b.status eq '예약' }">
	<button id="bookCancel" class="btn btn-xs btn-danger" onclick="bookCancel(${b.reserveNo });">취소</button>
	<button id="bookUpdate" class="btn btn-xs btn-primary" onclick="bookUpdate(${b.reserveNo });">수령</button>
	</c:if>
	</td>
</tr>
</c:forEach>
</c:if>
</tbody>

</table>

</div>

</div>