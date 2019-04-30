<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<div class="text-center">
<ul class="pagination pagination-sm">
	<c:if test="${paging.curPage ne 1 }">
	<li><a href="/admin/seller/list?curPage=1&condition=${condition }&searchWord=${searchWord }">&larr;처음</a></li>
	</c:if>
	
	<c:if test="${paging.curPage le paging.pageCount }">
	<li class="disabled"><span>&laquo;</span></li>
	</c:if>
	<c:if test="${paging.curPage gt paging.pageCount }">
	<li><a href="/admin/seller/list?curPage=${paging.startPage-paging.pageCount}&condition=${condition }&searchWord=${searchWord }">&laquo;</a></li>
	</c:if>
	
	
	<c:if test="${paging.curPage eq 1 }">
	<li class="disabled"><span>&lt;</span></li>
	</c:if>
	<c:if test="${paging.curPage ne 1 }">
	<li><a href="/admin/seller/list?curPage=${paging.curPage-1}&condition=${condition }&searchWord=${searchWord }">&lt;</a></li>
	</c:if>

	
	<c:forEach begin="${paging.startPage }"
	 end="${paging.endPage }"
	 var="i">
	
	<c:if test="${paging.curPage eq i}">
	<li class="active"><a href="/admin/seller/list?curPage=${i }&condition=${condition }&searchWord=${searchWord }">${i }</a></li>
	</c:if>
	<c:if test="${paging.curPage ne i}">
	<li><a href="/admin/seller/list?curPage=${i }&condition=${condition }&searchWord=${searchWord }">${i }</a></li>
	</c:if>
	
	</c:forEach>
	
	<c:if test="${paging.curPage eq paging.totalPage }">
	<li class="disabled"><span>&gt;</span></li>
	</c:if>
	<c:if test="${paging.curPage ne paging.totalPage }">
	<li><a href="/admin/seller/list?curPage=${paging.curPage+1}&condition=${condition }&searchWord=${searchWord }">&gt;</a></li>
	</c:if>
	
	<c:if test="${paging.endPage eq paging.totalPage }">
	<li class="disabled"><span>&raquo;</span></li>
	</c:if>
	<c:if test="${paging.endPage ne paging.totalPage }">
	<li><a href="/admin/seller/list?curPage=${paging.startPage+paging.pageCount}&condition=${condition }&searchWord=${searchWord }">&raquo;</a></li>
	</c:if>
	
</ul>
</div>




















