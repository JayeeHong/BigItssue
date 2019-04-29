<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
	.nav-tabs {
		border-bottom: none;
	}
	
	.table {
		display: list-item;
		list-style: none;
		text-align: center;
	}
</style>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

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
				<td style="width: 80px">번호</td>
				<td style="width: 220px">구매자</td>
				<td style="width: 220px">아이디</td>
				<td style="width: 170px">비밀번호</td>
				<td style="width: 190px">이메일</td>
				<td style="width: 120px">연락처</td>
				<td style="width: 150px">수정|삭제</td>
			</tr>
		</thead>
		
		<tbody>
			<tr>
				<td>번호</td>
				<td>구매자</td>
				<td>아이디</td>
				<td>비밀번호</td>
				<td>이메일</td>
				<td>전화번호</td>
				<td>
					<button class="btn btn-xs btn-primary">수정</button>
					<button class="btn btn-xs btn-danger">삭제</button>
				</td>
			</tr>
		</tbody>
	</table>

</div>

</div>