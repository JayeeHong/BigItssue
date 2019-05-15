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

function upBuyer(buyerId) {
	$(location).attr("href", "/admin/info/buyer/update?buyerId="+buyerId);
}

function delBuyer(buyerId) {
	result = confirm('구매자 정보를 삭제하시겠습니까?');
	
	if(result==true) {
		$(location).attr("href", "/admin/info/buyerDel?buyerId="+buyerId);
	} else {
		return false;
	}
}

</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>계정관리</h3>
<hr>

<div id="sellerList">
	<ul class="nav nav-tabs" style="height: 45px;">
		<li role="presentation"><a href="/admin/info/seller">판매자</a></li>
		<li role="presentation" class="active"><a href="/admin/info/buyer">구매자</a></li>
		<li role="presentation"><a href="/admin/info/bigdom">빅돔</a></li>
	</ul>
</div>

<div>

	<table class="table">
		<thead style="background: #cccccc6e">
			<tr>
				<td style="width: 10%">번호</td>
				<td style="width: 15%">구매자</td>
				<td style="width: 15%">아이디</td>
<!-- 				<td style="width: 15%">비밀번호</td> -->
				<td style="width: 15%">이메일</td>
				<td style="width: 15%">연락처</td>
				<td style="width: 15%">수정|삭제</td>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach varStatus="status" var="i" begin="0" end="${buyerList.size()-1 }" step="1">
			<tr>
				<c:if test="${curPage eq 0 }">
				<td>${(totalCount-status.index)-((1-1)*10) }</td>
				</c:if>
				<c:if test="${curPage ne 0 }">
				<td>${(totalCount-status.index)-((curPage-1)*10) }</td>
				</c:if>
				
				<td>${buyerList[i].buyerName }</td>
				<td>${buyerList[i].buyerId }</td>
<%-- 				<td>${buyerList[i].buyerPw }</td> --%>
				<td>${buyerList[i].buyerEmail }</td>
				<td>${buyerList[i].buyerPhone }</td>
				<td>
					<button class="btn btn-xs btn-primary" onclick="upBuyer('${buyerList[i].buyerId }');">수정</button>
					<button class="btn btn-xs btn-danger" onclick="delBuyer('${buyerList[i].buyerId }')">삭제</button>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<jsp:include page="/WEB-INF/views/admin/info/buyer/paging.jsp"/>

</div>

</div>

</div>