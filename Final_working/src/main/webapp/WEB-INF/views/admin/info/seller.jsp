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
		<li role="presentation" class="active"><a href="/admin/info/seller">판매자</a></li>
		<li role="presentation"><a href="/admin/info/buyer">구매자</a></li>
		<li role="presentation"><a href="/admin/info/bigdom">빅돔</a></li>
	</ul>
</div>

<div>

	<table class="table">
		<thead>
			<tr>
				<td style="width: 80px">번호</td>
				<td style="width: 220px">판매자</td>
				<td style="width: 220px">아이디</td>
				<td style="width: 170px">비밀번호</td>
				<td style="width: 120px">연락처</td>
				<td style="width: 150px">수정|삭제</td>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="i" begin="0" end="${bigdomsellerList.size()-1 }" step="1">
			<tr>
				<td style="padding-top: 48px;" rowspan="3">${i+1 }</td>
				<td>${bigdomsellerList[i].sellerName }</td>
				<td>${bigdomsellerList[i].sellerId }</td>
				<td>${bigdomsellerList[i].sellerPw }</td>
				<td>${bigdomsellerList[i].sellerPhone }</td>
				<td style="padding-top: 45px;" rowspan="3">
					<button class="btn btn-xs btn-primary">수정</button>
					<button class="btn btn-xs btn-danger">삭제</button>
				</td>
			</tr>
			
			<tr>
				<td colspan="4">빅돔 아이디</td>
			</tr>
			<tr>
				<td colspan="4">
					${bigdomsellerList[i].bigdomId }
					<c:if test="${bigdomsellerList[i].bigdomId eq null }">
					빅돔이 없습니다
					</c:if>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

</div>

</div>