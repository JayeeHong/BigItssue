<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<script type="text/javascript">
$(document).ready(function() {
	$("#btnWrite").click(function() {
		location.href = "/admin/banner/write";
	});
	
	$("#btnUpdate").click(function() {
		
	});
	
	$("#btnDelete").click(function() {
		
	});
});
</script>








<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>배너관리</h3>
<hr>

	<table class="table">
		<thead>
			<tr>
				<th>배너 번호</th>
				<th>배너 이미지</th>
				<th>수정 / 삭제</th>
			</tr>
		</thead>
		
		<tbody>
		<c:forEach items="${bannerList}" var="b">
			<tr>
				<td>${b.bannerNo }</td>
				<td>${b.bannerImg }</td>
				<td>
					<button id="btnUpdate">수정</button>
					<button id="btnDelete">삭제</button>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>








</div>

</div>