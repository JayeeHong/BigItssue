<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*"  %>
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

$(document).ready(function() {
	$("#toList").click(function() {
		location.href="/admin/book/list";
	});
});

function addBookInfo(sellerId) {
// 	if(!document.addBook.month.value) {
// 		alert("판매 호수를 입력하세요!");
// 		return false;
// 	}
	
	if(!document.addBook.circulation.value) {
		alert("판매 부수를 입력하세요!");
		return false;
	}
	
	form = document.addBook;
	form.method="post";
	form.action="/admin/book/addBook";
	form.submit();
}

// function mUpdate(magazineNo) {
	
// 	result = confirm('빅이슈를 수정하시겠습니까?');
	
// 	if(result==true) {
// 		form = document.menageMegazine;
// 		form.method="post";
// 		form.action="/admin/book/view/update?magazineNo="+magazineNo;
// 		form.submit();	
// 	} else {
// 		return false;
// 	}
// }

function mDelete(magazineNo, sellerId) {
	
	result = confirm('판매중인 빅이슈를 삭제하시겠습니까?'+'\n'+
						'삭제 후에는 변경할 수 없습니다.');
	//console.log(result);
	if(result==true) {
		$(location).attr("href", "/admin/book/view/delete?magazineNo="+magazineNo+"&sellerId="+sellerId);
	} else {
		return false;
	}
	
}

</script>

<!-- 현재시간 가져오기 -->
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy" var="sysYear" />
<fmt:formatDate value="${now}" pattern="M" var="sysMonth" />
<fmt:formatDate value="${now}" pattern="yyyy-M" var="sysDate" />
<%-- ${sysYear }-${sysMonth }<br>${sysDate }<br>${sysYear-1 }<br>${sysYear }-${sysMonth-1 } --%>

<%-- <c:set var="sysDate1" value="${sysYear }-${sysMonth-1 }" /> --%>
<%-- <c:set var="sysDate2" value="${sysYear }-${sysMonth-2 }" /> --%>

<%-- <c:out value="${sysDate1 }" /> --%>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>판매자 빅이슈 수정</h3>
<hr>

<button class="btn btn-default" id="toList">목록</button><br><br>
<table class="table table-bordered">
<thead>
<tr>
	<td>지역(호선)</td>
	<td>판매장소</td>
	<td>출구(위치)</td>
	<td>판매자</td>
</tr>
</thead>

<tbody>
<c:if test="${sellerloc eq null }">
<tr>
	<td colspan="4">보유한 빅이슈가 없습니다.</td>
</tr>
</c:if>

<c:if test="${sellerloc ne null }">
<tr style="height: 80px;">
	<td>${sellerloc.zone }</td>
	<td>${sellerloc.station }</td>
	<td>${sellerloc.spot }</td>
	<td>${sellerloc.sellerId }</td>
</tr>
</c:if>
</tbody>
</table>

<table class="table table-bordered">
<thead>
<tr>
	<td style="width: 34%">보유 호수</td>
	<td style="width: 33%">보유 부수</td>
	<td style="width: 33%">수정|삭제</td>
</tr>
</thead>

<tbody>

<c:if test="${bookList.size() eq 0 }">
<tr>
	<td colspan="3">보유한 빅이슈가 없습니다.</td>
</tr>
</c:if>

<c:if test="${bookList.size() ne 0 }">
<c:forEach items="${bookList }" var="b">
<%-- <c:forEach var="i" begin="0" end="${bookList.size()-1 }" step="1"> --%>
<tr>
	<form action="/admin/book/view/update?magazineNo=${b.magazineNo }" method="post" style="display: inline;">
	<input type="hidden" name="sellerId" value="${sellerloc.sellerId }" />	
	<input type="hidden" name="month" value="${b.month }" />
	<td>${b.month }</td>
	<td><input style="text-align: center; width: 30px;" name="circulation" maxlength="3" type="text" value="${b.circulation }" /></td>
	<td>
		<button class="btn btn-xs btn-primary">수정</button>
	</form>
		<button id="mDelete" class="btn btn-xs btn-danger" onclick="mDelete('${b.magazineNo }','${sellerloc.sellerId }')">삭제</button>
	</td>
</tr>
</c:forEach>
</c:if>
</tbody>
</table>

<form name="addBook">
<input type="hidden" name="sellerId" value="${sellerloc.sellerId }" />
<table class="table table-bordered">
<caption>
	판매할 빅이슈를 추가하고 싶다면, 아래 표 작성 후 '추가' 버튼을 누르세요.<br>
	최근 3개월 간 발간된 빅이슈만 추가 가능합니다. 만약 이미 보유한 호수인 경우 부수만 추가됩니다.	
</caption>
<thead>
<tr>
	<td>판매할 호수</td>
	<td>판매할 부수</td>
</tr>
</thead>
<tr>
	<td style="width: 50%">
		<!-- 최근 3개월의 호수만 보여주고, 이미 보유한 호수인 경우 정보를 넣을 때 부수가 합쳐짐 -->
		<select style="height: 26px;" name="month">
			<option value="${sysYear }-${sysMonth-2 }">${sysYear }-${sysMonth-2 }</option>
			<option value="${sysYear }-${sysMonth-1 }">${sysYear }-${sysMonth-1 }</option>
			<option value="${sysDate }" selected>${sysDate }</option>
<%-- 			<c:forEach var="i" begin="0" end="${bookList.size()-1 }" step="1"> --%>
<%-- 			<c:if test="${bookList[i].month eq sysDate }"> --%>
<!-- 				<option value="month" disabled>11111</option> -->
<%-- 			</c:if> --%>
<%-- 			<c:if test="${bookList[i].month ne sysDate }"> --%>
<%-- 				<option value="month">${sysDate }</option> --%>
<%-- 			</c:if> --%>
<%-- 			</c:forEach> --%>
		</select>
<!-- 		<input style="width: 150px; text-align:center;" maxlength="3" type="text" name="month"/> -->
	</td>
	<td style="width: 50%">
		<input style="width: 30px; text-align:center;" name="circulation" maxlength="3" type="text"/>&nbsp;
		<button type="button" id="btnPlus" class="btn btn-xs btn-primary" onclick="addBookInfo('${sellerloc.sellerId }');">추가</button>		
	</td>
</tr>
</table>
</form>

<%-- <c:forEach var="i" begin="0" end="${bookList.size()-1 }" step="1"> --%>
<%-- 	<c:if test="${bookList[i].month ne sysDate }"> --%>
<%-- 	${bookList[i].month }////${sysdate } --%>
<%-- 	</c:if> --%>
<%-- </c:forEach> --%>
<%-- ${bookList } --%>

</div>

</div>