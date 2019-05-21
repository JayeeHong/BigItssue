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
}

/* 모달 */
/* 처음엔 none */
/* #alarmComment{display:none;} */

</style>
<script type="text/javascript">

var socketCommnet=null;

var timerIdCommnet =null;

var timerId =null;

$(document).ready(function(){
	/* 웹소켓 연결 */
	if(${adminLogin eq true}||${sellerLogin eq true}){
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
		
		//json문자열을  자바스크립트 객체로 변환
		var data = JSON.parse(receive.data);
		
		var reviewReply = data.reviewReply;
		
		//후기댓글번호
		var replyNo = reviewReply.replyNo;
		//내용
		var replyContent = reviewReply.replyContent;	
		//작성자 아이디
		var writer = reviewReply.writer;
		//후기번호
		var reviewNo = reviewReply.reviewNo;
		//Date를 yyyy-MM-dd HH mm형식으로바꿔준 String
		var stringDate = reviewReply.stringDate;
		//댓글방 주인
		var reviewViewSellerId = reviewReply.reviewViewSellerId;

			
		/* replyDiv태그가 존재할때만 동작 */
		/* 댓글창 있을때  댓글 등록 */
		if($("#replyDiv"+reviewNo).length>0){
			var a ="";
			a +="<div id=\""+replyNo+"\" class=\"replyList\" style=\"border-bottom:1px solid darkgray; margin-bottom: 15px;\">";
			a+="<div class=\"replyInfo\">";
 		    a+="<span class=\"glyphicon glyphicon-user\" aria-hidden=\"true\" style=\"font-size: 25px;\"></span>";
 		    a+="<span><strong>"+writer+"</strong></span>";
 		    a+="<span style=\"padding-left: 10px;\"><small>"+stringDate+"</small></span>";
 		  	a+="<span style=\"padding-left: 10px;\">";
 		  	if(writer == '${sellerId }'){
 		  	 	a+="<a style=\"cursor:pointer;\" onclick=\"replyUpdate('"+replyNo+"', '"+replyContent+"')\">[수정]</a>";
 		    	a+="<a style=\"cursor:pointer;\" onclick=\"replyDelete("+replyNo+", "+reviewNo+")\">[삭제]</a> ";
 		  	}
 		  	a+="</span>";
	    	a+="</div>";
		    a+="<div id=\"replyContent_"+replyNo+"\" class=\"replyContent\">";
		    a+="<p>"+replyContent+"</p>";
		    a+="</div>";
		    a+="</div>";	
		    
			$("#replyDiv"+reviewNo).append(a);
		}
				
		/* 댓글창이 없을때에만 댓글알림창 보여주기  */
		if(reviewViewSellerId = '${sellerId}' && $("#replyDiv"+reviewNo).length<=0){
			
			var aramComment = $("#alarmComment");
			var a = "<div onclick=\"location.href='/seller/review/view?reviewNo="+reviewNo+"'\" style=\"cursor: pointer;\"><span class=\"glyphicon glyphicon-envelope\" aria-hidden=\"true\"></span> "+writer+"님이  \""+replyContent+"\" 라는 댓글을 달았습니다 ( 후기게시판:"+reviewNo+"번글 )</div>";
		
			aramComment.html(a);
			
			/* 댓글알림창에 배경색 넣기 */
			if(writer=='관리자'){
				aramComment.addClass('bg-danger');
			}else{
				aramComment.addClass('bg-primary');
			}

			aramComment.css('display', 'none');
			aramComment.fadeIn("slow");

			//타이머 클리어
			clearInterval(timerId);
			//타이머 5초뒤에 메시지 사라지게 만듦
			timerId = setTimeout(					
				function(){
					aramComment.fadeOut("slow");
				}
			, 5000);
		}
		
		/* replyDivAdmin태그가 존재할때만 동작 */
		/* admin에서 댓글창 있을때  댓글 등록 */
		if($("#replyDivAdmin"+reviewNo).length>0){
			var a ="";
			a +="<div id=\""+replyNo+"\" class=\"replyList\" style=\"border-bottom:1px solid darkgray; margin-bottom: 15px;\">";
			a+="<div class=\"replyInfo\">";
 		    a+="<span class=\"glyphicon glyphicon-user\" aria-hidden=\"true\" style=\"font-size: 25px;\"></span>";
 		    a+="<span><strong>"+writer+"</strong></span>";
 		    a+="<span style=\"padding-left: 10px;\"><small>"+stringDate+"</small></span>";
 		  	a+="<span style=\"padding-left: 10px;\">";
 		  	if(writer == '관리자'){
 		  	 	a+="<a style=\"cursor:pointer;\" onclick=\"replyUpdate('"+replyNo+"', '"+replyContent+"')\">[수정]</a>";
 		    	a+="<a style=\"cursor:pointer;\" onclick=\"replyDelete("+replyNo+", "+reviewNo+")\">[삭제]</a> ";
 		  	}
 		  	a+="</span>";
	    	a+="</div>";
		    a+="<div id=\"replyContent_"+replyNo+"\" class=\"replyContent\">";
		    a+="<p>"+replyContent+"</p>";
		    a+="</div>";
		    a+="</div>";	
		    
	 		   
			$("#replyDivAdmin"+reviewNo).append(a);
		}
		
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
<div id="alarmComment" class="fixedComment"></div>

