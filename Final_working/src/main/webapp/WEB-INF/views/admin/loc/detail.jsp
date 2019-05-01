<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- jQuery 2.2.4 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
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

		$(location).attr("href", "/deleteList?station=null&spot="+td.eq(0).text());
	});
});

//새로운 장소 추가하기
function mapView(locNo){
	
	//팝업창 새로 띄우기
	window.open("/sellerLocMap?locNo="+locNo, "판매처지도", "width=400, height=300, left=100, top=50");
	
}
</script>

<h3>${station } DETAIL</h3>
<hr>


<table class="table" style="width: 50%; margin-left: 25%; margin-right: 25%;">
  <thead>
    <tr>
      <th scope="col">출구(위치)</th>
      <th scope="col">판매자</th>
      <th scope="col">아이디</th>
	  <th scope="col">이메일</th>
	  <th scope="col">삭제</th>
    </tr>
  </thead>
  <tbody>
  <c:if test="${empty detailList }">
  <script type="text/javascript">
  	window.history.back();
  </script>
  </c:if>
  <c:if test="${!empty detailList}">
  <c:forEach items="${detailList }" var="list">
  	<tr>
  	  <td scope="row">${list.get("SPOT") }</td>
  	  <td scope="row">${list.get("SELLERNAME") }</td>
  	  <td scope="row">${list.get("SELLERID") }</td>
  	  <td scope="row">이메일</td>
  	  <td scope="row"><button id="deleteBtn" class="btn btn-sm btn-danger">x</button></td>
  	</tr>
  </c:forEach>
  </c:if>
  </tbody>
</table>
<button id="btnAdd">추가</button>
<button id="returnBtn">돌아가기</button>