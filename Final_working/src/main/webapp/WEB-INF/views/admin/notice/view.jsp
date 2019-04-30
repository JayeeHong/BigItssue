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
    
	<div class="container">
    <table class="table">
    <tr>
    <td class="tdLeft text-center"><br><b>제목</b></td>
    <td><h1>${notice.noticeTitle }</h1></td>
    
    </tr>
    
    <tr>
    <td class="tdLeft text-center"><b>내용</b></td>
    <td></td>
    </tr>

    </table>
    	<div>
    	
    ${notice.noticeContent }
    <br>
    <c:if test="${notice.noticeImg ne null}">
    <img style="width: 40%; height: 40%;" src="/img/${notice.noticeImg }">	
    
    </c:if>
    
    	</div>
	<input type="button" class="btn" value="목록" onclick="noticeListGo()">
	</div>
	<div>
	
	</div>
	
	<div class="container text-center">
	<input type="button" class="btn btn-info" value="수정" onclick="noticeUpdate(${notice.noticeNo})">
	<input type="hidden" value="${notice.noticeNo }" name="noticeNo">
	<input type="button" class="btn btn-danger" value="삭제" onclick="noticeDelete(${notice.noticeNo})">
	
	</div>    
    