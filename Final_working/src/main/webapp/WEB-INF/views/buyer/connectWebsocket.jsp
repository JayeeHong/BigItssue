<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style type="text/css">

/* 새로운 메시지창 고정하기 위해 추가 */
.fixed{
 	position: fixed;
 	right: 10px; 
 	bottom: 113px; 
 	z-index:1;
	
	background: aliceblue;
}

/* 모달 */
/* 처음엔 none */
#messageAram{display:none;}

</style>
<script type="text/javascript">
var popup;

var socket=null;

var timerId =null;


$(document).ready(function(){
	
	if(${buyerLogin eq true}){
		connect();
	}
	
		
});

//부모창에서 reload할 시점을 정해주는 함수
//chatRoomNo의 세션값을 -1로 초기화 해주기 위해 ajax사용
function popupFunc(){
	if (popup==undefined) {
		console.log("팝업창 없음");
		$.ajax({
			 type: "post"
			 , url: "/sessionRoomNoInit"
			 /*data: 전달 Parameter (댓글내용, boardnoQA)  */
			 , data: {}
			 , dataType: "json"
			 /* receive(이름은 내가 정하는것 )로 결과값 html을 받아옴 */
			 , success: function(receive){
				//부모창 리로드
				window.location.reload();
			 }
		});
	}else{
		if(popup.closed){
			console.log("팝업창 없음");
			$.ajax({
				 type: "post"
				 , url: "/sessionRoomNoInit"
				 /*data: 전달 Parameter (댓글내용, boardnoQA)  */
				 , data: {}
				 , dataType: "json"
				 /* receive(이름은 내가 정하는것 )로 결과값 html을 받아옴 */
				 , success: function(receive){
					//부모창 리로드
					window.location.reload();
				 }
			});
		}else{
			console.log("팝업창 있음");
		}	
	}
}

function connect(){
	//ws://localhost:8088/replyEcho
	var ws = new WebSocket("ws://localhost:8088/replyEcho");
	socket = ws;

	ws.onopen = function(){
		console.log('Info: connection opened');
		
	};
 	
	//서버가 보낸 메시지 받는곳.
	ws.onmessage = function(receive){
		//json문자열을  자바스크립트 객체로 변환
		var data = JSON.parse(receive.data);
		
		//방번호
		var noFlag = data.msg.chatRoomNo;
		//송신자
		var senderId = data.msg.chatSender;
		//내용
		var result = data.msg.chatContent;
		//시간
		var presentDate = data.msg.stringChatDate;
		
		console.log("noFlag:"+noFlag);
		console.log("senderId:"+senderId);
		console.log("result:"+result);
		console.log("presentDate:"+presentDate);
		
		//현재 로그인된 id에 맞는 채팅방들 리스트
		var refreshList = data.refreshChatRoomList;
		
		//안본 메시지 개수List
		var messageChkResult = data.messageChkResult;
		
		//안 읽은 메시지 있으면 띄워주는 틀
		var messageAram = $("#messageAram");
		//안 읽은 메시지 개수 변수		
		var messageNoNumAll = 0;
		
		for(var i=0; i<refreshList.length; i++){
			//안 읽은 메시지 총 개수 보여주기
			if(messageChkResult[i] !=null){
				messageNoNumAll = messageNoNumAll+messageChkResult[i].messageNoReadNum		
			}
			//새로온 메시지 보여주기
			if(refreshList[i].theOtherParty== senderId){
				var a = "<div style=\" width: 200px;height: 65px;padding-top: 0px;border: 1px solid black;padding-bottom: 0px;padding-left:5px;padding-right:5px;\" class=\"chat_list\"><a href=\"#\">"+noFlag+"번방["+refreshList[i].theOtherParty+"]</a> <div id=\"b"+noFlag+"\" onclick=\"window.open(\'/chatting?chatRoomNo="+noFlag+"\',\'문의하기\',\'width=800,height=750,left=100, top=50\')\" class=\"chat_people\"><div class=\"chat_img\"> <img src=\"https://ptetutorials.com/images/user-profile.png\" alt=\"sunil\"> </div><div class=\"chat_ib\"><p style=\"overflow:hidden;height:38px;\"><span style=\"float:left;margin: 0px;\" class=\"time_date\"> ["+presentDate+"]</span><span style=\"clear:both;\"></span><span style=\"float:left; text-align:left;\">"+senderId+"&nbsp;:&nbsp;"+result+"</span></p><div id=\"c"+refreshList[i].chatRoomNo+"\"></div></div></div></div>"
				messageAram.html(a);
			}
		}
		//안 읽은 메시지 총 개수가 0보다 클때만 띄우주자
		if(messageNoNumAll>0){
			var a ="<div style=\"width: 200px;height: 23px;padding-top: 0px;border: 1px solid black;padding-bottom: 0px;\">안본 메시지 총개수: <span style=\"display: inline-block; border-radius: 50%;height: 20px; width: 20px; background-color: red; color:white;text-align:center;\">"+messageNoNumAll+"</span></div>"
			messageAram.prepend(a);
			messageAram.css('display', 'none');
			messageAram.fadeIn("slow");
			//타이머 클리어
			clearInterval(timerId);
			//타이머 5초뒤에 메시지 사라지게 만듦
			timerId = setTimeout(					
				function(){
					messageAram.fadeOut("slow");
				}
			, 5000);
			
		}

	 };		 
		
	ws.onclose = function (event) { 
		console.log('Info: connection closed.'); 
// 		setTimeout( function(){ connect();},1000); // retry connection!!
	};
	ws.onerror = function (event) { console.log('Error:',err); };
	
}

function closeSocket(){
	socket.close();
}

</script>

<!-- 새로운 메시지 창 -->
<div id="messageAram" class="fixed"></div>
<!-- 자식창이 리로드,닫혔을 때 동작 -->
<input style ="width:1px; height:1px; float:left;"id="popupFlag" type="text" onFocus="popupFunc()">


