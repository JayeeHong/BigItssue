<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
	.login {
		width: 310px;
		margin: 0 auto;
	}
	
	/**/
	
</style>

<script type="text/javascript">

	// 아이디 저장
	$(document).ready(function() {
		
		// 저장된 쿠키값을 가져와서 ID칸에 넣어준다. 없으면 공백
		var key = getCookie("key");
		$("#sellerId").val(key);
		
// 		console.log(key);
		
		if($("#sellerId").val() != "") { // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
			$("#saveId").attr("checked", true); // ID 저장하기를 체크 상태로 두기
		}
		
		$("#saveId").change(function() { // 체크박스에 변화가 있다면,
			if($("#saveId").is(":checked")) { // ID저장하기 체크했을 대
				setCookie("key", $("#sellerId").val(), 7); // 7일 동안 쿠키 보관
			} else { // ID저장 체크 해제 시
				deleteCookie("key");
			}
		});
		
		// ID저장을 체크한 상태에서 ID를 입력하는 경우, 이경우에도 쿠키 저장
		$("#sellerId").keyup(function() { // id 입력칸에 id 입력할 때
			if($("#saveId").is(":checked")) { // id 저장하기를 체크한 상태라면
				setCookie("key", $("#sellerId").val(), 7); // 7일 동안 쿠키 보관
			}
		});
		
	});
	
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	

	// 아이디, 비밀번호 입력 확인
	function checkValue() {
		if(!document.sellerInfo.sellerId.value) {
			alert("아이디를 입력하세요!");
			return false;
		}
		
		if(!document.sellerInfo.sellerPw.value) {
			alert("비밀번호를 입력하세요!");
			return false;
		}
	}

</script>

<div class="login">

<c:if test="${not sellerLogin }">
<div>
<h3>판매자 로그인</h3>
</div>

<form action="/seller/login" method="POST" name="sellerInfo" onsubmit="return checkValue()">
<div style="text-align: center;">
<span style="margin: 10px;" class="glyphicon glyphicon-user" aria-hidden="true"></span>
<input style="height: 30px; width: 250px; margin: 10px" type="text" id="sellerId" name="sellerId" />
<br>
<span style="margin: 10px;" class="glyphicon glyphicon-lock" aria-hidden="true"></span>
<input style="height: 30px; width: 250px; margin: 10px" type="password" name="sellerPw" />
<br>

<div style="text-align: right; margin: 10px;">
<input style="margin: 10px;" type="checkbox" id="saveId" /><label for="saveId" id="saveId">아이디 저장</label>
<input style="margin: 10px;" type="checkbox" id="autoLogin" /><label for="autoLogin" id="autoLogin">자동 로그인</label>
</div>

<button style="width: 300px;" class="btn btn-primary">로그인</button>
</div>
</form>
</c:if>
</div>
<!-- 채팅창 -->
<c:if test="${sellerLogin }">

<c:if test="${chatRoomNo ne -1}">
<h3 style="text-align: center;">채팅 ${chatRoomNo }번방</h3>
</c:if>

<!-- 부트스트랩 -->
<div class="container">
<h3 class=" text-center">Messaging</h3>
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
          
          		 <!-- 옆 채팅 리스트 구조 -->
          		 
<!--             <div class="chat_list active_chat"> -->
<!--               <div class="chat_people"> -->
<!--                 <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div> -->
<!--                 <div class="chat_ib"> -->
<!--                   <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5> -->
<!--                   <p>practice</p> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </div> -->
<!--             <div class="chat_list"> -->
<!--               <div class="chat_people"> -->
<!--                 <div class="chat_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div> -->
<!--                 <div class="chat_ib"> -->
<!--                   <h5>Sunil Rajput <span class="chat_date">Dec 25</span></h5> -->
<!--                   <p>practice</p> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </div> -->
           
            <!-- 보조 채팅내역 -->
            <%-- 역기서 item은 하줄 한줄씩 보여주니까 dto겠지? --%>
			<c:forEach var="item" items="${chatRoomList}" begin="0" end="${chatRoomList.size()}" step="1">				
				<div id="b${item.chatRoomNo }" onclick="location.href='/seller/main?chatRoomNo=${item.chatRoomNo }'" class="chat_list">
					<a href="/seller/main?chatRoomNo=${item.chatRoomNo }">${item.chatRoomNo }번방 [${item.theOtherParty}]</a>
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
          
          		 <!-- 들어오는 메시지 구조 -->
          		 
<!--             <div class="incoming_msg"> -->
<!--               <div class="incoming_msg_img"> <img src="https://ptetutorials.com/images/user-profile.png" alt="sunil"> </div> -->
<!--               <div class="received_msg"> -->
<!--                 <div class="received_withd_msg"> -->
<!--                   <p>practice</p> -->
<!--                   <span class="time_date"> 11:01 AM    |    June 9</span></div> -->
<!--               </div> -->
<!--             </div> -->

				 <!-- 보내는 메시지 구조 -->
				 
<!--             <div class="outgoing_msg"> -->
<!--               <div class="sent_msg"> -->
<!--                 <p>practice</p> -->
<!--                 <span class="time_date"> 11:01 AM    |    June 9</span> </div> -->
<!--             </div> -->
        
            <c:forEach var="item" items="${primaryMsgList}" begin="0" end="${primaryMsgList.size()}" step="1">
				<c:if test="${LoginInfo.id eq item.chatSender}">
					<div class="outgoing_msg">
             			<div class="sent_msg">
                			<p>${item.chatContent }</p>
              		 		<span class="time_date">${item.stringChatDate }</span>
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
			                	<span class="time_date">${item.stringChatDate }</span>
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
      
      
      <p class="text-center top_spac"><a target="_blank" href="#">THE BIG ISSUE</a></p>
      
    </div></div>
    
