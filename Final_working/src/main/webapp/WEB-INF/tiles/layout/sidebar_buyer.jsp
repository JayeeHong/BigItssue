<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<style type="text/css">
a.list-group-item.on {
	background: #cccccc6e;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	$("#btnLogin").click(function() {
		location.href = "/buyer/login";
	});
	
	$("#btnJoin").click(function() {
		location.href = "/buyer/join";
	});
	
	$("#btnLogout").click(function() {
		location.href = "/buyer/logout";
	});
	
	$("#btnMypage").click(function() {
		location.href = "/buyer/my/booking";
	});
	
	
	var str = $('.list-group a').attr("href");
	var path = window.location.pathname;
	
	console.log(str);
	console.log(path);
	console.log($('a.list-group-item.on').attr("name"));
	
	for(var i=0; i<$('.list-group a').length; i++) {
		if($('.list-group a')[i].name == path) {
			$('.list-group a').eq(i).attr('class', 'list-group-item on');
		}
	}
});
</script>


<div id="sidebar"
style="padding-top: 50px; padding-bottom: 300px; padding-left:15px; margin-right: 50px; width: 150px; float:left;">
	<div class="list-group" id="list-tab" role="tablist">
		<a href="/buyer/my/booking" name="/buyer/my/booking" class="list-group-item" style="background-color: #3179b7; color: #fff;">마이페이지</a>
		<a href="/buyer/my/booking" name="/buyer/my/booking" class="list-group-item">예약내역</a>
		<a href="/buyer/my/chat" name="/buyer/my/chat" class="list-group-item">문의내역</a>
		<a href="/buyer/my/info" name="/buyer/my/info" class="list-group-item">정보수정</a>
	</div>
</div>
