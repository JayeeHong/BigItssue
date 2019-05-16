<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 
 
    
<script type="text/javascript">
function noticeListGo(){
	window.location.href="/buyer/notice/list"
}
</script>



<div style="padding-top: 10px; padding-left: 11px;">
	
	<h3>${notice.noticeTitle }</h3>
	<span style="float: right;"><fmt:formatDate value="${notice.noticeDate }" pattern="YY-MM-dd HH:mm:ss" /></span>
	<br>
	<hr>
</div>
<br>

<div class="text-center">
	<br> ${notice.noticeContent } <br>
	<c:if test="${notice.noticeImg ne null}">
		<img style="width: 40%; height: 40%;" src="/img/${notice.noticeImg }">
	</c:if>
	<br> <br> <input type="button" class="btn" value="목록" onclick="noticeListGo()">
</div>



