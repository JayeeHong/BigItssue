<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
tbody tr:hover {
	background: silver;
} 
</style>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />
<script type="text/javascript">
$(document).ready(function() {
	
});

//대화 내역 상세보기
function detailChatView(chatRoomNo){
	//페이지 이동
	window.location.href="/admin/chat/view?chatRoomNo="+chatRoomNo;
}
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
		<tr class="detailChatView" onclick="detailChatView(${item.chatRoomNo})">
		<th style="width: 25%">${item.chatRoomNo }</th>
		<th style="width: 25%"><fmt:formatDate value="${item.chatFinalDate }" pattern="yyyy-MM-dd"/></th>
		<th style="width: 25%">
			<c:if test="${item.bigdomId ne null }">
				${item.bigdomId }
			</c:if>
			<c:if test="${item.bigdomId eq null }">
				${item.sellerId }
			</c:if>
		</th>
		<th style="width: 25%">${item.buyerId }</th>
		</tr>
	</c:forEach>
	</tbody>
</table>
</div>
<div class="text-center"><!-- 부트스트랩 지원 클래스 -->
<ul class="pagination pagination-sm">
	<%-- 이전 페이지그룹 --%>
	<c:if test="${paging.curPage le paging.pageCount }">
	<li class="disabled"><span>&laquo;</span></li>
	</c:if>
	
	<c:if test="${paging.curPage gt paging.pageCount }">
	<li><a href="/admin/chat/list?curPage=${paging.startPage-paging.pageCount }">&laquo;</a></li>
	</c:if>
	
	<%-- 이전 페이지 --%>
	<c:if test="${paging.curPage eq 1 }">
	<li class="disabled"><span>&lt;</span></li>
	</c:if>

	<c:if test="${paging.curPage ne 1 }">
	<li><a href="/admin/chat/list?curPage=${paging.curPage-1 }">&lt;</a></li>
	</c:if>

	<%-- 페이징 리스트 --%>
	<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="i">
	
		<c:if test="${paging.curPage eq i }">
		<li class="active"><a href="/admin/chat/list?curPage=${i }">${i }</a></li>
		</c:if>
		
		<c:if test="${paging.curPage ne i }">
		<li><a href="/admin/chat/list?curPage=${i }">${i }</a></li>
		</c:if>
	
	</c:forEach>
	

	<%-- 다음 페이지 --%>
	<c:if test="${paging.curPage eq paging.totalPage }">
	<li class="disabled"><span>&gt;</span></li>
	</c:if>
	
	<c:if test="${paging.curPage ne paging.totalPage }">
	<li><a href="/admin/chat/list?curPage=${paging.curPage+1 }">&gt;</a></li>
	</c:if>
	
	<%-- 다음 페이지그룹 --%>
	<c:if test="${paging.endPage eq paging.totalPage }">
	<li class="disabled"><span>&raquo;</span></li>
	</c:if>
	
	<c:if test="${paging.endPage ne paging.totalPage }">
	<li><a href="/admin/chat/list?curPage=${paging.startPage+paging.pageCount }">&raquo;</a></li>
	</c:if>
</ul>
</div>
</div>
