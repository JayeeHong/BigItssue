<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">

.table tr td select {
	height: 26px;
}

</style>

<script type="text/javascript">

function email_change() {
	if (document.upForm.emailSelect.options[document.upForm.emailSelect.selectedIndex].value == '0') {
// 		document.upForm.buyerEmail2.disabled = true;
		document.upForm.buyerEmail22.value = "";

	}

	if (document.upForm.emailSelect.options[document.upForm.emailSelect.selectedIndex].value == '9') {
// 		document.upForm.buyerEmail2.disabled = false;
		document.upForm.buyerEmail22.value = "";
		document.upForm.buyerEmail22.focus();

	} else {
// 		document.upForm.buyerEmail2.disabled = true;
		document.upForm.buyerEmail22.value = document.upForm.emailSelect.options[document.upForm.emailSelect.selectedIndex].value;

	}
}

$(document).ready(function() {
	
	// ------------- buyerPw 부분 ------------- 
	$("#confirmPw").keyup(function() {
		var pw1 = $("#buyerPw").val();
		var pw2 = $("#confirmPw").val();
		
		if(pw1==pw2) {
			$("#okPw").html("비밀번호가 같습니다.");
		} else {
			$("#okPw").html("비밀번호가 다릅니다.");
		}
	});
	// --------------------------------- buyerPw 부분 끝
	
	// ------------- buyerEmail 부분 -------------
	$(document).on("click", "#changeEmailbtn", function() {
		
		// 이메일 수정 폼 보여주기
		var emailForm = '';
		emailForm += '<input style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail1 }" id="buyerEmail11" name="buyerEmail11" />';
		emailForm += '&nbsp;@&nbsp;';
		emailForm += '<input style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail2 }" id="buyerEmail22" name="buyerEmail22" />';
		emailForm += '&nbsp;';
		emailForm += '<select name="emailSelect" onchange="email_change()">';
		emailForm += '	<option value="0" >선택하세요</option>';
		emailForm += '	<option value="9">직접입력</option>';
		emailForm += '	<option value="naver.com">naver.com</option>';
		emailForm += '	<option value="daum.net">daum.net</option>';
		emailForm += '	<option value="gmail.com">gmail.com</option>';
		emailForm += '	<option value="nate.com">nate.com</option>';
		emailForm += '</select>';
		emailForm += '&nbsp;';
		emailForm += '<button type="button" id="checkEmailbtn" class="btn btn-xs btn-default">인증번호 발송</button>';
		$("#changeEmail").html(emailForm);
	});
	
	// 이메일 인증번호 발송 클릭이벤트
	$(document).on("click", "#checkEmailbtn", function() {
	
// 		console.log("인증번호 발송 버튼");
		
	})
	
	// 이메일 수정 버튼 클릭이벤트
	$(document).on("click", "#changeEmailOk", function() {
		
		$.ajax({
			type: 'post'
			, url: '/buyer/my/info/changeEmail'
			, data: {'buyerEmail1':$('#buyerEmail11').val(), 'buyerEmail2':$('#buyerEmail22').val()}
			, dataType: 'json'
			, success: function(res) {
				console.log(res);
			}
			, error: function(e) {
				console.log(e);
			}
		});
		
	});
	
	// ------------------------------------------- buyerEmail 부분 끝
	
	// ------------- buyerPhone 부분 ------------- 
	$("select option[value=${buyerInfo.buyerPhone1 }]").attr("selected","selected");
	
	// 연락처 변경 버튼
// 	$("#changePhonebtn").click(function() {
	$(document).on("click", "#changePhonebtn", function() {
		
		// 연락처 수정 취소버튼 추가
		var phoneCancel = '';
		phoneCancel += '&nbsp;';
		phoneCancel += '<button type="button" class="btn btn-xs btn-default" id="phoneCancel">취소</button>';
		
		$("#cancelArea").html(phoneCancel);
		
		// 연락처 수정 폼 보여주기
		var phoneTag = '';
		phoneTag += '<label>수정할 연락처</label><br>';
		phoneTag += '<select id="changePhone1" name="changePhone1">';
		phoneTag += '<option value="010">010</option>';
		phoneTag += '<option value="011">011</option>';
		phoneTag += '<option value="016">016</option>';
		phoneTag += '<option value="017">017</option>';
		phoneTag += '<option value="02">02</option>';
		phoneTag += '<option value="031">031</option>';
		phoneTag += '</select>';
		phoneTag += '&nbsp;&nbsp;-&nbsp;&nbsp;';
		phoneTag += "<input style='width: 40px; text-align: center;' type='text' maxlength='4' value='' id='changePhone2' name='changePhone2' onKeyup='this.value=this.value.replace(/[^0-9]/g,\"\");' />";
		phoneTag += '&nbsp;&nbsp;-&nbsp;&nbsp;';
		phoneTag += "<input style='width: 40px; text-align: center;' type='text' maxlength='4' value='' id='changePhone3' name='changePhone3' onKeyup='this.value=this.value.replace(/[^0-9]/g,\"\");' />";
		phoneTag += '&nbsp;&nbsp;&nbsp;<button type="button" id="changePhoneOk" class="btn btn-xs btn-primary">확인</button>';
		
		$("#changePhone").html(phoneTag);
	});
	
	// 연락처 변경 옆에 취소 버튼 클릭이벤트
	$(document).on("click", "#phoneCancel", function() {
		$("#cancelArea").html(null); // 취소버튼 영역 안보이게
		$("#changePhone").html(null); // 수정할 연락처 부분 안보이게
	
	})
	
	// 연락처 수정 버튼 클릭이벤트
// 	$("#changePhoneOk").click(function() {
	$(document).on("click", "#changePhoneOk", function() {
// 		console.log('changePhoneOk');
		
		$.ajax({
			type: 'post'
			, url: '/buyer/my/info/changePhone'
			, data: {'buyerPhone1':$('#changePhone1').val(), 'buyerPhone2':$('#changePhone2').val(), 'buyerPhone3':$('#changePhone3').val()}
			, dataType: 'json'
			, success: function(res) {
// 				console.log(res);
// 				console.log(res.buyerInfo.buyerPhone2);
				// 사용자 연락처 부분 새 데이터로 덮어쓰기
				var phoneUpdate = '';
// 				phoneUpdate += '<select id="buyerPhone1" name="buyerPhone1" disabled>';
				phoneUpdate += '<input style="width: 40px; text-align: center; " type="text" value="' + res.buyerInfo.buyerPhone1 + '" disabled />';
// 				phoneUpdate += '</select>';
				phoneUpdate += '&nbsp;&nbsp;-&nbsp;&nbsp;';
				phoneUpdate += "<input style='width: 40px; text-align: center;' type='text' maxlength='4' value=" + res.buyerInfo.buyerPhone2 + " id='buyerPhone2' name='buyerPhone2' onKeyup='this.value=this.value.replace(/[^0-9]/g,\"\");' disabled />";
				phoneUpdate += '&nbsp;&nbsp;-&nbsp;&nbsp;';
				phoneUpdate += "<input style='width: 40px; text-align: center;' type='text' maxlength='4' value=" + res.buyerInfo.buyerPhone3 + " id='buyerPhone3' name='buyerPhone3' onKeyup='this.value=this.value.replace(/[^0-9]/g,\"\");' disabled />";
				phoneUpdate += '&nbsp;&nbsp;&nbsp;<button type="button" id="changePhonebtn" class="btn btn-xs btn-default">변경</button>';
				$("#phoneDefault").html(phoneUpdate);
				
				$("#changePhone").html(null); // 수정할 연락처 부분은 안보이게
			}
			, error: function(e) {
				console.log(e);
			}
		});
	});
	// ------------------- buyerPhone 부분 끝
	
});
	
