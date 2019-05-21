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
style="padding-top: 10px; padding-bottom: 300px; padding-left:15px; margin-right: 50px; width: 150px; float:left;">
	<div class="list-group" id="list-tab" role="tablist">
		<a href="/admin/main" name="/admin/main" class="list-group-item" style="background-color: #3179b7; color: #fff;">관리자페이지</a>
		<a href="/admin/info/seller" name="/admin/info/seller" class="list-group-item">계정관리</a>
		<a href="/admin/loc/list" name="/admin/loc/list" class="list-group-item">판매장소 관리</a>
		<a href="/admin/seller/list" name="/admin/seller/list" class="list-group-item">판매자<br>판매정보 관리</a>
		<a href="/admin/book/list" name="/admin/book/list" class="list-group-item">판매자<br>빅이슈 관리</a>
		<a href="/admin/chat/list" name="/admin/chat/list" class="list-group-item">채팅 내역 관리</a>
		<a href="/admin/notice/list" name="/admin/notice/list" class="list-group-item">공지사항 게시판<br>관리</a>
		<a href="/admin/review/list" name="/admin/review/list" class="list-group-item">후기게시판 관리</a>
		<a href="/admin/report/list" name="/admin/report/list" class="list-group-item">문의하기<br>신고내역</a>
		<a href="/admin/banner/list" name="/admin/banner/list" class="list-group-item">배너관리</a>
	</div>
</div>
