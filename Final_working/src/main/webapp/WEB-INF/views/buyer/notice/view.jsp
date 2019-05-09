<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<script type="text/javascript">

function noticeListGo(){
	window.location.href="/buyer/notice/list"
}

</script>



<div class="" >

    
	<div class="container text-left" style="width:60%;">
    <h1><label>${notice.noticeTitle }</label></h1>
	 </div>
	 <br>
	<div class="container text-right" style=" width:60%;">
    <fmt:formatDate value="${notice.noticeDate }" var="i" pattern="YY-MM-dd"/>
    <label>${i }</label><br>
    <label>작성자:관리자</label>
	    <hr>	
	</div>
    <div class="container text-center">
	    <br>
	    ${notice.noticeContent }
	    <br>
	    <c:if test="${notice.noticeImg ne null}">
	    <img style="width: 40%; height: 40%;" src="/img/${notice.noticeImg }">	
	    </c:if>
	    <br>
    	<br>
		<input type="button" class="btn" value="목록" onclick="noticeListGo()">
    	</div>
		<br>
		<br>
	
		
	</div>