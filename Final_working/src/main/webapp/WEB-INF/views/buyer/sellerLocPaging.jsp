<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<script type="text/javascript">

$(document).ready(function(){


});

</script>

<div class="text-center">

<ul class="pagination pagination-sm" style="cursor:pointer;">
	<li>
	<%-- 이전 페이지 그룹 --%>
	<c:if test="${paging.curPage le paging.pageCount }">
	<li class="disabled"><span>&laquo;</span></li>
	</c:if>
	
	<c:if test="${paging.curPage gt paging.pageCount }">
<%-- 	<li><a href="/buyer/main?curPage=${paging.startPage-paging.pageCount }&zoneSelect=${paging.zone }&stationSelect=${paging.station}">&laquo;</a></li> --%>
	<li><a onclick="pagingFunc(${paging.startPage-paging.pageCount })">&laquo;</a></li>
	</c:if>
	
	<%-- 이전 페이지 --%>
	<c:if test="${paging.curPage eq 1 }">
	<li class="disabled"><span>&lt;</span></li>
	</c:if>
	
	<c:if test="${paging.curPage ne 1 }">
<%-- 	<li><a href="/buyer/main?curPage=${paging.curPage-1}&zoneSelect=${paging.zone }&stationSelect=${paging.station}">&lt;</a></li> --%>
	<li><a onclick="pagingFunc(${paging.curPage-1})">&lt;</a></li>
	</c:if>
	
	<%-- 페이징 리스트 --%>
	<c:forEach begin="${paging.startPage }"
		end="${paging.endPage }"
		var="i">
		
		<c:if test="${paging.curPage eq i}">
<%-- 		<li class="active"><a href="/buyer/main?curPage=${i}&zoneSelect=${paging.zone }&stationSelect=${paging.station}">${i }</a></li> --%>
		<li class="active"><a onclick="pagingFunc(${i})">${i }</a></li>
		</c:if>
		
		<c:if test="${paging.curPage ne i}">
<%-- 		<li><a href="/buyer/main?curPage=${i}&zoneSelect=${paging.zone }&stationSelect=${paging.station}">${i }</a></li> --%>
		<li><a onclick="pagingFunc(${i})">${i }</a></li>
		</c:if>	
	
	</c:forEach>
	
	<%-- 다음 페이지 --%>
	<c:if test="${paging.curPage eq paging.totalPage }">
	<li class="disabled"><span>&gt;</span></li>
	</c:if>
	
	<c:if test="${paging.curPage ne paging.totalPage }">
<%-- 	<li><a href="/buyer/main?curPage=${paging.curPage+1}&zoneSelect=${paging.zone }&stationSelect=${paging.station}">&gt;</a></li> --%>
	<li><a onclick="pagingFunc(${paging.curPage+1})">&gt;</a></li>
	</c:if>
	
	<%-- 다음 페이지 그룹 --%>
	<c:if test="${paging.endPage eq paging.totalPage }&zoneSelect=${paging.zone }&stationSelect=${paging.station}">
	<li class="disabled"><span>&raquo;</span></li>
	</c:if>
	
	<c:if test="${paging.endPage ne paging.totalPage }">
<%-- 	<li><a href="/buyer/main?curPage=${paging.startPage+paging.pageCount}&zoneSelect=${paging.zone }&stationSelect=${paging.station}">&raquo;</a></li> --%>
	<li><a onclick="pagingFunc(${paging.startPage+paging.pageCount})">&raquo;</a></li>
	</c:if>
	
	
	<%-- 마지막페이지 --%>
<%-- 	<c:if test="${paging.curPage ne paging.endPage }"> --%>
<%-- 	<li><a href="/buyer/main?curPage=${paging.totalPage}&zoneSelect=${paging.zone }&stationSelect=${paging.station}"><span>&rarr;마지막</span></a></li> --%>
<%-- 	</c:if> --%>
	
</ul>
</div>