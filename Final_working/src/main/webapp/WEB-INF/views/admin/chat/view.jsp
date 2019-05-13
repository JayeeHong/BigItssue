<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<style>
	.btnBack {
		position: fixed;
		right: 0;
		margin-right: 32px;
	}
	
	.buyer {
		background: white;
	}
</style>


<script type="text/javascript">
	var isEnd = false;
	
	$(function() {
		$(window).scroll(function() {
			var window = $(this);
			var scrollTop = window.scrollTop();
			var windowHeight = window.height();
			var documentHeight = $(document).height();
			
			console.log("codumentHeight : "+documentHeight+", scrollTop : "+scrollTop+", windowHeight : "+windowHeight);
			
			if(scrollTop + windowHeight + 30 > documentHeight ) {
				fetchList();
			}
		})
		fetchList();
	})
	
	var fetchList = function() {
		if(isEnd == true) {
			return;
		}
		
		var startNo = $("#chatMessage").last().data("chatMessageNo") || 0;
		console.log(startNo);
		console.log("$('#chatMessage').last() : "+$("#chatMessage").data("chatMessageNo"));
	}
</script>

<div id="enter">
<form class="btnBack">
	<input type="button" class="btn btn-sm btn-primary" value="이전" onClick="history.go(-1);"/>
</form>

<c:forEach var="item" items="${message}" begin="0" end="${message.size()}" step="1">
	<c:if test="${fn:contains(item.chatSender, 'buyer') }">
		<pre id="chatMessage" class="buyer" data-chatMessageNo="${item.chatMessageNo }">${item.chatSender } : ${item.chatContent }		<fmt:formatDate value="${item.chatDate }" pattern="yyyy-MM-dd HH:mm"/></pre><br>
	</c:if>
	<c:if test="${fn:contains(item.chatSender, 'seller') || fn:contains(item.chatSender, 'bigdom') }">
		<pre id="chatMessage" data-chatMessageNo="${item.chatMessageNo }">${item.chatSender } : ${item.chatContent }		<fmt:formatDate value="${item.chatDate }" pattern="yyyy-MM-dd HH:mm"/></pre><br>
	</c:if>
</c:forEach>

</div>