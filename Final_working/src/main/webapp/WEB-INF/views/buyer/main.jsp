<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<style type="text/css">
.fr{
	float:right;
}
th{
	text-align:center;
}
</style>


<script type="text/javascript">
$(document).ready(function() {

});

//예약페이지 열기
function booking(locNo){
		console.log("locNo:"+locNo);
	//현재창에서 페이지 이동
	$(location).attr("href", "/buyer/locview?locNo="+locNo);
}

//판매처 지도 열기
function mapView(locNo){
	var w = (screen.availWidth)/3;
	var h = (screen.availHeight)/2.5;
	//팝업창 새로 띄우기
	window.open("/sellerLocMap?locNo="+locNo, "판매처지도", "width="+w+'px'+", height="+h+'px'+", left=100, top=50");
	}

//채팅창 열기
function inquire(id,sort){
	console.log("id:"+id);
	console.log("sort:"+sort);
	
	//현재창에서 페이지 이동
// 	$(location).attr("href", "/createRoom?id="+id+"&sort="+sort);
	if(${buyerLogin eq true}){
		window.open("/createRoom?id="+id+"&sort="+sort, "문의하기", "width=800, height=750, left=100, top=50");
	}else{
		$(location).attr("href", "/buyer/login");
	}
}
</script>


<!-- 웹소켓 열기. 다른페이지에서도 새로운 메시지 확인하기위해서. -->
<script type="text/javascript">

var socket=null;

