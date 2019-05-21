<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<title>BigItssue</title>

<jsp:include page="header.jsp" />

<body>
<%-- <h3 style="text-align:center;">채팅 ${chatRoomNo }번방</h3> --%>
<br>

<!-- 부트스트랩 -->
<div class="container">
<!-- <h3 class=" text-center">Messaging</h3> -->
<div class="messaging">
      <div class="inbox_msg">
        <div class="inbox_people">
          <div class="headind_srch">
            <div class="recent_heading">
              <h4>Recent</h4>
            </div>
            <div class="srch_bar">
              <div class="stylish-input-group">
                <input type="text" class="search-bar"  placeholder="Search" >
                <span class="input-group-addon">
                <button type="button"> <i class="fa fa-search" aria-hidden="true"></i> </button>
                </span> </div>
            </div>
          </div>
          <div class="inbox_chat">
     
            <!-- 보조 채팅내역 -->
            <%-- 역기서 item은 하줄 한줄씩 보여주니까 dto겠지? --%>
			<c:forEach var="item" items="${chatRoomList}" begin="0" end="${chatRoomList.size()}" step="1">				
				<div id="b${item.chatRoomNo }" onclick="reloadChk(${item.chatRoomNo })" class="chat_list">
					<a href="#">${item.chatRoomNo }번방 [${item.theOtherParty}]</a>
	            	<div class="chat_people">
	            		<div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div>
		                <div class="chat_ib">     
		                	<p>       	
		                	<c:forEach var="item2" items="${subMsgList}" begin="0" end="${subMsgList.size()}" step="1">
								<c:if test="${item.chatRoomNo eq item2.chatRoomNo}">
									<span class="time_date">[${item2.stringChatDate}]</span>
									${item2.chatSender} : ${item2.chatContent}
								</c:if>
							</c:forEach>
							</p>
							<!-- 안읽은 메시지 개수 표시 -->
							<div id="c${item.chatRoomNo }">
							<c:forEach var="item3" items="${messageChkResult}" begin="0" end="${messageChkResult.size()}" step="1">
			                	<c:if test="${item.chatRoomNo eq item3.chatRoomNo}">
				                	<div class="text-center messageChkResult" style="border-radius: 50%;height: 20px; width: 20px; background-color: red; color:white;">
				                	${item3.messageNoReadNum}
				                	</div>
			                	</c:if>
		               		</c:forEach>
		               		</div>
		                </div>
		            

	              	</div>
	           	</div>
			</c:forEach>
            
          </div>
        </div>
        
        <!-- 처음 채팅내역보기를 클릭시 -1로 가게되고 -->
        <!-- 채팅을 할 수 없게 막아 놓았다 -->
        <!-- 옆에 채팅내역을 클릭하면 해당 번호를 다시 받게돼서 채팅을 할 수 있다 -->
        <c:if test="${chatRoomNo ne '-1' }">
        <div class="mesgs">
          <div id="msg_history_id" class="msg_history">    
            <c:forEach var="item" items="${primaryMsgList}" begin="0" end="${primaryMsgList.size()}" step="1">
				<c:if test="${LoginInfo.id eq item.chatSender}">
					<div class="outgoing_msg">
             			<div class="sent_msg">
                			<p>${item.chatContent }</p>
              		 		<span style="display:inline-block;" class="time_date">${item.stringChatDate }</span>
              			</div>
            		</div>
				</c:if>
				<c:if test="${LoginInfo.id ne item.chatSender}">
					<div class="incoming_msg">
						<div>${item.chatSender }</div>
		              	<div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"></div>
		              	<div class="received_msg">
			                <div class="received_withd_msg">
			                	<p>${item.chatContent }</p>
			                	<span style="display:inline-block;" class="time_date">${item.stringChatDate }</span>
			                	<c:if test="${LoginInfo.sort ne '구매자'}">
			                		<span style="color:orange;cursor:pointer;"class="glyphicon glyphicon-exclamation-sign" onclick="chatReport(${item.chatMessageNo},${item.chatRoomNo },'${item.chatSender }','${item.chatDate }')">신고</span>
			                	</c:if>		                	
			                </div>
		              	</div>
	           		</div>
				</c:if>
			</c:forEach>
            
          </div>
          <div class="type_msg">
            <div class="input_msg_write">
              <input id="msg" type="text" class="write_msg" placeholder="메시지를 입력해 주세요" />
              <button id="btnSend" class="msg_send_btn" type="button"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
            </div>
          </div>
        </div>
        </c:if>
      </div>
      
      
      <p class="text-center top_spac"> Design by <a target="_blank" href="#">Sunil Rajput</a></p>
      
    </div></div>

