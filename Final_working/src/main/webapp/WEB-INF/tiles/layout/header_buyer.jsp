<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<style type="text/css">
.menu {
	padding: 25px;
	font-size: medium;
	font-weight: bold;
}
img { padding-right: 35px; }

a { color: black; }
/* .top-menu { */
/* 	color: red; */
/* 	background-color: inherit; */
/* } */

#btnBox {
	text-align: right;
	padding-top: 40px;
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
});
</script>







<div class="header">

<nav class="navbar">
	<div class="container">
		<div class="navbar-header">
			<a href="#" class="standard-logo"><img src="http://bigissue.kr/wp-content/themes/canvas/images/Bigissue_kr_logo_main.png" alt="Bigissue Logo"></a>
		</div>
		
		<div id="topMenu" class="topMenu">
			<ul class="nav navbar-nav">
				<li class="menu"><a href="/buyer/main">판매처 보기</a></li>
				<li class="menu"><a href="/buyer/notice">공지사항</a></li>
			</ul>			
			
			<div id="btnBox">
			<!-- 로그인 상태 session이 판매자,구매자,관리자 나뉘어져 있어서 login=>buyerLogin으로 변경 -->
			<c:if test="${not buyerLogin }">
				<button id="btnLogin" class="btn">로그인</button>
				<button id="btnJoin" class="btn">회원가입</button>
			</c:if>

			<c:if test="${buyerLogin }">
				<!-- 로그인 상태 session이 판매자,구매자,관리자 나뉘어져 있어서 ${id}=>${buyerId }으로 변경 -->
				${buyerId }님
				<button id="btnLogout" class="btn" onclick="location.href='/buyer/logout'">로그아웃</button>
				<button id="btnMypage" class="btn">마이페이지</button>
			</c:if>
			</div>
		</div>
	</div>
</nav>
</div>