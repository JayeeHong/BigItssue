<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<style type="text/css">

#logo {
	float: left;
	margin-left: 10px;
}

/* img { padding-right: 35px; } */
/* img가 겹쳐서 하나뿐인 log이미지를 변경했습니다. */
#logoImg {
	padding-right: 25px;
}

#topMenu {
/* 	padding: 25px; */
/* 	font-size: medium; */
	font-weight: bold;
}

#topMenu {
	font-weight: bold;
}

#topMenu ul {
	list-style: none;
	margin: 0 auto;
	text-algin: center;
}

#topMenu ul li {
	position: relative;
	float: left;
	height: 100px;
	padding-left: 80px;
	padding-right: 10px;
		padding-top: 38px;
	font-size: 17px;
}

#topMenu ul li a {
	text-decoration: none;
	color: #000;
}

#btnBox {
/* 	text-align: right; */
/* 	padding-top: 40px; */
	float: right;
	margin-top: 30px;
}

/* 채팅css */
.container{
max-width:1170px; 
margin:auto;

}
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
  height:632px;
  width:600px;
}
.top_spac{ margin: 20px 0 0; width:600px;}


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


// 판매처리스트로 이동
function fnMove(){
// 	console.log($("#moveToSellerloc").offset());
	var offset = $("#moveToSellerloc").offset();
	console.log(offset);
	if(typeof offset=='undefined') {
		$(location).attr('href', '/buyer/main');
	
	} else {
		$('html, body').animate({scrollTop : offset.top}, 400);
		
	}

}

</script>







<div class="header">
<!-- 	<div class="container"> -->
		<div id="logo">
			<a href="/buyer/main">
				<img id="logoImg" src="http://bigissue.kr/wp-content/themes/canvas/images/Bigissue_kr_logo_main.png" alt="Bigissue Logo">
			</a>
		</div>
		
		<div id="topMenu">
			<ul>
				<li><a type="button" onclick="fnMove()">판매처 보기</a></li>
				<li><a href="/buyer/notice/list">공지사항</a></li>
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
<!-- 	</div> -->
	
</div>

<!-- 새로운 메시지출력(웹소켓) -->
<jsp:include page="../newMessageAlarmWebsocket.jsp" />

