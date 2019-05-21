<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 



<style type="text/css">
#btnBox { 
	text-align: center;
	height: 74px;
}
</style>




<script type="text/javascript">

//후기 상세페이지에서 목록/수정/삭제 버튼
$(document).ready(function() {
	$("#btnList").click(function() {
		location.href = "/admin/review/list";
	});
	
	$("#btnDelete").click(function() {
		if( confirm("후기를 삭제하시겠습니까?") == true ) {
			$(location).attr("href", "/admin/review/delete?reviewno=${reviewView.reviewNo }");
		} else {
			return;
		}
	});
	
	/* enter키 누르면  */
	$('#text').keydown(function (key) { 
		/* 엔터키 키코드는 13번임 */
	    if ((key.keyCode == 13)) { 
	    	$('#buttonGo').click();
	    } 
	}); 

});
</script>




<script type="text/javascript">
//댓글 삭제
function replyDelete(replyNo, reviewNo) { 
// 		console.log(replyNo, reviewNo);
// 		alert("댓글 삭제??");
// 		$("div").remove("#"+replyNo);
// 		location.href = "/seller/review/reply/delete?replyNo=" + replyNo +"&reviewNo=" + reviewNo;

	if( confirm("정말 삭제하시겠습니까??") == true ) {    //확인
		$.ajax({
			url: '/admin/review/reply/delete',
			type: 'post',
			data: { "replyNo":replyNo, "reviewNo":reviewNo },
			dataType: 'json',
			success: function(data) {
				console.log(replyNo, reviewNo);
				
				$("div").remove("#"+replyNo);
		
			},
			error: function(e) {
					console.log("실패");
					console.log(e);
			}
		});
	
	} else {   //취소
	    return;
	}

}



//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function replyUpdate(replyNo, replyContent) {
	console.log(replyNo);
	console.log(replyContent);
	
    var a ='';
    
    a += '<div class="input-group">';
    a += '<input type="text" class="form-control" name="replyContent_'+replyNo+'" value="'+replyContent+'"/>';
    a += '<span class="input-group-btn"><button class="btn btn-primary" type="button" onclick="replyUpdateProc('+replyNo+');">수정</button> </span>';
    a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="replyUpdateCancel('+replyNo+',\''+replyContent+'\');">취소</button></span>';
    a += '</div>';

	$("#"+replyNo).find("p").html(a);

}
 
//댓글 수정
function replyUpdateProc(replyNo) {
    var updateContent = $('[name=replyContent_'+replyNo+']').val();
    
    $.ajax({
        url : '/admin/review/reply/update',
        type : 'post',
        data : { 'updateContent' : updateContent, 'replyNo' : replyNo },
        dataType: 'json',
        success : function(data) {
			
			$("#"+replyNo).find("p").html(updateContent);

        },
        error: function(e) {
			console.log("실패");
			console.log(e);
		}        
    });
}	

//댓글 수정 취소
function replyUpdateCancel(replyNo, replyContent) {
	$("#"+replyNo).find("p").html(replyContent);
}

//댓글 등록 ( 여기서 웹소켓핸들러로 보내줌 )
function submitComment(){
	
	var reviewNo =${reviewView.reviewNo };
	var writer= '관리자';
	var replyContent = $("#text").val();
	var reviewViewSellerId = '${reviewView.sellerId }';
	
	console.log("reviewNo:"+reviewNo);
	console.log("writer:"+writer);
	console.log("replyContent:"+replyContent);
	
	/* JSON.parse()는 String =>json  */
	/* JSON.stringify()는 json => String */
	var msg = JSON.stringify({"replyContent":replyContent,"writer":writer,"reviewNo":reviewNo,"reviewViewSellerId":reviewViewSellerId});
	
	socketCommnet.send(msg);
	
	$("#text").val("");
}

</script>




<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>후기게시판 관리</strong></h4>
<hr>




<div id="review">


	<!-- 후기 상세 -->
	<div id="reviewDetail">
<%-- 	<input type="hidden" name="reviewNo" value="${reviewView.reviewNo }" />	 --%>
	
		<table class="table table-bordered">
			<tr>
				<td style="width: 15%">아이디</td><td style="width: 50%">${reviewView.sellerId }</td>
				<td style="width: 15%">작성일</td><td style="width: 20%"><fmt:formatDate value="${reviewView.reviewDate }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
		
			<tr>
				<td style="width: 15%">제목</td><td style="width: 50%">${reviewView.reviewTitle }</td>
				<td style="width: 15%">조회수</td><td style="width: 20%">${reviewView.reviewHit }</td>
			</tr>
		
			<tr>
				<td style="height: 300px;">본문</td><td colspan="4">${reviewView.reviewContent }</td>
			</tr>
		</table>
		

		<div id="btnBox">
			<button id="btnList" class="btn">목록</button>
			<button id="btnDelete" class="btn">삭제</button><br><br><br>
		</div>
	</div>
	
	
	
	
	
	<!-- 댓글 입력 -->
	<div class="replyInsert">
		<!-- form으로 submit하면 websocket이 끊김 -->
		<!-- form으로 submit하지 않고 -->
		<!-- ReplyEchoCommentHandler에서 DB에 댓글저장, 추가된 댓글을 처리해줌.
		           댓글을 직접 받아오는 곳은 newCommentAlarmWebsocket.jsp임.
		     seller와 관련된 모든곳에 newCommentAlarmWebsocket.jsp를 include해놨음.-->	
		<table class="table table-bordered">
			<tr><td colspan="3"><strong>댓글달기</strong></td></tr>
			<tr>
				<td style="width: 15%">관리자</td>
				<td style="width: 75%"><input class="form-control" type="text" id="text" name="replyContent" style="width: 100%"></td>
				<td style="width: 10%; text-align: center;"><button id ="buttonGo" type="button" onclick="submitComment()" name="replyInsertBtn" class="btn btn-sm">입력</button></td>
			</tr>
		</table>
	</div>
	


	
	
	
	
	
	<!-- 댓글 리스트 -->
	<div id="replyDivAdmin${reviewView.reviewNo }">
	<c:forEach items="${replyList }" var="r">
		<div id="${r.replyNo }" class="replyList" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">
			
			<div class="replyInfo">
				<span class="glyphicon glyphicon-user" aria-hidden="true" style="font-size: 25px;"></span>
				<span><strong>${r.writer }</strong></span>
				<span style="padding-left: 10px;"><small><fmt:formatDate value="${r.replyDate }" pattern="yyyy-MM-dd HH:mm"/></small></span>
				<span style="padding-left: 10px;">
					<c:if test="${r.writer eq '관리자' }">
						<a style="cursor:pointer;" onclick="replyUpdate('${r.replyNo }', '${r.replyContent }')">[수정]</a>
					</c:if>
					<a style="cursor:pointer;" onclick="replyDelete(${r.replyNo }, ${r.reviewNo })">[삭제]</a> 
				</span>	
			</div>
			
			
			<div id="replyContent_${r.replyNo }" class="replyContent">
				<p>${r.replyContent }</p>
			</div>
			
		</div>
	</c:forEach>
	</div>
	

</div>
</div>
</div>
<!-- 새로운 댓글출력(웹소켓) -->
<jsp:include page="../../../tiles/newCommentAlarmWebsocket.jsp" />

<br><br><br><br><br>