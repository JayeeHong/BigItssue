<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
$(document).ready(function() {
	$("#btnAdd").click(function() {
		console.log('체크');
	});
	
	$("#btnReturn").click(function() {
		window.history.back();
	});
});
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
  <c:if test="${detailList eq null }">
  <script type="text/javascript">
  	window.history.back();
  </script>
  </c:if>
  <c:if test="${detailList ne null}">
  <c:forEach items="${detailList }" var="list">
  	<tr>
  	  <td scope="row">${list.spot }</td>
  	  <td scope="row">판매자 이름</td>
  	  <td scope="row">${list.sellerId }</td>
  	  <td scope="row">이메일</td>
  	  <td scope="row"><button></button></td>
  	</tr>
  </c:forEach>
  </c:if>
  <tr>
  	<td scope="row"><button id="btnAdd">추가</button></td>
  	<td scope="row"></td>
  	<td scope="row"></td>
  	<td scope="row"></td>
  	<td scope="row"></td>
  </tr>
  </tbody>
</table>


<button>수정완료</button>
<button id="btnReturn">돌아가기</button>