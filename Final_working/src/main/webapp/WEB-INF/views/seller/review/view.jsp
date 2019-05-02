<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 


<script type="text/javascript">

//후기 상세페이지에서 목록/수정/삭제 버튼
$(document).ready(function() {
	$("#btnList").click(function() {
		location.href = "/seller/review/list";
	});
	
	$("#btnUpdate").click(function() {
		$(location).attr("href", "/seller/review/update?reviewno=${reviewView.reviewNo }");
	});
	
	$("#btnDelete").click(function() {
		alert("삭제?");
		$(location).attr("href", "/seller/review/delete?reviewno=${reviewView.reviewNo }");
	});

});


//댓글 목록
$(document).ready(function() {
	replyList(); //페이지 로딩시 댓글 목록 출력 
});


var reviewNo = ${reviewView.reviewNo };


//댓글 목록
function replyList() {
	$.ajax({
		url: "/seller/review/reply/list",
		type: "get",
		data: { "reviewNo" : reviewNo }, //게시글 번호
		dataType: "json",
		success: function(data) {
			
			$.each(data.replyList, function(i, e) {
// 				console.log("--------------")
// 				console.log("i : " + i);
// 				console.log("e : " + e);
				
// 				$("#replyNo").html(e.replyNo);
// 				$("#replyContent").html(e.replyContent);

				var a = '';

				a += '<div class="replyArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="replyInfo'+e.replyNo+'">'+'댓글번호 : '+e.replyNo+' / 작성자 : '+e.writer;
                a += '<c:if test="${'+e.writer+' == sellerId }">';
                a += '<a onclick="replyUpdate('+e.replyNo+',\''+e.replyContent+'\');"> [수정] </a>';
                a += '<a onclick="replyDelete('+e.replyNo+',\''+e.reviewNo+'\')"> [삭제] </a> </div>';
                a += '</c:if>'
                a += '<div class="replyContent'+e.replyNo+'"> <p> 내용 : '+e.replyContent +'</p>';
                a += '</div></div>';

//                 console.log(a)
                
                $("div.replyList").append($(a));
			});
			
// 			$(".replyList").html(a);
		},
		error: function(e) {
			console.log("실패");
			console.log(e);
		}
	});
}


//댓글 등록
$(document).ready(function() {
	$('[name=replyInsertBtn]').click(function() { //댓글 등록 버튼 클릭시 
	    var insertData = $('[name=replyInsertForm]').serialize(); //replyInsertForm의 내용을 가져옴
// 		console.log(insertData);
	    replyInsert(insertData); //Insert 함수호출(아래)
	});
});

function replyInsert(insertData) {
	$.ajax({
		url : '/seller/review/reply/insert',
		type : 'post',
// 		data : {'ReviewReply':insertData}, //키벨류쌍으로 보내면 안됨
		data : insertData,
		dataType : 'json', 
		success : function(data) {
			var a = '';
			
			$.each(data.replyList, function(i, e) {
				a += '<div class="replyArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="replyInfo'+e.replyNo+'">'+'댓글번호 : '+e.replyNo+' / 작성자 : '+e.writer;
                a += '<a onclick="replyUpdate('+e.replyNo+',\''+e.replyContent+'\');"> [수정] </a>';
                a += '<a onclick="replyDelete('+e.replyNo+',\''+e.reviewNo+'\')"> [삭제] </a> </div>';
                a += '<div class="replyContent'+e.replyNo+'"> <p> 내용 : '+e.replyContent +'</p>';
                a += '</div></div>';
			});
			
			$("div.replyList").html(a);
		},
		error: function(e) {
			console.log("실패");
			console.log(e);
		}
  });
}



//댓글 삭제
function replyDelete(replyNo, reviewNo) { 
//		alert(replyNo,reviewNo); 
//		alert("댓글 삭제??");
//		location.href = "/seller/review/reply/delete?replyNo=" + replyNo +"&reviewNo=" + reviewNo;
	$.ajax({
		url: '/seller/review/reply/delete',
		type: 'post',
		data: {"replyNo":replyNo, "reviewNo":reviewNo},
		dataType: 'json',
		success: function(data) {
			var a = '';
			
			$.each(data.replyList, function(i, e) {
				a += '<div class="replyArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="replyInfo'+e.replyNo+'">'+'댓글번호 : '+e.replyNo+' / 작성자 : '+e.writer;
                a += '<a onclick="replyUpdate('+e.replyNo+',\''+e.replyContent+'\');"> [수정] </a>';
                a += '<a onclick="replyDelete('+e.replyNo+',\''+e.reviewNo+'\')"> [삭제] </a> </div>';
                a += '<div class="replyContent'+e.replyNo+'"> <p> 내용 : '+e.replyContent +'</p>';
                a += '</div></div>';
                
//                 $("div.replyList").append($(a));
			});
			
			$("div.replyList").html(a); //덮어씌우기....
		},
		error: function(e) {
			console.log("실패");
			console.log(e);
		}
	});
}


