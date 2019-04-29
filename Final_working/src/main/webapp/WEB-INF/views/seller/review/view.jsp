<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 


<script type="text/javascript">
$(document).ready(function() {
	$("#btnList").click(function() {
		location.href = "/seller/review/list";
	});
	
	$("#btnUpdate").click(function() {
		$(location).attr("href", "/seller/review/update?reviewno=${reviewView.reviewNo }");
	});
	
	$("#btnDelete").click(function() {
		alert("삭제?");
		$(location).attr("href", "/seller/review/delete?reviewno=${reviewView.reviewNo }");
	});

});
</script>


<style type="text/css">
#review { padding-top: 50px; }
#btnBox { text-align: center; }
</style>



<div id="review">
	<table class="table table-bordered">	
		<tr>
			<td style="width: 25%">아이디</td><td style="width: 25%">${reviewView.sellerId }</td>
			<td style="width: 25%">조회수</td><td>${reviewView.reviewHit }</td>
		</tr>
	
		<tr>
			<td>제목</td><td colspan="4">${reviewView.reviewTitle }</td>
		</tr>
	
		<tr>
			<td style="height: 300px;">본문</td><td colspan="4">${reviewView.reviewContent }</td>
		</tr>
		
		<tr>
			<td>작성일</td><td colspan="4"><fmt:formatDate value="${reviewView.reviewDate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
	</table>


	<div id="btnBox">
		<button id="btnList" class="btn">목록</button>
		<button id="btnUpdate" class="btn">수정</button>
		<button id="btnDelete" class="btn">삭제</button><br><br><br>
		
	</div>
</div>

























