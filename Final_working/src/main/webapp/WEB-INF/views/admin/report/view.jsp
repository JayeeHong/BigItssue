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

<script type="text/javascript">

</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>신고내역 상세 대화내용</strong></h4>
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

<%-- ${chatReport[i].chatContent }&nbsp;&nbsp; --%>
<%-- <small><fmt:formatDate value="${chatReport[i].chatDate }" pattern="yyyy-MM-dd hh:mm" /></small> --%>
<!-- <br><br> -->

<%-- <c:choose> --%>
<%-- 	<c:when test="${chatReport[i].buyerId eq null }"> --%>
<%-- 		<span style="font-weight: bold;">${chatReport[i].reportId }</span><br> --%>
<%-- 		${chatReport[i].chatContent }&nbsp;&nbsp; --%>
<%-- 		<small><fmt:formatDate value="${chatReport[i].chatDate }" pattern="yyyy-MM-dd hh:mm" /></small> --%>
<!-- 		<br><br> -->
<%-- 	</c:when> --%>
<%-- 	<c:when test="${chatReport[i].reportId eq null }"> --%>
<%-- 		<span style="font-weight: bold;">${chatReport[i].buyerId }</span><br> --%>
<%-- 		${chatReport[i].chatContent }&nbsp;&nbsp; --%>
<%-- 		<small><fmt:formatDate value="${chatReport[i].chatDate }" pattern="yyyy-MM-dd hh:mm" /></small> --%>
<!-- 		<br><br> -->
<%-- 	</c:when> --%>
<%-- 	<c:otherwise> --%>
<%-- 		<span style="font-weight: bold; color: red;">${chatReport[i].buyerId }</span><br> --%>
<%-- 		<span style="color: red;">${chatReport[i].chatContent }</span>&nbsp;&nbsp; --%>
<%-- 		<small><fmt:formatDate value="${chatReport[i].chatDate }" pattern="yyyy-MM-dd hh:mm" /></small> --%>
<!-- 		<br><br> -->
<%-- 	</c:otherwise> --%>
<%-- </c:choose> --%>

<c:choose>
	<%-- 신고당한 사람과 메세지 정보가 같지 않을 때 --%>
	<c:when test="${chatReport[i].chatSender ne reportByReportNo.buyerId }">
		<c:if test="${chatReport[i].chatContent ne reportByReportNo.chatContent }">
			<span style="font-weight: bold;">${chatReport[i].chatSender }</span><br>
			${chatReport[i].chatContent }&nbsp;&nbsp;
			<small><fmt:formatDate value="${chatReport[i].chatDate }" pattern="yyyy-MM-dd hh:mm" /></small>
			<br><br>
		</c:if>
	</c:when>
	
	<%-- 신고당한 사람과 메세지 정보가 같을때 --%>
	<c:when test="${chatReport[i].chatSender eq reportByReportNo.buyerId }">
		<c:if test="${chatReport[i].chatContent eq reportByReportNo.chatContent }">
<%-- 			신고당한사람: ${chatReport[i].chatSender }<br> --%>
<%-- 			신고당한메세지: ${reportByReportNo.chatContent }<br> --%>
			<span style="font-weight: bold; color: red;">${chatReport[i].chatSender }</span><br>
			${chatReport[i].chatContent }&nbsp;&nbsp;
			<small><fmt:formatDate value="${chatReport[i].chatDate }" pattern="yyyy-MM-dd hh:mm" /></small>
			<br><br>
		</c:if>
		<c:if test="${chatReport[i].chatContent ne reportByReportNo.chatContent }">
<%-- 			신고당한사람: ${chatReport[i].chatSender }<br> --%>
<%-- 			신고당한메세지: ${reportByReportNo.chatContent }<br> --%>
			<span style="font-weight: bold;">${chatReport[i].chatSender }</span><br>
			${chatReport[i].chatContent }&nbsp;&nbsp;
			<small><fmt:formatDate value="${chatReport[i].chatDate }" pattern="yyyy-MM-dd hh:mm" /></small>
			<br><br>
		</c:if>
	</c:when>
</c:choose>

</c:forEach>

</div>

<div style="text-align: center;">
<a href="#" onclick="history.go(-1); return false;"><button class="btn btn-default">목록</button></a>
</div>

</div>

</div>

<br><br><br>