//댓글 수정 - 댓글 내용 출력을 input 폼으로 변경 
function replyUpdate(replyNo, replyContent) {
    var a ='';
    
    a += '<div class="input-group">';
    a += '<input type="text" class="form-control" name="replyContent_'+replyNo+'" value="'+replyContent+'"/>';
    a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="replyUpdateProc('+replyNo+');">수정</button> </span>';
    a += '</div>';
    
    $('.replyContent'+replyNo).html(a);
    
}
 
//댓글 수정
function replyUpdateProc(replyNo) {
    var updateContent = $('[name=replyContent_'+replyNo+']').val();
    
    $.ajax({
        url : '/seller/review/reply/update',
        type : 'post',
        data : {'updateContent' : updateContent, 'replyNo' : replyNo, 'reviewNo' : reviewNo},
        dataType: 'json',
        success : function(data) {
			var a = '';
			
			$.each(data.replyList, function(i, e) {
				a += '<div class="replyArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                a += '<div class="replyInfo'+e.replyNo+'">'+'댓글번호 : '+e.replyNo+' / 작성자 : '+e.writer;
                a += '<a onclick="replyUpdate('+e.replyNo+',\''+e.replyContent+'\');"> [수정] </a>';
                a += '<a onclick="replyDelete('+e.replyNo+',\''+e.reviewNo+'\')"> [삭제] </a> </div>';
                a += '<div class="replyContent'+e.replyNo+'"> <p> 내용 : '+e.replyContent +'</p>';
                a += '</div></div>';
			});
			
			$("div.replyList").html(a);
        },
        error: function(e) {
			console.log("실패");
			console.log(e);
		}        
    });
}

</script>


<style type="text/css">
#review { padding-top: 50px; }
#btnBox { 
	text-align: center;
	height: 74px;
}
</style>



<div id="review">
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
			<c:if test="${reviewView.sellerId == sellerId }">
				<button id="btnUpdate" class="btn">수정</button>
				<button id="btnDelete" class="btn">삭제</button><br><br><br>
			</c:if>
	</div>
	
	
	<div class="replyInsert">
<!-- 		<form action="/seller/review/reply/insert" method="post"> -->
		<form name="replyInsertForm">
			<input type="hidden" name="reviewNo" value="${reviewView.reviewNo }" />
			<input type="hidden" name="writer" value="${sellerId }" />
			
			<table class="table table-bordered">
				<tr><td colspan="3"><strong>댓글달기</strong></td></tr>
				<tr>
					<td style="width: 15%">${sellerId }</td>
					<td style="width: 75%"><input class="form-control" type="text" name="replyContent" style="width: 100%"></td>
					<td style="width: 10%; text-align: center;"><button type="button" name="replyInsertBtn" class="btn btn-sm">입력</button></td>
				</tr>
			</table>
		</form>
	</div>
	
	
	<div class="replyList">
<!-- 		<p id="replyNo"></p> -->
<!-- 		<p id="replyContent"></p>		 -->
	</div>
	
	
	
</div>




<!-- 		<table class="table table-bordered"> -->
<!-- 			<tr><td colspan="5"><strong>댓글 리스트</strong></td></tr> -->
<%-- 			<c:forEach items="${replyList }" var="r"> --%>
<%-- 				<input type="hidden" name="replyNo" value="${r.replyNo }" /> --%>
<%-- 				<input type="hidden" name="reviewNo" value="${r.reviewNo }" /> --%>
<!-- 				<tr> -->
<%-- 					<td style="width: 15%">${r.writer }</td> --%>
<%-- 					<td style="width: 65%">${r.replyContent }</td> --%>
<%-- 					<td style="width: 10%; text-align: center"><fmt:formatDate value="${r.replyDate }" pattern="yyyy-MM-dd"/></td> --%>
<!-- 					<td style="width: 10%; text-align: center;"> -->
<%-- 						<c:if test="${r.writer == sellerId }"> --%>
<!-- 							<button id="ReplyUpdate" class="btn btn-xs" onclick="ReplyUpdate_click(' + this.reviewNo + ', \'' + this.writer + '\', \'' + this.replyContent + '\' )">수정</button> -->
<%-- 							<a id="ReplyDelete" class="btn btn-xs" onclick="ReplyDelete('${r.replyNo }','${r.reviewNo }')">[삭제]</a> --%>
<%-- 						</c:if> --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<%-- 			</c:forEach> --%>
<!-- 		</table> -->
