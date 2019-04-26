<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<style type="text/css">
	
	#logo {
		float: left;
		margin-left: 10px;
	}
	
	.li {
		display: list-item;
	}
	
	#menu {
		font-weight: bold;
	}
	
	#menu ul {
		list-style: none;
		margin: 0 auto;
		text-algin: center;
	}
	
	#menu ul li {
		position: relative;
		float: left;
		height: 100px;
		padding-left: 50px;
		padding-right: 10px;
 		padding-top: 38px;
		font-size: 17px;
	}
	
	#menu ul li a {
		text-decoration: none;
		color: #000;
	}
	
	#sellerLogin {
		float: right;
		margin-top: 33px;
		margin-right: 30px;
	}
	
</style>

<div class="header" style="height: 100px">

	<div id="logo">
	<a href="/seller/main">
		<img src="http://bigissue.kr/wp-content/themes/canvas/images/Bigissue_kr_logo_main.png">
	</a>
	</div>
	
	<nav id="menu">
		<div>
			<ul>
				<li>
					<a href="/seller/time">판매 관리</a>
				</li>
				<li>
					<a href="/seller/review/list">빅돔 후기</a>
				</li>
				<li>
					<a href="/seller/bookinglist">예약 내역</a>
				</li>
			</ul>
		</div>
		
		<div id="sellerLogin">
			<c:if test="${not sellerLogin }">
				로그인이 필요합니다
			</c:if>
			<c:if test="${sellerLogin }">
				<c:if test="${sellerInfo.sellerImg eq null }">
				<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
				</c:if>
				${sellerId }님, 환영합니다&nbsp;
				<a href="/seller/logout"><button id="sellerLogout" class="btn btn-sm btn-primary">로그아웃</button></a>
			</c:if>
		</div>
	</nav>
	
</div>