$(document).ready(function(){
	
	if(${buyerLogin eq true}){
		connect();
	}
});


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
				console.log(refreshList[0].theOtherParty);
				console.log(refreshList[0].buyerId);
				
				//안본 메시지 개수List
				var messageChkResult = receive.messageChkResult;
				
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
						var a = "<div style=\" width: 200px;height: 65px;padding-top: 0px;border: 1px solid black;padding-bottom: 0px;padding-left:5px;padding-right:5px;\" class=\"chat_list\"><a href=\"#\">"+noFlag+"번방["+refreshList[i].theOtherParty+"]</a> <div id=\"b"+noFlag+"\" onclick=\"window.open(\'/chatting?chatRoomNo="+noFlag+"\',\'문의하기\',\'width=800,height=750,left=100, top=50\')\" class=\"chat_people\"><div class=\"chat_img\"> <img src=\"https://ptetutorials.com/images/user-profile.png\" alt=\"sunil\"> </div><div class=\"chat_ib\"><p style=\"overflow:hidden;height:38px;\"><span style=\"float:left;margin: 0px;\" class=\"time_date\"> ["+presentDate+"]</span><span style=\"clear:both;\"></span><span style=\"float:left\">"+senderId+" : "+result+"</span></p><div id=\"c"+refreshList[i].chatRoomNo+"\">	 </div></div></div></div>"
						messageAram.html(a);
					}
				}
				//안 읽은 메시지 총 개수가 0보다 클때만 띄우주자
				if(messageNoNumAll>0){
					var a ="<div style=\"width: 200px;height: 23px;padding-top: 0px;border: 1px solid black;padding-bottom: 0px;\">안본 메시지 총개수: <span style=\"display: inline-block; border-radius: 50%;height: 20px; width: 20px; background-color: red; color:white;\">"+messageNoNumAll+"</span></div>"
					messageAram.prepend(a);
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

</script>

<jsp:include page="mainBanner.jsp" />



<!-- <div class="container"> -->

<!-- 웹소켓 열기. 다른페이지에서도 새로운 메시지 확인하기위해서. -->


<!-- 현재시간 받아오기 -->
<fmt:formatDate value="${now}" pattern="HHmm" var="sysTime" />


<!-- 장소,위치 검색 (select태그이용) -->
<form action="/buyer/main" method="POST">
	<div style="float: right;">
	<select name="zoneSelect">
		<option value="">지역을 선택하세요</option>
		<c:forEach var="item" items="${zoneList}" begin="0" end="${zoneList.size()}" step="1">
			<!-- 한번 검색한 것은 새로고침해도 유지되도록 -->
			<c:if test="${paging.zone eq item.zone }">
				<option value="${item.zone }" selected>${item.zone }</option>
			</c:if>
			<c:if test="${paging.zone ne item.zone }">
				<option value="${item.zone }">${item.zone }</option>
			</c:if>
		</c:forEach>
	</select>
		<select name="stationSelect">
		<option value="">판매위치</option>
		<c:forEach var="item" items="${stationList}" begin="0" end="${stationList.size()}" step="1">
			<!-- 한번 검색한 것은 새로고침해도 유지되도록 -->
			<c:if test="${paging.station eq item.station }">
				<option value="${item.station }" selected>${item.station }</option>
			</c:if>
			<c:if test="${paging.station ne item.station }">
				<option value="${item.station }">${item.station }</option>
			</c:if>
		</c:forEach>
	</select>
	<button style="margin-bottom:6px;" class="btn btn-primary btn-sm">검색</button>
	</div><br>
</form>
	
	
	
	
<div style="text-align: center; margin-bottom:50px;">

<div style="padding: 10px;">
	<table class="table table-bordered">
		<thead>
		<tr>
		<th style="width: 25%;">장소</th>
		<th style="width: 25%">세부위치(지도)</th>
		<th style="width: 25%">시간</th>
		<th style="width: 25%">판매자</th>
	 	</tr>
		</thead>
		<tbody>
		<c:forEach var="item" items="${sellerLocList}" begin="0" end="${sellerLocList.size()}" step="1">
			<tr>
			<td>${item.zone }</td>
			<td>${item.station } ${item.spot }<button class="btn btn-success btn-sm fr" onclick="mapView(${item.locNo })">지도보기</button></td>
			<td>
				<c:if test="${item.sellerTimeS.length() eq 4 && item.sellerTimeE.length() eq 4}">
				${item.sellerTimeS.substring( 0, 2 ) }:${item.sellerTimeS.substring( 2, 4 ) } ~ ${item.sellerTimeE.substring( 0, 2 )}:${item.sellerTimeE.substring( 2, 4 )} 
				</c:if>
				
				<c:if test="${item.sellerTimeS.length() eq 3 && item.sellerTimeE.length() eq 4}">
				${item.sellerTimeS.substring( 0, 1 ) }:${item.sellerTimeS.substring( 1, 3 ) } ~ ${item.sellerTimeE.substring( 0, 2 )}:${item.sellerTimeE.substring( 2, 4 )} 
				</c:if>
				
				<c:if test="${item.sellerTimeS.length() eq 4 && item.sellerTimeE.length() eq 3}">
				${item.sellerTimeS.substring( 0, 2 ) }:${item.sellerTimeS.substring( 2, 4 ) } ~ ${item.sellerTimeE.substring( 0, 1 )}:${item.sellerTimeE.substring( 1, 3 )} 
				</c:if>
				
				<c:if test="${item.sellerTimeS.length() eq 3 && item.sellerTimeE.length() eq 3}">
				${item.sellerTimeS.substring( 0, 1 ) }:${item.sellerTimeS.substring( 1, 3 ) } ~ ${item.sellerTimeE.substring( 0, 1 )}:${item.sellerTimeE.substring( 1, 3 )} 
				</c:if>	
				
				<!-- sellerId가 null이 아닐때 -->
				<c:if test="${item.sellerId ne null }">
					<!-- 예약시간이 지나지 않았을 때 -->
					<c:if test="${item.sellerTimeE ge intNow}">
						<button class="btn btn-info btn-sm fr" onclick="booking(${item.locNo})">예약하기</button>
					</c:if>
					<!-- 예약시간이 지났을 떄 -->
					<c:if test="${item.sellerTimeE lt intNow}">		
						<button class="btn btn-info btn-sm fr" disabled>예약하기</button>
					</c:if>
				</c:if>
				<!-- sellerId가 null이 일때 -->
				<c:if test="${item.sellerId eq null }">
					<button class="btn btn-info btn-sm fr" disabled>예약하기</button>
				</c:if>
			</td>
			<!-- sellerId가 null이 아닐때 -->
			<c:if test="${item.sellerId ne null }">
				<!-- 예약시간이 지나지 않았을 때 -->
				<c:if test="${item.sellerTimeE ge intNow}">
					<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" onclick="inquire('${item.sellerId}','판매자')">문의하기</button></td>
				</c:if>
				<!-- 예약시간이 지났을 떄 -->
				<c:if test="${item.sellerTimeE lt intNow}">
					<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" disabled>문의하기</button></td>
				</c:if>		
			</c:if>
			<!-- sellerId가 null이 일때 -->
			<c:if test="${item.sellerId eq null }">
				<td><button class="btn btn-warning btn-sm fr" disabled>문의하기</button></td>
			</c:if>

		</td>
		<!-- sellerId가 null이 아닐때 -->
		<c:if test="${item.sellerId ne null }">
			<!-- 예약시간이 지나지 않았을 때 -->
			<c:if test="${item.sellerTimeE ge intNow}">
				<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" onclick="inquire('${item.sellerId}','판매자')">문의하기</button></td>
			</c:if>
			<!-- 예약시간이 지났을 떄 -->
			<c:if test="${item.sellerTimeE lt intNow}">
				<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" disabled>문의하기</button></td>
			</c:if>		
		</c:if>
		<!-- sellerId가 null이 일때 -->
		<c:if test="${item.sellerId eq null }">
			<td><button class="btn btn-warning btn-sm fr" disabled>문의하기</button></td>
		</c:if>
	</c:forEach>
	</tbody>
</table>
<div id="messageAram"></div>

<jsp:include page="sellerLocPaging.jsp" />

</div>
</div>
