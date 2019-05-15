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
	
	.table tbody tr td a:link {
		color: #000000;
		font-weight: bold;
	}
	
	a:visited {
		color: #000000;
	}
	
	a:active {
		color: #000000;
	}
</style>

<script type="text/javascript">

</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>문의하기 신고내역</strong></h4>
<hr>

<table class="table table-bordered">

<thead>
<tr>
	<td style="width: 10%">번호</td>
	<td style="width: 15%">신고자</td>
	<td style="width: 15%">구매자</td>
	<td style="width: 40%">신고한 대화</td>
	<td style="width: 20%">날짜</td>
</tr>
</thead>

<tbody>
<c:forEach varStatus="status" var="i" begin="0" end="${chatReportList.size()-1 }" step="1">
	<tr>
		<c:if test="${curPage eq 0 }">
		<td>${(totalCount-status.index)-((1-1)*10) }</td>
		</c:if>
		<c:if test="${curPage ne 0 }">
		<td>${(totalCount-status.index)-((curPage-1)*10) }</td>
		</c:if>
		
		<td>${chatReportList[i].reportId }</td>
		<td>${chatReportList[i].buyerId }</td>
		<td><a href="/admin/report/view?reportNo=${chatReportList[i].reportNo }">${chatReportList[i].chatContent }</a></td>
		<td><fmt:formatDate value="${chatReportList[i].chatDate }" pattern="yyyy-MM-dd"/></td>
	</tr>
</c:forEach>
</tbody>

</table>

<jsp:include page="/WEB-INF/views/admin/report/paging.jsp"/>

</div>

</div>