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
		height: 50px;
	}
	
	.table>thead>tr>td {
		vertical-align: middle;
		height: 50px;
	}
</style>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>신고내역 상세페이지</h3>
<hr>

<table class="table">

<thead>
<tr>
	<td style="width: 33%">신고자</td>
	<td style="width: 33%">구매자</td>
	<td style="width: 34%">날짜</td>
</tr>
</thead>

<tbody>
<tr>
	<td>${reportByReportNo.reportId }</td>
	<td>${reportByReportNo.buyerId }</td>
	<td><fmt:formatDate value="${reportByReportNo.chatDate }" pattern="yyyy-MM-dd" /></td>
</tr>
</tbody>

</table>

<div class="chatContent">

<c:forEach var="i" begin="0" end="${chatReport.size()-1 }" step="1">

<c:choose>
	<c:when test="${chatReport[i].buyerId eq null }">
		<span style="font-weight: bold;">${chatReport[i].reportId }</span><br>
		${chatReport[i].chatContent }<br><br>
	</c:when>
	<c:when test="${chatReport[i].reportId eq null }">
		<span style="font-weight: bold;">${chatReport[i].buyerId }</span><br>
		${chatReport[i].chatContent }<br><br>
	</c:when>
	<c:otherwise>
		<span style="font-weight: bold; color: red;">${chatReport[i].buyerId }</span><br>
		<span style="color: red;">${chatReport[i].chatContent }</span><br><br>
	</c:otherwise>
</c:choose>

</c:forEach>

</div>

<div style="text-align: center;">
<button class="btn btn-default">목록</button>
</div>

</div>

</div>