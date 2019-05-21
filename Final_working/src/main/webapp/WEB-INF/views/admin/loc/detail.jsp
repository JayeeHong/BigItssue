<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>


<style type="text/css">

.table {
	text-align: center;
	vertical-align: middle;
}

</style>


<script type="text/javascript">
$(document).ready(function() {
	$("#btnAdd").click(function() {
		$(location).attr("href", "/insertList?zone=${zone }&station=${station }");
	});
	
	$("#returnBtn").click(function() {
		window.history.back();
	});
	
	$(".btn-danger").click(function() {
		var tr = $(this).parent().parent();
		var td = tr.children();

		$(location).attr("href", "/deleteList?station=${station }&spot="+td.eq(0).text());
	});
});

//새로운 장소 추가하기
function mapView(locNo){
	
	//팝업창 새로 띄우기
	window.open("/sellerLocMap?locNo="+locNo, "판매처지도", "width=400, height=300, left=100, top=50");
	
}
</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>판매장소 정보 [${station }]</strong></h4>
<hr>

<table class="table" style="width: 70%; margin-left: 13%;">
  <thead>
    <tr>
      <th style="text-align: center;" scope="col">출구(위치)</th>
      <th style="text-align: center;" scope="col">판매자</th>
      <th style="text-align: center;" scope="col">아이디</th>
<!-- 	  <th style="text-align: center;" scope="col">이메일</th> -->
	  <th style="text-align: center;" scope="col">삭제</th>
    </tr>
  </thead>
  <tbody>
  <c:if test="${empty detailList }">
  <script type="text/javascript">
  	alert("판매자가 등록되지 않았습니다! 판매 정보 관리 페이지로 이동합니다!!");
  	document.location.href = "/admin/seller/list";
  </script>
  </c:if>
  <c:if test="${!empty detailList}">
  <c:forEach items="${detailList }" var="list">
  	<tr>
  	  <td scope="row">${list.get("SPOT") }</td>
  	  <td scope="row">${list.get("SELLERNAME") }</td>
  	  <td scope="row">${list.get("SELLERID") }</td>
<%--   	  <td scope="row">${list.get("SELLEREMAIL") }</td> --%>
  	  <td scope="row"><button id="deleteBtn" class="btn btn-xs btn-danger">x</button></td>
  	</tr>
  </c:forEach>
  </c:if>
  </tbody>
</table>
<button class="btn btn-primary" id="btnAdd">추가</button>
<button class="btn btn-default" id="returnBtn">돌아가기</button>

</div>

</div>