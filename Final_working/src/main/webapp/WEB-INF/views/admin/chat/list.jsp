<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />
<script type="text/javascript">
$(document).ready(function() {
	
});
</script>
<div class="col-xs-12 col-sm-9">

<h3>채팅 내역 관리</h3>
<hr>
<table class="table table-bordered">
	<thead>
	<tr>
	<th style="width: 25%;">번호</th>
	<th style="width: 25%">날짜</th>
	<th style="width: 25%">판매자/빅돔</th>
	<th style="width: 25%">구매자</th>
 	</tr>
	</thead>
	<tbody>
	<c:forEach var="item" items="${message}" begin="0" end="${message.size()}" step="1">
		<tr>
		<th style="width: 25%">${item.chatRoomNo }</th>
		<th style="width: 25%"></th>
		<th style="width: 25%"></th>
		<th style="width: 25%"></th>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>

</div>