</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_buyer.jsp" />

<h3>마이페이지-정보수정</h3>

<!-- 비밀번호 확인 전, 입력한 비밀번호가 다를 경우 -->
<c:if test="${not confirmpw }">
<div style="padding-top: 50px; padding-left: 500px;">

보안을 위해 회원님의 비밀번호를 한번 더 입력받고 있습니다<br>
비밀번호를 입력해주세요<br><br>
	<form action="/buyer/my/confirmpw" method="POST">
		비밀번호 : <input type="password" name="buyerPw" />
		<button class="btn btn-primary btn-sm">확인</button>
	</form>
	
</div>
</c:if>
<!-- ---------------- -->

<!-- 비밀번호 확인 후(입력한 비밀번호가 맞을 경우) -->
<div style="float:left; width: 750px;">
<c:if test="${confirmpw }">

<form action="/buyer/my/info/update" name="upForm" method="post" onsubmit="return updateConfirm();">

<table class="table" id="infoTable">

<tr>
	<td style="width: 30%">아이디</td>
	<td style="width: 70%">${buyerInfo.buyerId }</td>
</tr>

<tr>
	<td>비밀번호</td>
	<td><input type="password" id="buyerPw" name="buyerPw" /></td>
</tr>

<tr>
	<td>비밀번호 확인</td>
	<td>
		<div style="float: left;">
			<input type="password" id="confirmPw" name="confirmPw" />
		</div>
		<div id="okPw" style="float: left; padding-left: 5px;"></div> <!-- 비밀번호 비교결과가 보여질 부분 -->
	</td>
	
