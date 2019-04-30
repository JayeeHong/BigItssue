<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 


<script type="text/javascript">
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

	$("#btnReply").click(function() {
		$("form").submit();
	});
	
// 	$("#btnReplyUpdate").click(function() {
// 		$(location).attr("href", "/seller/review/reply/update?replyno=");
// 	});
	
// 	$("#btnReplyDelete").click(function() {
// 		alert("댓글 삭제?");
// 		$(location).attr("href", "/seller/review/reply/delete?replyNo=${r.replyNo }")
// 	});	
});

</script>


<style type="text/css">
#review { padding-top: 50px; }
#btnBox { text-align: center; }
</style>



<div id="review">
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
		<button id="btnUpdate" class="btn">수정</button>
		<button id="btnDelete" class="btn">삭제</button><br><br><br>
	</div>
	
	
	
	<div>
<!-- 		<form action="/seller/review/reply/delete" method="post"> -->
		<table class="table table-bordered">
			<tr><td colspan="5"><strong>댓글 리스트</strong></td></tr>
			<c:forEach items="${replyList }" var="r">
				<input type="hidden" name="replyNo" value="${r.replyNo }" />
				<input type="hidden" name="reviewNo" value="${r.reviewNo }" />
				<tr>
					<td style="width: 15%">${r.writer }</td>
					<td style="width: 65%">${r.replyContent }</td>
					<td style="width: 10%; text-align: center"><fmt:formatDate value="${r.replyDate }" pattern="yyyy-MM-dd"/></td>
					<td style="width: 10%; text-align: center;">
						<c:if test="${r.writer == sellerId }">
							<button id="ReplyUpdate" class="btn btn-xs" onclick="ReplyUpdate_click(' + this.reviewNo + ', \'' + this.writer + '\', \'' + this.replyContent + '\' )">수정</button>
							<button id="ReplyDelete" class="btn btn-xs" onclick="ReplyDelete_click('${r.replyNo }','${r.reviewNo }')">삭제</button>
						
							<script type="text/javascript">
								function ReplyDelete_click(replyNo,reviewNo) {
									alert(replyNo,reviewNo);
									alert("댓글 삭제??");
									
									location.href = "/seller/review/reply/delete?replyNo=" + replyNo+"&reviewNo="+reviewNo;
								}
							</script>
						
						
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</table>
<!-- 		</form> -->
	</div>
	
	<div>
		<form action="/seller/review/reply/write" method="post">
			<input type="hidden" name="reviewNo" value="${reviewView.reviewNo }" />
			<input type="hidden" name="writer" value="${sellerId }" />
			
			<table class="table table-bordered">
				<tr><td colspan="3"><strong>댓글달기</strong></td></tr>
				<tr>
					<td style="width: 15%">${sellerId }</td>
					<td style="width: 75%"><input type="text" name="replyContent" style="width: 100%"></td>
					<td style="width: 10%; text-align: center;"><button id="btnReply" class="btn btn-sm">입력</button></td>
				</tr>
			</table>
		</form>
	</div>
	
	
</div>

























