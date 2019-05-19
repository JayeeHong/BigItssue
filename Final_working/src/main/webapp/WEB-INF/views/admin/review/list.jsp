<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 




<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>후기게시판 관리</strong></h4>
<hr>


<div id="reviewList">
	
	<div>
		<table class="table table-hover">
			<thead style="text-align: center;">
				<tr>
					<th style="text-align:center; width: 10%">글번호</th>
					<th style="text-align:center; width: 50%">제목</th>
					<th style="text-align:center; width: 15%">작성자</th>
					<th style="text-align:center; width: 15%">작성일</th>
					<th style="text-align:center; width: 10%">조회수</th>
				</tr>
			</thead>
			
			<tbody>
				<c:forEach items="${reviewList }" var="r">
				<tr>
					<td style="text-align:center;">${r.reviewNo }</td>
					<td><a href="/admin/review/view?reviewNo=${r.reviewNo }">${r.reviewTitle }<span style="color: red; padding-left: 5px; font-size: small; ">[${r.replyCnt }]</span></a></td>
					<td style="text-align:center;">${r.sellerId }</td>
					<td style="text-align:center;"><fmt:formatDate value="${r.reviewDate }" pattern="yyyy-MM-dd"/></td>
					<td style="text-align:center;">${r.reviewHit }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<jsp:include page="paging.jsp" />

	
</div>
</div>
</div>