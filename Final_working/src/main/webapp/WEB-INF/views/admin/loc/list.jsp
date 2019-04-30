<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
$(document).ready(function() {
	$('#insertBtn').click(function() {
		console.log('체크');
	});
});
</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>판매장소 관리</h3>
<hr>

<form action="/admin/loc/list" method="get">
	<input list="zone" name="zone"/>
		<datalist id="zone">
			<option value="1">
			<option value="2">
			<option value="3">
			<option value="4">
			<option value="5">
		</datalist>
	<button id="selectZone">검색</button>
</form>
<table class="table" style="width: 50%; margin-left: 25%; margin-right: 25%;">
  <thead>
    <tr>
      <th scope="col">판매장소</th>
    </tr>
  </thead>
  <tbody>
  <c:if test="${locList eq null }">
    <tr>
      <th scope="row">장소 없음</th>
    </tr>
  </c:if>
  <c:if test="${locList ne null}">
  <c:forEach items="${locList }" var="list">
  	<tr>
  	  <td scope="row"><button></button></td>
  	  <td scope="row"><a href="/admin/loc/detail?station=${list.station }">${list.station }</a></td>
  	</tr>
	
  </c:forEach>
  </c:if>
  </tbody>
</table>

<button id="insertBtn">추가하기</button>

</div>

</div>
