<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">

/* 새로운 메시지창 고정하기 위해 추가 */
.fixedComment{
 	position: fixed;
 	right: 10px; 
 	top: 20px; 
 	z-index:1;
	
	background: aliceblue;
}

/* 모달 */
/* 처음엔 none */
#alarmComment{display:none;}

</style>
<script type="text/javascript">

var socketCommnet=null;

var timerIdCommnet =null;


$(document).ready(function(){
	/* 웹소켓 연결 */
	if(${buyerLogin eq true}||${sellerLogin eq true}){
		connectCommnet();
	}
		
});

function connectCommnet(){
	//ws://localhost:8088/replyEcho
	var wsCommnet = new WebSocket("ws://localhost:8088/replyEchoComment");
	socketCommnet = wsCommnet;

	wsCommnet.onopen = function(){
		console.log('Info: connection opened(댓글용)');
		
	};
 	
	//서버가 보낸 메시지 받는곳.
	wsCommnet.onmessage = function(receive){
		console.log("receive:"+receive);
		console.log("receive.data:"+receive.data);
	 };		 
		
	wsCommnet.onclose = function (event) { 
		console.log('Info: connection closed.(댓글용)'); 

	};
	wsCommnet.onerror = function (event) { console.log('Error(댓글용):',err); };
	
}

function closeSocketCommnet(){
	socketCommnet.close();
}

</script>

<!-- 새로운 메시지 창 -->
<div id="#alarmComment" class="fixedComment"></div>

