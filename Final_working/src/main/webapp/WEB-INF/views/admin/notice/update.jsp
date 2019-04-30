<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
 <script type="text/javascript">
$(document).ready(function(){

	

$("#uploadReviewImg").change(function(){ //이미지를 선택하였을시
		
		readImg(this);
	})
	
$("#btnCancel").click(function(){
	window.location.href="/admin/notice/view?noticeNo="+${notice.noticeNo }
})


$("#imgDelete").click(function(){
	$("#miriview").hide();
	$("#noticeImg").val("");
})
	
	
function readImg(input){//미리보기를 한다
	$("#miriview").show();//숨긴div를 보이게함
	if(input.files && input.files[0]){
		var img = new FileReader();
		img.onload = function(e){
		$("#miriview").attr('src', e.target.result);
		console.log(e.target.result)
		}
	img.readAsDataURL(input.files[0]);
	}
}


})




</script>

<div class="row row-offcanvas row-offcanvas-right" >

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

    
    
<div style="float:left; width:70%;">
<form action="/admin/notice/update" method="post" enctype="multipart/form-data">
<table class="table table-bordered">
<tr>
	<td class="info">제목</td>
	<td><input type="text" name="noticeTitle" style="width:100%; " value="${notice.noticeTitle }"/></td>
</tr>
<tr><td class="info" colspan="5">본문</td></tr>
<tr><td colspan="5"><textarea style="width:100%;"rows="20" id="noticeContent" name="noticeContent">${notice.noticeContent }</textarea></td></tr>
</table>
<input type="hidden" name="noticeNo" value="${notice.noticeNo }">
<input type="hidden" name="noticeImg" id="noticeImg" value="${notice.noticeImg }">
<label>첨부파일 : <input type="file" name="file" id="uploadReviewImg"/></label>
<div>
<img style="width:30%; height: 30%;" id="miriview" src="/img/${notice.noticeImg }"/>
</div>
<input type="button" value="이미지삭제" id="imgDelete">

<div class="text-center">	
	<button type="submit" id="btnWrite" class="btn btn-primary">수정</button>
	<button type="button" id="btnCancel" class="btn btn-danger">취소</button>
</div>
</form>

</div>   
</div>
    