</tr>

<tr>
	<td>이름</td>
	<td>${buyerInfo.buyerName }</td>
</tr>

<tr>
	<td>이메일</td>
	<td>
		<input style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail1 }" name="buyerEmail1" disabled />
		&nbsp;@&nbsp;
		<input style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail2 }" name="buyerEmail2" disabled />
		&nbsp;
		<button type="button" id="changeEmailbtn" class="btn btn-xs btn-default">변경</button>
		<!-- 
		<input style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail1 }" name="buyerEmail1" />
		&nbsp;@&nbsp;
		<input style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail2 }" name="buyerEmail2" />
		<select name="emailSelect" onchange="email_change()">
			<option value="0" >선택하세요</option>
			<option value="9">직접입력</option>
			<option value="naver.com">naver.com</option>
			<option value="daum.net">daum.net</option> 
			<option value="gmail.com">gmail.com</option> 
			<option value="nate.com">nate.com</option> 
		</select>
		 -->
		<div id="changeEmail" style="padding-top: 20px;"></div> <!-- 이메일 변경 구역 -->
	</td>
</tr>

<tr>
	<td>연락처</td>
	<td>
		<div style="float: left;" id="phoneDefault">
		<input style="width: 40px; text-align: center;" type="text" value="${buyerInfo.buyerPhone1 }" name="buyerPhone1" disabled />
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" value="${buyerInfo.buyerPhone2 }" name="buyerPhone2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" disabled />
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" value="${buyerInfo.buyerPhone3 }" name="buyerPhone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" disabled />
		&nbsp;
		<button type="button" id="changePhonebtn" class="btn btn-xs btn-default">변경</button>
		</div>
		<div style="padding-top: 3px;" id="cancelArea"></div><!-- 연락처 변경 옆에 취소 버튼 올 부분 -->
		<div id="changePhone" style="padding-top: 20px;"></div> <!-- 연락처 변경 구역 -->
	</td>
</tr>

</table>

	<div class="">
		<div style="">
		<label>아이디</label>
			${buyerId }
		</div>
	</div>
	
	<div style="">
		<label>비밀번호</label>
			<input class="" type="password" name="buyerPw" id="buyerPw">
	</div> 
	<div id="pwTest"></div>
	
	<div class="">
		<label class="">비밀번호 확인</label>
		<div class="">
			<input class="" type="password" name="pwConfirm" id="pwConfirm">
		</div>
		<div id="okPw"></div>
	</div>
	
	<div class="">
		<label class="">이름</label>
		<div class="">
			<input class="" type="text" name="buyerName" id="buyerName">
		</div>
	</div>
	
	<div class="">
		<label class="">Email</label>
		<div class="">
			<input class="" type="" name="buyerEmail" id="buyerEmail">
		</div>
		<input class="btn"type="button" value="인증코드발송" id="okemail">
		<div id="isItEmail"></div>
	</div>
	
	<div class="">
		<label class="">인증코드</label>
		<div class="">
			<input class="" type="text" name="emailCode" id="emailCode"> <!-- 메일로 받은 인증코드를 입력하는 값  -->
		</div>
		<input class="btn" type="button" id="codeSame" value="확인">		<!-- 메일의 인증코드와 같은지 확인하는 버튼 -->
		<input type="hidden" value="" id="emailConfirm">		<!-- 메일로 보낸 인증코드를 저장하여 비교하는 hidden값 -->
	</div>
	
	<div class="">
		<label class="">휴대전화</label>
		<div class="">
			<input class="" type="text" name="buyerPhone" id="buyerPhone">
		</div>
	</div>
	
	<br><br>
	
	<div class=""></div>
	<div class="">
		<input class="btn btn-primary btn-lg btn-block" type="submit" name="join" id="join" value="가입" />
	</div>
	

	<div class="col-sm-2">
		<a href="/buyer/login"><button class="btn btn-lg btn-block" type="button">취소</button></a>
	</div>
	
	<br><br><br><br><br><br><br>
</form>
</c:if>

</div>

</div>