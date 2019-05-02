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

$(document).ready(function() {
	$("#toList").click(function() {
		location.href="/admin/book/list";
	});
});

function addBookInfo(sellerId) {
	if(!document.addBook.month.value) {
		alert("판매 호수를 입력하세요!");
		return false;
	}
	
	if(!document.addBook.circulation.value) {
		alert("판매 부수를 입력하세요!");
		return false;
	}
	
	form = document.addBook;
	form.method="post";
	form.action="/admin/book/addBook";
	form.submit();
}


</script>

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
<c:forEach var="i" begin="0" end="${bookList.size()-1 }" step="1">
<tr>
	<td>${bookList[i].month }</td>
	<td><input style="text-align: center; width: 30px;" maxlength="3" type="text" value="${bookList[i].circulation }" /></td>
	<td>
		<button class="btn btn-xs btn-primary">수정</button>
		<button class="btn btn-xs btn-danger">삭제</button>
	</td>
</tr>
</c:forEach>
</c:if>
</tbody>
</table>

<form name="addBook">
<input type="hidden" name="sellerId" value="${sellerloc.sellerId }" />
<table class="table table-bordered">
<caption>판매할 빅이슈를 추가하고 싶다면, 아래 표 작성 후 '추가' 버튼을 누르세요</caption>
<thead>
<tr>
	<td>판매할 호수</td>
	<td>판매할 부수</td>
</tr>
</thead>
<tr>
	<td style="width: 50%"><input style="width: 150px; text-align:center;" maxlength="3" type="text" name="month"/></td>
	<td style="width: 50%">
		<input style="width: 30px; text-align:center;" name="circulation" maxlength="3" type="text"/>&nbsp;
		<button type="button" id="btnPlus" class="btn btn-xs btn-primary" onclick="addBookInfo('${sellerloc.sellerId }');">추가</button>		
	</td>
</tr>
</table>
</form>

</div>

</div>