</c:if>


<!-- 채팅 script -->
<script type="text/javascript">

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
		
	$('#btnRoomOut').on('click',function(evt){
		//소켓 연결 끊기
		closeSocket();
		//메인으로 보내기
		$(location).attr("href", "/roomOut");


	})
	if(${sellerLogin eq true}){
		connect();
	}

});

//스크롤
var msg_history_id = null;

function connect(){
	//ws://localhost:8088/replyEcho
	var ws = new WebSocket("ws://localhost:8088/replyEcho");
	socket = ws;

	ws.onopen = function(){
		console.log('Info: connection opened');
		
	};
 	
	//서버가 보낸 메시지 받는곳.
	ws.onmessage = function(receive){
		console.log("receive:"+receive);
		console.log("receive.data:",receive.data+'\n');
		
		//데이터 형식  "(방번호)#(보내는사람:내용)"에서 #을 기준으로 
		//(방번호)는 noFlag에 (보내는사람:내용)는 result에 저장.
		var noFlag = receive.data.split('#')[0];
		var senderId = receive.data.split('#')[1];
		var result = receive.data.split('#')[2];
		var presentDate = receive.data.split('#')[3];
		console.log("noFlag:"+noFlag);
		console.log("senderId:"+senderId);
		console.log("result:"+result);
		console.log("presentDate:"+presentDate);

		//현재방번호와 메시지에서 받은 #앞의 번호가 같을경우엔 메인창에 띄워주고
 		//현재방번호와 메시지에서 받은 #앞의 번호가 다를경우앤 채팅내역 리스트에서 방번호에서 같은번호가 있는지 찾는다.
 		//메시지를 받았을때는 새롭게 다시 채팅방 리스트를 검사하자.
 		
// 		var list = ${chatRoomList}
		//ajax쓰는 이유는 메시지를 받았을때, 새로운 방이 생겼을경우
		//chatRoomList를 다시 받아 와야 하기 때문에 사용. 
		$.ajax({
			 type: "post"
			 , url: "/chatRoomListAjax"
			 /*data: 전달 Parameter (댓글내용, boardnoQA)  */
			 , data: {}
			 , dataType: "json"
			 /* receive(이름은 내가 정하는것 )로 결과값 html을 받아옴 */
			 , success: function(receive){
				 
				var refreshList = receive.refreshChatRoomList;
				console.log(refreshList);
				console.log(refreshList[0]);
				console.log(refreshList[0].chatRoomNo);
				console.log(refreshList.length);
				
				
				console.log("[TEST]list확인:${chatRoomList}")
				
				//부트스트랩의 채팅창
				var msg_history = $(".msg_history");
				var inbox_chat = $(".inbox_chat");
				
				/* 현재방번호와 #앞의 번호가 같을경우 */
				if( ${chatRoomNo} == noFlag){
					//옆 사이드에도 내방이 보여야 하니까
					$("#b"+${chatRoomNo}+" p").html("<span class=\"time_date\">["+presentDate+"]</span>"+senderId+" : "+result);
					
					//부트스트랩에서 로그인된id와 메시지보낸id가 같을때
					if('${LoginInfo.id}' == senderId){
						var a = "<div class=\"outgoing_msg\"><div class=\"sent_msg\"> <p>"+result+"</p> <span class=\"time_date\"> "+presentDate+"</span> </div></div>"
						msg_history.append(a);
					}else{//부트스트랩에서 로그인된id와 메시지보낸id가 다를때
						var a = "<div class=\"incoming_msg\"><div>"+senderId+"</div><div class=\"incoming_msg_img\"> <img src=\"https://ptetutorials.com/images/user-profile.png\" alt=\"sunil\"> </div><div class=\"received_msg\"><div class=\"received_withd_msg\"><p>"+result+"</p><span class=\"time_date\"> "+presentDate+"</span></div></div></div>"
						msg_history.append(a);
					}
					
					
				}else{/* 현재방번호와 #앞의 번호가 다를경우 */
					/* 채팅내역 번호와 #앞의 번호가 같은곳을 업데이트해준다. */
					for(var i=0; i<refreshList.length; i++){
						if(refreshList[i].chatRoomNo==noFlag){
							$("#b"+refreshList[i].chatRoomNo+" p").html("<span class=\"time_date\"> ["+presentDate+"]</span>"+senderId+" : "+result);
						}
						console.log("[TEST]:"+$("#b"+refreshList[i].chatRoomNo).length)			
						if($("#b"+refreshList[i].chatRoomNo).length<=0){//있어야할 id가 없다면 생성해주자.
							var a = "<div class=\"chat_list\"><a href=\"/seller/main?chatRoomNo="+noFlag+"\">"+noFlag+"번방["+refreshList[i].theOtherParty+"]</a> <div id=\"b"+noFlag+"\" onclick=\"location.href='/seller/main?chatRoomNo="+noFlag+"'\"class=\"chat_people\"><div class=\"chat_img\"> <img src=\"https://ptetutorials.com/images/user-profile.png\" alt=\"sunil\"> </div><div class=\"chat_ib\"><p><span class=\"time_date\"> ["+presentDate+"]</span>"+senderId+" : "+result+"</p></div></div></div>";
							inbox_chat.append(a);
						}
					}

				}
				//스크롤 제일 아래로 내려주기
				if(msg_history_id != null){
					msg_history_id.scrollTop = msg_history_id.scrollHeight;
				}
			 }		 
			 , error: function(e){
				 alert("실패");
				 console.log(e);
			 }
		});
		
		
	};

	ws.onclose = function (event) { 
		console.log('Info: connection closed.'); 
		//setTimeout( function(){ connect();},1000); // retry connection!!
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