</body>
<!-- window.opener.reload() -->
<script type="text/javascript">

//자식창 url바뀔땐 동작안하고, 자식창이 꺼질때만 동작.

var checkUnload = true;
$( window ).unload(function() {//새로고침,창끌때,url이동
	if(checkUnload==true){
		opener.document.getElementById("popupFlag").focus();
	}
});

//신고하기
function chatReport(chatMessageNo,chatRoomNo,chatSender,chatDate){
	console.log("chatMessageNo:"+chatMessageNo);
	console.log("chatRoomNo:"+chatRoomNo);
	console.log("chatSender:"+chatSender);
	console.log("chatDate:"+chatDate);
	if (confirm("정말 신고하시겠습니까?") == true){//확인
		$.ajax({
	        url : '/chatReport',
	        type : 'post',
	        data : {'chatMessageNo':chatMessageNo,'chatRoomNo':chatRoomNo,'chatSender':chatSender,'chatDateString':chatDate},
	        dataType: 'json',
	        success : function(receive) {
	        	if(receive.reportChk==false){
					alert("이미 신고된 날짜의 메시지입니다.");
				}else if(receive.reportChk==true){
					alert("신고가 완료됐습니다.");
				}
	        },
	        error: function(e) {
				console.log("실패");
				console.log(e);
			}        
	    });
	 }
}

//url이동시 checkUnload=false로해서 부모창 리로드 안시키게 한다.
function reloadChk(noFlag){
	checkUnload = false;
	$(location).attr("href", "/chatting?chatRoomNo="+noFlag);
}

var socket=null;

$(document).ready(function(){
			
	//enter누르면 메시지보내기
	$('input#msg').keydown(function(key) {

        if (key.keyCode == 13) {// 엔터
        	
        	console.log("socket.readyState:"+socket.readyState);
        	
        	//소켓이 준비되지 않으면 return
    		if(socket.readyState !== 1 ||socket.readyState == null) return;
    		
    		//보내기창 데이터가져오기
    		let msg = $('input#msg').val();
    		
    		/* send가 핸들러쪽으로 가게 만드는 것 같음 */
    		socket.send(msg);
    		//보내기창 초기화
    		$('input#msg').val('')

        }

	});
	
	//부트스트랩의 보내기 버튼
	$('#btnSend').on('click',function(evt){
		evt.preventDefault();
		
		console.log("socket.readyState:"+socket.readyState);
		
		//소켓이 준비되지 않으면 return
		if(socket.readyState !== 1 ||socket.readyState == null) return;
		
		//보내기창 데이터가져오기
		let msg = $('.input_msg_write .write_msg').val();
		
		/* send가 핸들러쪽으로 가게 만드는 것 같음 */
		socket.send(msg);
		
		//보내기창 초기화
		$('.input_msg_write .write_msg').val('')
	})

	$("#login-button").on('click', function() {
		//세션 자체를 로그아웃
		$("#form").submit();
	});
	
	$("#logout-button").on('click', function() {
		//세션 자체를 로그아웃
		$(location).attr("href", "/logout");
	});
		
	$('#btnRoomOut').on('click',function(evt){
		//소켓 연결 끊기
		closeSocket();
		//메인으로 보내기
		$(location).attr("href", "/roomOut");


	})
	connect();
});

