<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<script type="text/javascript">

function noticeListGo(){
	window.location.href="/buyer/notice/list"
}

</script>

<hr>

<div style="padding-top: 10px; padding-left: 11px;" class="text-left">
	<h2>
		<label>${notice.noticeTitle }</label>
	</h2>
</div>
<br>
<div class="text-right">
	<fmt:formatDate value="${notice.noticeDate }" var="i"
		pattern="YY-MM-dd" />
	<label>${i }</label><br> <label>작성자:관리자</label>
	<hr>
</div>
<div class="text-center">
	<br> ${notice.noticeContent } <br>
	<c:if test="${notice.noticeImg ne null}">
		<img style="width: 40%; height: 40%;" src="/img/${notice.noticeImg }">
	</c:if>
	<br> <br> <input type="button" class="btn" value="목록" onclick="noticeListGo()">
</div>
