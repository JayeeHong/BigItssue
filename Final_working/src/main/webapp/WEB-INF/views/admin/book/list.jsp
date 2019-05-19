<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
	
	.table {
		text-align: center;
	}
	
	.table thead {
		font-weight: bold;
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
	
	.table>tbody>tr>td {
		vertical-align: middle;
	}
	
	.table>thead>tr>td {
		vertical-align: middle;
	}
	
</style>

<script type="text/javascript">

function sellerlocAll() {
// 	alert("전체");
	$(location).attr("href", "/admin/book/list");
}

function sellerlocDeactivate() {
// 	alert("비활성화 구역");
	$(location).attr("href", "/admin/book/list/deactivate");
}

function sellerlocActivate() {
// 	alert("활성화 구역");
	$(location).attr("href", "/admin/book/list/activate");
}

</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>판매자 빅이슈 관리</strong></h4>
<hr>

<button class="btn btn-default" style="font-weight: bold;" onclick="sellerlocAll();">전체</button>
<button class="btn btn-default" onclick="sellerlocActivate();">활성화 위치</button>
<button class="btn btn-default" onclick="sellerlocDeactivate();">비활성화 위치</button>
<br><br>
* 비활성화 상태인 판매처는 빅이슈를 관리할 수 없습니다.
<br><br>

<table class="table table-bordered">

<thead style="background: #cccccc6e;">
<tr>
	<th style="text-align:center; width: 10%">번호</th>
	<th style="text-align:center; width: 15%">지역(호선)</th>
	<th style="text-align:center; width: 30%">판매장소</th>
	<th style="text-align:center; width: 30%">출구(위치)</th>
	<th style="text-align:center; width: 15%">판매자</th>
</tr>
</thead>

<c:if test="${sellerlocList.size() eq 0 }">
<tbody>
<tr>
	<td colspan="5">판매처가 없습니다.</td>
</tr>
</tbody>
</c:if>

<c:if test="${sellerlocList.size() ne 0 }">
<tbody>
<c:forEach var="i" begin="0" end="${sellerlocList.size()-1 }" step="1">
<tr>
	<td>${sellerlocList[i].locNo }</td>
	<td>${sellerlocList[i].zone }</td>
	
	<c:if test="${sellerlocList[i].sellerId eq null }">
	<td>${sellerlocList[i].station }</td>
	</c:if>
	<c:if test="${sellerlocList[i].sellerId ne null }">
	<td><a href="/admin/book/view?sellerId=${sellerlocList[i].sellerId }">${sellerlocList[i].station }</a></td>
	</c:if>
	
	<td>${sellerlocList[i].spot }</td>
	<td>${sellerlocList[i].sellerId }</td>
</tr>
</c:forEach>
</tbody>
</c:if>

</table>

<jsp:include page="/WEB-INF/views/admin/book/paging.jsp"/>

</div>

</div>