//스크롤
var msg_history_id = null;

function connect(){
	var ws = new WebSocket("ws://localhost:8088/replyEcho");
// 	var ws = new WebSocket("ws://localhost:8088/replyEcho");
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
		//메시지 번호
		var noMsg = data.msg.chatMessageNo;
		//date시간
		var chatDate = data.msg.chatDate;
		
		console.log("noFlag:"+noFlag);
		console.log("senderId:"+senderId);
		console.log("result:"+result);
		console.log("presentDate:"+presentDate);
		console.log("noMsg:"+noMsg);
		console.log("chatDate:"+chatDate);
		
		//현재 로그인된 id에 맞는 채팅방들 리스트
		var refreshList = data.refreshChatRoomList;
		
		//안본 메시지 개수List
		var messageChkResult = data.messageChkResult;
			
		//부트스트랩의 채팅창
		var msg_history = $(".msg_history");
		var inbox_chat = $(".inbox_chat");
		
		//채팅방 위치 재배치
		//여기서 id="b(방번호)"는 채팅방list div하나 하나를 가리킴
		//여기서 id="c(방번호)"는 안본메시지 개수 div 하나 하나를 가리킴
		var replace = $("#b"+noFlag).wrap("<div><div/>").parent().html();
		$("#b"+noFlag).remove();
		inbox_chat.prepend(replace);
		

		/* 현재방번호와 메시지보낸 방번호가 같을경우 */
		if(${chatRoomNo} == noFlag){
			//옆 사이드에서의 내방에도 메시지 갱신
			$("#b"+${chatRoomNo}+" p").html("<span class=\"time_date\">["+presentDate+"]</span>"+senderId+" : "+result);
			
			//로그인된id와 메시지보낸id가 같을때, primary채팅창 오른쪽에 출력
			if('${LoginInfo.id}' == senderId){
				var a = "<div class=\"outgoing_msg\"><div class=\"sent_msg\"> <p>"+result+"</p> <span style=\"display:inline-block;\" class=\"time_date\"> "+presentDate+"</span> </div></div>"
				msg_history.append(a);
			}else{//로그인된id와 메시지보낸id가 다를때,  primary채팅창 왼쪽에 출력
				if(${LoginInfo.sort ne '구매자'}){
					var a = "<div class=\"incoming_msg\"><div>"+senderId+"</div><div class=\"incoming_msg_img\"> <img src=\"https://ptetutorials.com/images/user-profile.png\" alt=\"sunil\"> </div><div class=\"received_msg\"><div class=\"received_withd_msg\"><p>"+result+"</p><span style=\"display:inline-block;\" class=\"time_date\"> "+presentDate+"</span> <span style=\"color:orange;cursor:pointer;\"class=\"glyphicon glyphicon-exclamation-sign\" onclick=\"chatReport("+noMsg+","+noFlag+",\'"+senderId+"\',\'"+chatDate+"\')\">신고</span></div></div></div>"	
				}else{
					var a = "<div class=\"incoming_msg\"><div>"+senderId+"</div><div class=\"incoming_msg_img\"> <img src=\"https://ptetutorials.com/images/user-profile.png\" alt=\"sunil\"> </div><div class=\"received_msg\"><div class=\"received_withd_msg\"><p>"+result+"</p><span style=\"display:inline-block;\" class=\"time_date\"> "+presentDate+"</span></div></div></div>"	
				}
				
				msg_history.append(a);
			}
			
			
		}else{/* 현재방번호와 메시지보낸 방번호가  다를경우 */
			/* sub메시지창의 방번호와  메시지보낸 방번호가 같은곳을 업데이트해준다. */
			for(var i=0; i<refreshList.length; i++){
				if(refreshList[i].chatRoomNo==noFlag){
					$("#b"+refreshList[i].chatRoomNo+" p").html("<span class=\"time_date\"> ["+presentDate+"]</span>"+senderId+" : "+result);
					//안 읽은 채팅내역 개수 표시.
					for(var j=0; j<messageChkResult.length; j++){
						//sub메시지창의 방번호와 안본 메시지개수를 담는list의 방번호가 같을때
						if(messageChkResult[j] !=null && refreshList[i].chatRoomNo==messageChkResult[j].chatRoomNo){
							/* 안 읽은 채팅내역 표시가 아예 없을 경우 생성해주자. */
							if($("#b"+refreshList[i].chatRoomNo+" .messageChkResult").length<=0){
								var a = "<div class=\"text-center messageChkResult\" style=\"border-radius: 50%;height: 20px; width: 20px; background-color: red; color:white;\">"+messageChkResult[j].messageNoReadNum+"</div>"
								$("#c"+refreshList[i].chatRoomNo).append(a);
							}
							/* 안 읽은 채팅내역 표시가 있으면 그곳에 숫자를 넣어주자. */
							if($("#b"+refreshList[i].chatRoomNo+" .messageChkResult").length>0){
								$("#b"+refreshList[i].chatRoomNo+" .messageChkResult").html(messageChkResult[j].messageNoReadNum);
							}
						}
					}
				}	
				//있어야할 sub채팅방이 없을경우, 생성해주고 채팅갱신해주자.
				if($("#b"+refreshList[i].chatRoomNo).length<=0){
					var a = "<div id=\"b"+noFlag+"\" onclick=\"location.href='/chatting?chatRoomNo="+noFlag+"'\" class=\"chat_list\"><a href=\"#\">"+noFlag+"번방["+refreshList[i].theOtherParty+"]</a> <div class=\"chat_people\"><div class=\"chat_img\"> <img src=\"https://ptetutorials.com/images/user-profile.png\" alt=\"sunil\"> </div><div class=\"chat_ib\"><p><span class=\"time_date\"> ["+presentDate+"]</span>"+senderId+" : "+result+"</p><div id=\"c"+refreshList[i].chatRoomNo+"\"></div></div></div></div>"
					inbox_chat.prepend(a);
					//안 읽은 채팅내역 개수 표시.
					for(var j=0; j<messageChkResult.length; j++){
						if(messageChkResult[j] !=null && refreshList[i].chatRoomNo==messageChkResult[j].chatRoomNo){
							/* 안 읽은 채팅내역 표시가 아예 없을 경우 생성해주자. */
							if($("#b"+refreshList[i].chatRoomNo+" .messageChkResult").length<=0){
								var a = "<div class=\"text-center messageChkResult\" style=\"border-radius: 50%;height: 20px; width: 20px; background-color: red; color:white;\">"+messageChkResult[j].messageNoReadNum+"</div>"
								$("#c"+refreshList[i].chatRoomNo).append(a);
							}
							/* 안 읽은 채팅내역 표시가 있으면 그곳에 숫자를 넣어주자. */
							if($("#b"+refreshList[i].chatRoomNo+" .messageChkResult").length>0){
								$("#b"+refreshList[i].chatRoomNo+" .messageChkResult").html(messageChkResult[j].messageNoReadNum);
							}
						}
					}
				}
			}
		}
	 
		//스크롤 제일 아래로 내려주기
		if(msg_history_id != null){
			msg_history_id.scrollTop = msg_history_id.scrollHeight;
		}	
		
	};

	ws.onclose = function (event) { 
		console.log('Info: connection closed.');  
		
	};
	ws.onerror = function (event) { console.log('Error:',err); };
	
}

function closeSocket(){
	socket.close();	
}

//메시지창 불러오기
msg_history_id = document.getElementById("msg_history_id");

if(msg_history_id != null){
	//메시지창의 스크롤위치를 항상 제일 밑으로 설정
	msg_history_id.scrollTop = msg_history_id.scrollHeight;
}

</script>
chatRoomNo : ${chatRoomNo }<br>
</html>