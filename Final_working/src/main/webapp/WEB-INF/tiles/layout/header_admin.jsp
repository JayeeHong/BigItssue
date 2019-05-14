<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">

	#logo {
		float: left;
		margin-left: 10px;
	}
	
	#menu {
		font-weight: bold;
	}
	
	#adminLogin {
		float: right;
		margin-top: 33px;
		margin-right: 30px;
	}

</style>

<div class="header" style="height: 100px">

	<div id="logo">
	<a href="/admin/main">
		<img src="http://bigissue.kr/wp-content/themes/canvas/images/Bigissue_kr_logo_main.png">
	</a>
	</div>
	
	<nav id="menu">
		<div id="adminLogin">
			<c:if test="${not adminLogin }">
				로그인이 필요합니다
			</c:if>
			<c:if test="${adminLogin }">
				<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
				${adminId }님, 환영합니다&nbsp;
				<a href="/admin/logout"><button id="adminLogout" class="btn btn-sm btn-primary">로그아웃</button></a>
			</c:if>
		</div>
	</nav>
	
</div>