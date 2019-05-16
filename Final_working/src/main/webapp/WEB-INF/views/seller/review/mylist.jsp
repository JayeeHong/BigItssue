<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 


<script type="text/javascript">
$(document).ready(function() {
	$("#btnWrite").click(function() {
		location.href = "/seller/review/write";
	});
});
</script>


<style type="text/css">
#btnBox { text-align: right; }
#reviewList { padding-top: 10px; }
</style>


<div style="padding-top: 10px;">
<h4><strong>나의 후기</strong></h4>
<hr>
</div>

<div id="reviewList">

	<div style="text-align: right; line-height: 0;">
		<form action="/seller/review/mylist" method="get" class="form-inline">
			<input type="text" class="form-control" name="search" style="height: 30px;" placeholder="제목 검색">
			<button class="btn btn-sm">검색</button>
		</form>
	</div>


	<ul class="nav nav-tabs">
	  <li role="presentation"><a href="/seller/review/list">전체</a></li>
	  <li role="presentation" class="active"><a href="/seller/review/mylist">내 글</a></li>
	</ul>

	<div>
		<table class="table table-hover">
			<thead>
				<tr style="background: #cccccc6e;">
					<th style="width: 10%">글번호</th>
					<th style="width: 50%">제목</th>
					<th style="width: 15%">작성자</th>
					<th style="width: 15%">작성일</th>
					<th style="width: 10%">조회수</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${reviewMylist }" var="r">
				<tr>
					<td>${r.reviewNo }</td>
					<td><a href="/seller/review/view?reviewNo=${r.reviewNo }">${r.reviewTitle }<span style="color: red; padding-left: 5px; font-size: small; ">[${r.replyCnt }]</span></a></td>
					<td>${r.sellerId }</td>
					<td><fmt:formatDate value="${r.reviewDate }" pattern="yyyy-MM-dd"/></td>
					<td>${r.reviewHit }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<jsp:include page="pagingMylist.jsp" />

	<div id="btnBox">
		<button id="btnWrite" class="btn">글쓰기</button>
	</div>
</div>