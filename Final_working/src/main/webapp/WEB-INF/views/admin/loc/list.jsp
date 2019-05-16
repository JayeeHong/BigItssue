<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">

	a:link {
		color: #000000;
	}
	
	a:visited {
		color: #000000;
	}
	
	a:active {
		color: #000000;
	}
	
	a:focus {
		color: #000000;
		text-decoration: underline;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	//페이지 이동
	$('#insertBtn').click(function() {
		$(location).attr("href", "/insertList?zone=${zone }");
	});
	
	$(".btn-danger").click(function() {
		var tr = $(this).parent().parent();
		var td = tr.children();

		$(location).attr("href", "/deleteList?station="+td.eq(1).text());
	});
});
</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>판매장소 관리</strong></h4>
<hr>

<form action="/admin/loc/list" method="get">
	<input style="height: 34px;" list="zone" name="zone"/>
		<datalist id="zone">
			<option value="1호선">
			<option value="2호선">
			<option value="3호선">
			<option value="4호선">
			<option value="5호선">
			<option value="6호선">
			<option value="7호선">
			<option value="8호선">
			<option value="9호선">
			<option value="부산">
		</datalist>
	<button class="btn btn-default" id="selectZone">검색</button>
</form>
<br>
<table class="table" style="width: 50%; margin-left: 25%; margin-right: 25%;">
  <thead>
    <tr>
      <th scope="col" colspan="2">판매장소 목록</th>
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
  	  <td scope="row"><button class="btn btn-sm btn-danger">x</button></td>
  	  <td style="vertical-align: middle;" scope="row"><a style="font-weight: bold;" href="/admin/loc/detail?zone=${zone }&station=${list.station }">${list.station }</a></td>
  	</tr>
	
  </c:forEach>
  </c:if>
  </tbody>
</table>

<button class="btn btn-primary" id="insertBtn">추가하기</button>

</div>

</div>

<br><br><br><br><br>
