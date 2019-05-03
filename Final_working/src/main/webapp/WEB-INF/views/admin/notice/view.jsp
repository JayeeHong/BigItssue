<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<script type="text/javascript">

function noticeListGo(){
	window.location.href="/admin/notice/list"
}

function noticeUpdate(a){
	window.location.href="/admin/notice/update?noticeNo="+a
}

function noticeDelete(a){
	
	var ct = confirm('삭제하시겠습니까?')
	if(ct== true){
		window.location.href="/admin/notice/delete?noticeNo="+a
	}	
		
	
	
}

</script>

<style>

.tdLeft{
	background: #e6e4e4;	
}



</style>
<div class="row row-offcanvas row-offcanvas-right" >

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

    
	<div class="container text-center" style="float:left; width:70%;">
    <table class="table">
    <tr>
    <td class="tdLeft text-center"><br><b>제목</b></td>
    <td class="text-left"><h1>${notice.noticeTitle }</h1></td>
    
    </tr>
    
    <tr>
    <td class="tdLeft text-center"><b>내용</b></td>
    <td></td>
    </tr>

    </table>
	    <div>
	    	
	    <br>
	    <c:if test="${notice.noticeImg ne null}">
	    <img style="width: 40%; height: 40%;" src="/img/${notice.noticeImg }">	
	    </c:if>
	    <br>
	    ${notice.noticeContent }
    
    	</div>
		<br>
		<br>
	
		<input type="button" class="btn" value="목록" onclick="noticeListGo()">
		<input type="button" class="btn btn-info" value="수정" onclick="noticeUpdate(${notice.noticeNo})">
		<input type="hidden" value="${notice.noticeNo }" name="noticeNo">
		<input type="button" class="btn btn-danger" value="삭제" onclick="noticeDelete(${notice.noticeNo})">
		
	</div>
 </div>