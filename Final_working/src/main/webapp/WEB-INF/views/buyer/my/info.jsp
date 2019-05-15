<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">

.table tr td select {
	height: 26px;
}

</style>

<script type="text/javascript">

var passwordVerify; // 비밀번호 유효성 결과 담을 변수
var passwordConfirm; // 비밀번호 확인 결과 담을 변수
var emailConfirm; // emailcode 담을 변수

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
	
	$(document).on("click", "#changePw", function() {
	
		// 비밀번호 수정 폼 보여주기
		var pwForm = '';
		pwForm += '<div>';
		pwForm += '	<br><label>변경할 비밀번호 : </label>';
		pwForm += '	&nbsp;<input type="password" maxlength="16" id="buyerPw" /><br>';
		pwForm += '</div>';
		pwForm += '<div id="insertPw"></div>'; // 비밀번호 유효성 결과가 보여질 구역
		
		pwForm += '<div>';
		pwForm += '	<label>비밀번호 확인 : </label>&nbsp;';
		pwForm += '	&nbsp;&nbsp;&nbsp;<input type="password" id="confirmPw"/>';
		pwForm += '</div>';
		pwForm += '<div id="okPw"></div>'; // 비밀번호 비교결과가 보여질 구역
		
		pwForm += '<button type="button" id="changePwOk" class="btn btn-xs btn-primary">확인</button>';
		
		pwForm += '<div id="changePassSuccess"></div>'; // 비밀번호 변경 결과가 보여질 구역
		$("#changePwArea").html(pwForm);
		
	});
	
	// 비밀번호 유효성 검사
	$(document).on("keyup", "#buyerPw", function() {
		
		var pwpw = $("#buyerPw").val(); // 입력한 buyerPw값
		
		var num = pwpw.search(/[0-9]/g);
		var eng = pwpw.search(/[a-z]/ig);
		var spe = pwpw.search(/[`~!@#$%^&*|\\\'\";:/?.,]/gi);
		
		if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/.test(pwpw)){            
			$("#insertPw").html("비밀번호는 영문자, 숫자, 특수문자를 혼합한 8~16자리입니다");
			$("#insertPw").css("color", "red");
			passwordVerify = false; // 유효성 결과 false
			
	    } else{
	    	$("#insertPw").html("보통");
			$("#insertPw").css("color", "orange");
			passwordVerify = true; // 유효성 결과 true
			
			if(pwpw.length>12){
				$("#insertPw").html("좋음");
				$("#insertPw").css("color", "green");
				passwordVerify = true; // 유효성 결과 true
			}
	    }
		
	});
	
	// 비밀번호가 같은지 검사
// 	$("#confirmPw").keyup(function() {
	$(document).on("keyup", "#confirmPw", function() {
		var pw1 = $("#buyerPw").val();
		var pw2 = $("#confirmPw").val();
		
		if(pw1==pw2) {
			$("#okPw").html("비밀번호가 같습니다.");
			$("#okPw").css("color", "green");
			passwordConfirm = true; // 비밀번호 같은지 검사 결과
			
		} else {
			$("#okPw").html("비밀번호가 다릅니다.");
			$("#okPw").css("color", "red");
			passwordConfirm = false; // 비밀번호 같은지 검사 결과
			
		}
	});
	
	// 최종 비밀번호 변경 실행 (확인버튼)
	$(document).on("click", "#changePwOk", function() {
		
		// 유효성 검사 true, 비밀번호 같은 경우에만 비밀번호 변경 가능
		var changePass = '';
		if(passwordVerify && passwordConfirm) {
// 			console.log('모두 완료');
			
			$.ajax({
				type: 'post'
				, url: '/buyer/my/info/changePw'
				, data: {'buyerPw':$('#buyerPw').val()}
				, dataType: 'json'
				, success: function(res) {
					console.log('비밀번호 변경:'+res.buyerInfo);
					console.log('비밀번호 변경 세션:'+res.session);
					changePass += '<label>비밀번호가 성공적으로 변경되었습니다.<br>잠시 후 자동으로 로그아웃됩니다.</label>';
					$("#changePassSuccess").html(changePass);
					$("#changePassSuccess").css("color", "green");
					
					setTimeout('history.go(0);',3000);

				}
				, error: function(e) {
					console.log(e);
					changePass += '<label>비밀번호 변경에 실패하였습니다.</label>';
					$("#changePassSuccess").html(changePass);
					$("#changePassSuccess").css("color", "red");
				}
			
			});
			
		} else {
// 			console.log('완료 안됨');
			changePass += '<label>비밀번호를 다시 확인해주세요.</label>';
			$("#changePassSuccess").html(changePass);
			$("#changePassSuccess").css("color", "red");
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
		$("#verifyNumberForm").html(emailForm);
	});
	
	// 이메일 인증번호 발송 클릭이벤트
	$(document).on("click", "#checkEmailbtn", function() {
	
// 		console.log("인증번호 발송 버튼");
		// 이메일로 인증번호 발송
		var originEmail = $('#buyerEmail1').val()+'@'+$('#buyerEmail2').val();
		var email = $('#buyerEmail11').val()+'@'+$('#buyerEmail22').val();
// 		console.log(email);
		
		if(originEmail == email) { // 이전 이메일과 입력한 이메일이 같을때
			// 받은 인증번호 입력 폼
			var verifyNumberForm = '';
			verifyNumberForm += '<label>동일한 이메일입니다.</label>';
			
			$("#changeEmail").html(verifyNumberForm);
			
		} else { // 이전 이메일과 입력한 이메일이 다를 때
		
			$.ajax({
				type: 'post'
				, url: '/buyer/mailsender'
				, data: {'email': email}
				, dataType: 'json'
				, success: function(res) {
	// 				console.log(res);
	
					// 이메일로 보낸 인증번호 값 저장
					var emailCode = res.emailCode; 
					emailConfirm = emailCode;
	// 				console.log("이메일인증번호값"+emailConfirm);
				}
				, error: function(e) {
					console.log(e);
					return;
				}
			});
			
			// 받은 인증번호 입력 폼
			var verifyNumberForm = '';
			verifyNumberForm += '<label>인증번호 입력</label>';
			verifyNumberForm += '&nbsp;&nbsp;';
			verifyNumberForm += '<input type="text" id="verifyNumber" name="verifyNumber" />';
			verifyNumberForm += '&nbsp;&nbsp;';
			verifyNumberForm += '<button type="button" id="changeEmailOk" class="btn btn-xs btn-primary">확인</button>';
			verifyNumberForm += '<div id="verifyConfirm"></div>';
			
			$("#changeEmail").html(verifyNumberForm);
		
		}
		
	});
	
	// 이메일 수정 버튼 클릭이벤트
	$(document).on("click", "#changeEmailOk", function() {
		
		// 사용자가 입력한 인증번호 값
		var emailCode = $("#verifyNumber").val();
		
		var verifyConfirm = ''; // 이메일 변경 성공 여부 보여줄 내용 담는 변수
		
		if(emailCode == emailConfirm) {
// 			console.log('인증번호 일치');
// 			console.log(emailCode);
// 			console.log(emailConfirm);
			
			$.ajax({
				type: 'post'
				, url: '/buyer/my/info/changeEmail'
				, data: {'buyerEmail1':$('#buyerEmail11').val(), 'buyerEmail2':$('#buyerEmail22').val()}
				, dataType: 'json'
				, success: function(res) {
//	 				console.log(res);
					verifyConfirm += '<label>메일이 성공적으로 변경되었습니다!</label>';
					$("#verifyConfirm").html(verifyConfirm);
					$("#verifyConfirm").css("color", "green");
					
					setTimeout('history.go(0);',3000);
					
				}
				, error: function(e) {
					console.log(e);
					verifyConfirm += '<label>메일변경에 실패하였습니다.</label>';
					$("#verifyConfirm").html(verifyConfirm);
					$("#verifyConfirm").css("color", "red");
				}
			});
			
		} else {
// 			console.log('인증번호 불일치');
// 			console.log(emailCode);
// 			console.log(emailConfirm);
		
			verifyConfirm += '<label>인증번호를 다시 확인해주세요!</label>';
			$("#verifyConfirm").html(verifyConfirm);
			$("#verifyConfirm").css("color", "red");
			
		}
		
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
		
// 		$("#cancelArea").html(phoneCancel);
		
		// 연락처 수정 폼 보여주기
		var phoneTag = '<br>';
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
// 	$(document).on("click", "#phoneCancel", function() {
// 		$("#cancelArea").html(null); // 취소버튼 영역 안보이게
// 		$("#changePhone").html(null); // 수정할 연락처 부분 안보이게
	
// 	});
	
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

<h4><strong>회원정보수정</strong></h4>
<hr>

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
	<td>
		<button type="button" id="changePw" class="btn btn-xs btn-default">변경</button>
		<div id="changePwArea"></div>
	</td>
<!-- 	<td><input type="password" id="buyerPw" name="buyerPw" /></td> -->
</tr>

<!-- <tr> -->
<!-- 	<td>비밀번호 확인</td> -->
<!-- 	<td> -->
<!-- 		<div style="float: left;"> -->
<!-- 			<input type="password" id="confirmPw" name="confirmPw" /> -->
<!-- 		</div> -->
<!-- 		<div id="okPw" style="float: left; padding-left: 5px;"></div> 비밀번호 비교결과가 보여질 부분 -->
<!-- 	</td> -->
	
<!-- </tr> -->

<tr>
	<td>이름</td>
	<td>${buyerInfo.buyerName }</td>
</tr>

<tr>
	<td>이메일</td>
	<td>
		<input id="buyerEmail1" style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail1 }" name="buyerEmail1" disabled />
		&nbsp;@&nbsp;
		<input id="buyerEmail2" style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail2 }" name="buyerEmail2" disabled />
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
		<div id="verifyNumberForm" style="padding-top: 20px;"></div> <!-- 변경할 이메일 입력 구역 --> 
		<div id="changeEmail" style="padding-top: 20px;"></div> <!-- 인증번호 입력 구역 -->
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

</form>
</c:if>

</div>
</div>
