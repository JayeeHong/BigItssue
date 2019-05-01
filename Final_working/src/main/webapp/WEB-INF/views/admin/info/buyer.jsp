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
</style>

<script type="text/javascript">

function upSeller(buyerId) {
	$(location).attr("href", "/admin/info/buyer/update?buyerId="+buyerId);
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
		<thead>
			<tr>
				<td style="width: 10%">번호</td>
				<td style="width: 15%">구매자</td>
				<td style="width: 15%">아이디</td>
				<td style="width: 15%">비밀번호</td>
				<td style="width: 15%">이메일</td>
				<td style="width: 15%">연락처</td>
				<td style="width: 15%">수정|삭제</td>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="i" begin="0" end="${buyerList.size()-1 }" step="1">
			<tr>
				<td>${i+1 }</td>
				<td>${buyerList[i].buyerName }</td>
				<td>${buyerList[i].buyerId }</td>
				<td>${buyerList[i].buyerPw }</td>
				<td>${buyerList[i].buyerEmail }</td>
				<td>${buyerList[i].buyerPhone }</td>
				<td>
					<button class="btn btn-xs btn-primary" onclick="upBuyer('${buyerList[i].buyerId}');">수정</button>
					<button class="btn btn-xs btn-danger">삭제</button>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

</div>

</div>

</div>