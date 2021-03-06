<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


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
p{
word-break:break-all;
word-wrap:break-word;

}
</style>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<div>
<!-- 	<div class="container text-left" style="width:60%; height:70px;"> -->
    <h3><label>${notice.noticeTitle }</label></h3>
<!-- 	</div> -->
	
	<div class="text-right" style="height:70px;">
	    <fmt:formatDate value="${notice.noticeDate }" pattern="YY-MM-dd HH:mm:ss" />
		<hr>	
	</div>
 	
 	<div>
	    <br>
		<p style="width: auto;">
	    ${notice.noticeContent }
		</p>
	    <br>
	    <c:if test="${notice.noticeImg ne null}">
	    <img style="width: 40%; height: 40%;" src="/img/${notice.noticeImg }">	
	    </c:if>
	    <br>
    	<br>
		
    </div>
    
    <div style="text-align: center;">
    	<input type="button" class="btn btn-default" value="목록" onclick="noticeListGo()">
<%-- 		<input type="button" class="btn" value="수정" style="background:#e0effd;" onclick="noticeUpdate(${notice.noticeNo})"> --%>
		<input type="button" class="btn btn-primary" value="수정" onclick="noticeUpdate(${notice.noticeNo})">
		<input type="hidden" value="${notice.noticeNo }" name="noticeNo">
<%-- 		<input type="button" class="btn" style="background:#ff8a8a;" value="삭제" onclick="noticeDelete(${notice.noticeNo})"> --%>
		<input type="button" class="btn btn-danger" value="삭제" onclick="noticeDelete(${notice.noticeNo})">
    </div>
		<br>
		<br>
	
		
</div>
	
</div>

</div>
