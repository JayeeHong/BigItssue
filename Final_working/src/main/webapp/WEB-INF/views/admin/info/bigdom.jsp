<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
	.nav-tabs {
		border-bottom: none;
	}
	
	.table {
		text-align: center;
	}
	
	.table thead {
		font-weight: bold;
	}
	
	.table>tbody>tr>td {
		vertical-align: middle;
	}
	
	.table>thead>tr>td {
		vertical-align: middle;
	}
</style>

<script type="text/javascript">

function upBigdom(bigdomId) {
	$(location).attr("href", "/admin/info/bigdom/update?bigdomId="+bigdomId);
}

</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>계정관리</strong></h4>
<hr>

<div id="sellerList">
	<ul class="nav nav-tabs" style="height: 45px;">
		<li role="presentation"><a href="/admin/info/seller">판매자</a></li>
		<li role="presentation"><a href="/admin/info/buyer">구매자</a></li>
		<li role="presentation" class="active"><a href="/admin/info/bigdom">빅돔</a></li>
	</ul>
</div>

<div>

	<table class="table">
		<thead style="background: #cccccc6e">
			<tr>
				<td style="width: 10%">번호</td>
				<td style="width: 25%">빅돔 아이디</td>
				<td style="width: 25%">비밀번호</td>
				<td style="width: 25%">판매자 아이디</td>
				<td style="width: 15%">수정</td>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach varStatus="status" var="i" begin="0" end="${bigdomsellerList.size()-1 }" step="1">
			<tr>
				<c:if test="${curPage eq 0 }">
				<td>${(totalCount-status.index)-((1-1)*10) }</td>
				</c:if>
				<c:if test="${curPage ne 0 }">
				<td>${(totalCount-status.index)-((curPage-1)*10) }</td>
				</c:if>
				
				<td>${bigdomsellerList[i].bigdomId }</td>
				<td>${bigdomsellerList[i].bigdomPw }</td>
				<td>${bigdomsellerList[i].sellerId }</td>
				<td>
					<button class="btn btn-xs btn-primary" onclick="upBigdom('${bigdomsellerList[i].bigdomId }')">수정</button>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/admin/info/bigdom/paging.jsp"/>

</div>

</div>

</div>