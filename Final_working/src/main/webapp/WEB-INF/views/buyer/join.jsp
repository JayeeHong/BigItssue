<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
.join {
	width: 1100px;
	margin: 0 auto;
}

.joinForm {
	width: 1000px;
	margin: 0 auto;
}
</style>

<script type="text/javascript">

	var buyerIdSave = null; //아이디 저장 - 아이디 중복 검사 후 저장 - 가입시 같은지 비교하기 위함
	var buyerIdIsIt = false; //아이디 중복인지 아닌지
	var	buyerEmailSave = null; // 이메일 저장 - 이메일 인증 후 저장 - 가입시 바뀌었는지 비교하기 위함
	var	buyerEmailCodeSave = false; // 이메일 인증 후 코드가 같은지 다른지 확인
	var emailConfirm = null; //이메일 인증코드 저장하는 곳
	
$(document).ready(function() {

	$("#okemail").click(function() {
		var cnt = 0;
		
		$.ajax({
			type:"post"
			,url: "/buyer/useeamil"
			,data:{email : $("#buyerEmail").val() }
			,dataType:"json"
			,success: function(res) {
				console.log(res.emailCnt)
				cnt = res.emailCnt
				
				if(cnt > 0){
					alert("사용중인 이메일입니다")
					return false
				} else {
					mailSender()
				}	
			}
			,error :function(e){
				console.log(e)
			}
		})
	});

	
	$("#idUse").click(function() {
		$.ajax({
			type: "get"
			, url: "/buyer/useid"
			, data: { buyerId : $("#buyerId").val() }
			, dataType: "json"
			, success: function( res ) {
				console.log("성공");
				console.log("아이디가 있는가"+res.haveId)
				
				if(res.haveId) {
					$("#okId").html("사용중인 아이디입니다.")
					$("#okId").css("color","red")
// 					$("#buyerIdIsIt").val(false)
					buyerIdIsIt = false
					console.log(buyerIdIsIt)
					
				} else {
					$("#okId").html("사용가능한 아이디입니다.")
					$("#okId").css("color","green")
// 					$("#buyerIdSave").val($("#buyerId").val())	
					buyerIdSave = $("#buyerId").val()
				
// 					$("#buyerIdIsIt").val(true)
					buyerIdIsIt = true
					console.log(buyerIdIsIt)
				}	
			}
			, error: function( e ) {
				console.log("실패");
			}
		})
	})

	
	$("#buyerPw").keyup(function() {
		
		var pwpw = $("#buyerPw").val()
		
		var num = pwpw.search(/[0-9]/g);
		var eng = pwpw.search(/[a-z]/ig);
		var spe = pwpw.search(/[`~!@#$%^&*|\\\'\";:/?.,]/gi);

		if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/.test(pwpw)){            
			$("#pwTest").html("비밀번호는 영문자, 숫자, 특수문자로<br>이루어진 8~16자리입니다");
			$("#pwTest").css("color", "red")
	    }else{
	    	$("#pwTest").html("가능한 비밀번호입니다");
			$("#pwTest").css("color", "#ff6c00")
			if(pwpw.length>12){
				$("#pwTest").html("아주 좋은 비밀번호입니다");
				$("#pwTest").css("color", "green")
			}
	    }
		
	})

	
	$("#pwConfirm").keyup(function() {
		var a = $("#buyerPw").val()
		var b = $("#pwConfirm").val()
		
		if( a == b ) {
			$("#okPw").html("비밀번호가 같습니다.")
			$("#okPw").css("color","green")
		}else{
			$("#okPw").html("비밀번호가 다릅니다.")
			$("#okPw").css("color","red")
			
		}
	})

	
	$("#buyerEmail").keyup(function() {
	// 	$("#buyerEmailCodeSave").val(false)
		buyerEmailCodeSave = false
	})


	$("#codeSame").click(function() {
		var a = $("#emailCode").val()
		
		if( a == emailConfirm ) {
				alert("메일이 인증되었습니다")
				var c = true
	// 			$("#buyerEmailCodeSave").val(true)
				buyerEmailCodeSave = true
				console.log(buyerEmailCodeSave)
		} else {
				alert("코드를 다시 한번 확인해주세요")
	// 			$("#buyerEmailCodeSave").val(false)
				buyerEmailCodeSave = false
				console.log(buyerEmailCodeSave)
		}
	})
})

function emailConfirm(c) {
	$("#emailConfirm").val(c)
}	
	
	
function mailSender() {
	$.ajax({
		type: "post"
		, url: "/buyer/mailsender"
		, data: {email : $("#buyerEmail").val() }
		, dataType: "json"
		, success: function( res ) {
			console.log("성공");
//			console.log(res.emailCode)
			var	emailCode = res.emailCode
//			$("#emailConfirm").val(emailCode)
			emailConfirm = emailCode
			console.log(emailConfirm);
		
			$("#isItEmail").html("메일이 오지 않을 경우 재 요청을 해주세요.")
			$("#isItEmail").css("color", "gray")
//			$("#buyerEmailSave").val($("#buyerEmail").val())
			buyerEmailSave = ($("#buyerEmail").val())
			console.log(buyerEmailSave)
		}
		, error: function( e ) {
			console.log("실패");
			return
		}
	});
}

	//가입시 유효성 검사
	
	//빠진것
	//비밀번호 자릿수
	//핸드폰번호 숫자만
function joinConfirm() {
		
	var getCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
		
	if($("#buyerId").val()=='') {
		alert("아이디를 적어주세요")
		return false
		
	} else if(buyerIdSave == '') {
		alert("사용하실 아이디를 변경해주세요.")
		return false
		
	} else if($("#buyerPw").val()=='') {
		alert("비밀번호를 입력하세요")
		return false
		
	} else if( !/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/.test($("#buyerPw").val()) ) {
		alert("비밀번호는 특수문자를 포함한 8~16자리 사이입니다 ")
		return false
		
	} else if($("#buyerEmail").val()=='') {
		alert("이메일을 입력하세요")
		return false
		
	} else if($("#buyerName").val()=='') {
		alert("이름을 입력하세요")
		return false
		
	} else if($("#buyerPhone2").val()=='') {
		alert("핸드폰 번호를 입력해주세요")
		return false
		
	} else if($("#buyerPhone3").val()=='') {
		alert("핸드폰 번호를 입력해주세요")
		return false
		
	} else if(buyerIdIsIt == false) {
		alert("다른 아이디를 사용해주세요")
		return false
		
	} else if($("#buyerId").val() != buyerIdSave ) { //아이디 변경확인
		console.log( $("#buyerId").val() )
		console.log( buyerIdSave )
		alert("ID 중복확인필요")
		return false
		
	} else if($("#buyerPw").val() != $("#pwConfirm").val()) {//비밀번호 변경확인
		alert("비밀번호가 다릅니다")
		return false
		
	} else if($("#buyerEmail").val() != buyerEmailSave ) {//이메일 변경확인
		alert("이메일이 변경되었습니다. 재인증해주세요")
		return false
		
	} else if( buyerEmailCodeSave == false) {
		alert("이메일이 변경되었습니다. 재인증 바람")
		return false
	}
	
	alert("회원가입을 축하드립니다")
	return true
}
</script>

<hr>

<div class="join">

<div style="padding-left: 120px; padding-right: 120px; padding-top: 10px;">
<h4><strong>BigItssue 회원가입</strong></h4>
<hr>
</div>

<div class="joinForm">
<form action="/buyer/join" method="post" onsubmit="return joinConfirm()" class="form-horizontal">

	<div class="form-group">
		<label class="col-sm-3 col-sm-offset-1 control-label">아이디</label>
		<div style= "width: 269px; padding-right: 10px; float: left;">
			<input class="form-control" type="text" name="buyerId" id="buyerId">
		</div>
		<div style="width: 82px; float: left;">
			<input class="btn" type="button" name="idUse" id="idUse" value="중복확인">
		</div>
		<input type="hidden" value="" id="idConfirm">
		<div style="padding: 6px; float:left;" id="okId"></div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 col-sm-offset-1 control-label">비밀번호</label>
		<div style="width: 360px; padding-right: 10px; float: left;">
			<input class="form-control" type="password" name="buyerPw" id="buyerPw" maxlength="16" placeholder="영어, 숫자, 특수문자를 모두 포함한 8~16자리입니다">
		</div> 
		<div id="pwTest"></div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 col-sm-offset-1 control-label">비밀번호 확인</label>
		<div style="width: 360px; padding-right: 10px; float: left;">
			<input class="form-control" type="password" name="pwConfirm" id="pwConfirm">
		</div>
		<div style="padding: 6px;" id="okPw"></div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 col-sm-offset-1 control-label">이름</label>
		<div style="width: 360px; padding-right: 10px; float: left;">
			<input class="form-control" type="text" name="buyerName" id="buyerName">
		</div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 col-sm-offset-1 control-label">Email</label>
		<div style="width: 242px; padding-right: 10px; float: left;">
			<input class="form-control" type="email" name="buyerEmail" id="buyerEmail">
		</div>
		<div style="width: 110px; float: left;">
			<input class="btn"type="button" value="인증코드발송" id="okemail">
		</div>
		<div style="padding: 6px; float:left;" id="isItEmail"></div>
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 col-sm-offset-1 control-label">인증코드</label>
		<div style= "width: 294px; padding-right: 10px; float: left;">
			<input class="form-control" type="text" name="emailCode" id="emailCode"> <!-- 메일로 받은 인증코드를 입력하는 값  -->
		</div>
		<input class="btn" type="button" id="codeSame" value="확인">		<!-- 메일의 인증코드와 같은지 확인하는 버튼 -->
		<input type="hidden" value="" id="emailConfirm">		<!-- 메일로 보낸 인증코드를 저장하여 비교하는 hidden값 -->
	</div>
	
	<div class="form-group">
		<label class="col-sm-3 col-sm-offset-1 control-label">휴대전화</label>
		<div class="">
			<select class="form-control" style="display: inline; width: 80px;" name="buyerPhone1">
				<option value="010">010</option>
				<option value="011">011</option>
				<option value="016">016</option>
				<option value="017">017</option>
				<option value="02">02</option>
				<option value="031">031</option>
			</select>
			&nbsp;-&nbsp;
			<input class="form-control" style="display: inline; width: 80px; text-align: center;" type="text" maxlength="4" value="" id="buyerPhone2" name="buyerPhone2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
			&nbsp;-&nbsp;
			<input class="form-control" style="display: inline; width: 80px; text-align: center;" type="text" maxlength="4" value="" id="buyerPhone3" name="buyerPhone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		
<!-- 			<input class="form-control" type="text" name="buyerPhone" id="buyerPhone"> -->
		</div>
	</div>
	
	<br><br>
	
	<div style="margin-left: 326px; width: 350px;">
		<input class="btn btn-primary btn-block" type="submit" name="join" id="join" value="가입" />
	</div>
	

<!-- 	<div class="col-sm-2"> -->
<!-- 		<a href="/buyer/login"><button class="btn btn-lg btn-block" type="button">취소</button></a> -->
<!-- 	</div> -->
	
	<br><br><br><br><br><br><br>
</form>
</div>
</div>
