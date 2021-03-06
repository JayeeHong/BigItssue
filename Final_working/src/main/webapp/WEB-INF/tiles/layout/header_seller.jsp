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
	
	/* 채팅 css */
	.container{max-width:1170px; margin:auto;}
	img{ max-width:100%;}
	.inbox_people {
	  background: #f8f8f8 none repeat scroll 0 0;
	  float: left;
	  overflow: hidden;
	  width: 40%; border-right:1px solid #c4c4c4;
	}
	.inbox_msg {
	  border: 1px solid #c4c4c4;
	  clear: both;
	  overflow: hidden;
	  width:700px; 
 	  height:632px; 
 	  margin:auto; 
	}
	.top_spac{ margin: 20px 0 0;}
	
	
	.recent_heading {float: left; width:40%;}
	.srch_bar {
	  display: inline-block;
	  text-align: right;
	  width: 60%; padding:
	}
	.headind_srch{ padding:10px 29px 10px 20px; overflow:hidden; border-bottom:1px solid #c4c4c4;}
	
	.recent_heading h4 {
	  color: #05728f;
	  font-size: 21px;
	  margin: auto;
	}
	.srch_bar input{ border:1px solid #cdcdcd; border-width:0 0 1px 0; width:80%; padding:2px 0 4px 6px; background:none;}
	.srch_bar .input-group-addon button {
	  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
	  border: medium none;
	  padding: 0;
	  color: #707070;
	  font-size: 18px;
	}
	.srch_bar .input-group-addon { margin: 0 0 0 -27px;}
	
	.chat_ib h5{ font-size:15px; color:#464646; margin:0 0 8px 0;}
	.chat_ib h5 span{ font-size:13px; float:right;}
	.chat_ib p{ font-size:14px; color:#989898; margin:auto}
	.chat_img {
	  float: left;
	  width: 11%;
	}
	.chat_ib {
	  float: left;
	  padding: 0 0 0 15px;
	  width: 88%;
	}
	
	.chat_people{ overflow:hidden; clear:both;}
	.chat_list {
	  border-bottom: 1px solid #c4c4c4;
	  margin: 0;
	  padding: 18px 16px 10px;
	}
	.inbox_chat { height: 550px; overflow-y: scroll;}
	
	.active_chat{ background:#ebebeb;}
	
	.incoming_msg_img {
	  display: inline-block;
	  width: 6%;
	}
	.received_msg {
	  display: inline-block;
	  padding: 0 0 0 10px;
	  vertical-align: top;
	  width: 92%;
	 }
	 .received_withd_msg p {
	  background: #ebebeb none repeat scroll 0 0;
	  border-radius: 3px;
	  color: #646464;
	  font-size: 14px;
	  margin: 0;
	  padding: 5px 10px 5px 12px;
	  width: 100%;
	}
	.time_date {
	  color: #747474;
	  display: block;
	  font-size: 12px;
	  margin: 8px 0 0;
	}
	.received_withd_msg { width: 57%;}
	.mesgs {
	  float: left;
	  padding: 30px 15px 0 25px;
	  width: 60%;
	}
	
	 .sent_msg p {
	  background: #05728f none repeat scroll 0 0;
	  border-radius: 3px;
	  font-size: 14px;
	  margin: 0; color:#fff;
	  padding: 5px 10px 5px 12px;
	  width:100%;
	}
	.outgoing_msg{ overflow:hidden; margin:26px 0 26px;}
	.sent_msg {
	  float: right;
	  width: 46%;
	}
	.input_msg_write input {
	  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
	  border: medium none;
	  color: #4c4c4c;
	  font-size: 15px;
	  min-height: 48px;
	  width: 100%;
	}
	
	.type_msg {border-top: 1px solid #c4c4c4;position: relative;}
	.msg_send_btn {
	  background: #05728f none repeat scroll 0 0;
	  border: medium none;
	  border-radius: 50%;
	  color: #fff;
	  cursor: pointer;
	  font-size: 17px;
	  height: 33px;
	  position: absolute;
	  right: 0;
	  top: 11px;
	  width: 33px;
	}
	.messaging { padding: 0 0 50px 0;}
	.msg_history {
	  height: 516px;
	  overflow-y: auto;
	}
	
	.chat_list:hover {
		background-color: #ebebeb;
		cursor: pointer;
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
				<c:if test="${sellerInfo.sellerImg ne null }">
					<img style="width: 35px; height: 35px; " src="/upload/${sellerInfo.sellerImg }" />
				</c:if>
				<c:if test="${sellerInfo.sellerImg eq null }">
					<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
				</c:if>
				${sellerId }님, 환영합니다&nbsp;
				<a href="/seller/logout"><button id="sellerLogout" class="btn btn-sm btn-primary">로그아웃</button></a>
			</c:if>
		</div>
	</nav>
	
</div>
<!-- 새로운 메시지출력(웹소켓) -->
<jsp:include page="../newMessageAlarmWebsocket.jsp" />
<!-- 새로운 댓글출력(웹소켓) -->
<jsp:include page="../newCommentAlarmWebsocket.jsp" />

