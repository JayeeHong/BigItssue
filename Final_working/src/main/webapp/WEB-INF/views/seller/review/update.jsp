<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript" src="/resources/smarteditor2/js/service/HuskyEZCreator.js"
 charset="utf-8"></script>
 

<script type="text/javascript">
$(document).ready(function() {
	$("#btnUpdate").click(function() {
		//스마트에디터 내용을 <textarea>에 적용하기
		submitContents($("#btnUpdate"));
		
		$("form").submit();
	});
	
	$("#btnCancel").click(function() {
		history.go(-1);
	});
});
</script>



<style type="text/css">
#reviewUpdate { padding-top: 50px; }
#content {
	width: 99.8%;
	height: 450px;
}
</style>




<div id="reviewUpdate">
	<form action="/seller/review/update" method="post">
		<input type="hidden" name="reviewNo" value="${reviewView.reviewNo }" />
		<table class="table table-bordered">
		<tr>
			<td>아이디</td><td>${sellerId }</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3"><input type="text" name="reviewTitle" value="${reviewView.reviewTitle }" style="width:100%; "></td>
		</tr>
		<tr>
			<td colspan="4"><textarea id="content" name="reviewContent">${reviewView.reviewContent }</textarea></td>
		</tr>
		</table>
	</form>


	<div id="btnBox" class="text-center">	
		<button type="button" id="btnUpdate" class="btn btn-primary">수정</button>
		<button type="button" id="btnCancel" class="btn">취소</button>
	</div>
</div>





<script type="text/javascript">
// 스마트에디터 스킨 적용
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "content", //<textarea>의 id를 입력
    sSkinURI: "/resources/smarteditor2/SmartEditor2Skin.html",
    fCreator: "createSEditor2",
    htParams: {
    	bUseToolbar: true, //툴바 사용여부
    	bUseVerticalResizer: false, //입력창 크기 조절 바
    	bUseModeChanger: false //모드 탭
    }
});

// <form>의 submit동작에 맞춰 스마트에디터에 작성한 내용을
//<textarea>의 내용으로 전송함 -> <form>태그의 값으로 적용
function submitContents(elClickedObj) {
    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
    try {
        elClickedObj.form.submit();

    } catch(e) {}
}
</script>