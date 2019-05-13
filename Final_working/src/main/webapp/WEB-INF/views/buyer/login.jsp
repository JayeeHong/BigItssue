<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<script type="text/javascript">

</script> 

<style>

.login {
	width: 1100px;
	margin: 0 auto;
}

.loginForm {
	width: 310px;
	margin: 0 auto;
}

.form-control {
	display: inline;
}

a:link {
	text-decoration: none;
	color: #646464;
}

a:visited {
	text-decoration: none;
	color: #646464;
}

a:active {
	text-decoration: none;
	color: #646464;
}

a:hover {
	text-decoration: none;
	color: #646464;
}

</style>

<script type="text/javascript">

	// 로그인 정보 저장
	$(document).ready(function() {
		// 저장된 쿠키값을 가져와서 ID칸에 넣어준다. 없으면 공백
		var key = getCookie("key");
		$("#buyerId").val(key);
		var keypw = getCookie("keypw");
		$("#buyerPw").val(keypw);
		
// 		console.log(key);
		
		if($("#buyerId").val() != "") { // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
			$("#saveId").attr("checked", true); // ID 저장하기를 체크 상태로 두기
		}
		
		$("#saveId").change(function() { // 체크박스에 변화가 있다면,
			if($("#saveId").is(":checked")) { // ID저장하기 체크했을 때
				setCookie("key", $("#buyerId").val(), 7); // 7일 동안 쿠키 보관
				setCookie("keypw", $("#buyerPw").val(), 7);
			} else { // ID저장 체크 해제 시
				deleteCookie("key");
				deleteCookie("keypw");
			}
		});
		
		// 로그인 정보 저장을 체크한 상태에서 로그인 정보를 입력하는 경우, 이경우에도 쿠키 저장
		$("#buyerId").keyup(function() { // id 입력칸에 id 입력할 때
			if($("#saveId").is(":checked")) { // id 저장하기를 체크한 상태라면
				setCookie("key", $("#buyerId").val(), 7); // 7일 동안 쿠키 보관
			}
		});
		
		$("#buyerPw").keyup(function() { // pw 입력할 때
			if($("#saveId").is(":checked")) { // 로그인 정보 저장하기를 체크한 상태라면
				setCookie("keypw", $("#buyerPw").val(), 7); // 7일 동안 쿠키 보관
			}
		});
	});
	
	function setCookie(cookieName, value, exdays){
	    var exdate = new Date();
	    exdate.setDate(exdate.getDate() + exdays);
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1)end = cookieData.length;
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	

	// 아이디, 비밀번호 입력 확인
	function checkValue() {
		if(!document.sellerInfo.buyerId.value) {
			alert("아이디를 입력하세요!");
			return false;
		}
		
		if(!document.sellerInfo.buyerPw.value) {
			alert("비밀번호를 입력하세요!");
			return false;
		}
	}

</script>
    
<div class="login">

<c:if test="${not buyerLogin }">

<div>
<h3>BigItssue 로그인</h3>
<hr>
</div>

<div class="loginForm">
<!-- <div class="container container-center" style="margin-left:40%; margin-right:40%"> -->

<form action="/buyer/login" method="POST" name="buyerInfo" onsubmit="return checkValue()" >
<div style="text-align: center;">
	<span style="margin: 10px;" class="glyphicon glyphicon-user" aria-hidden="true"></span>
	<input class="form-control" style="height: 30px; width : 250px;" type="text" name="buyerId" id="buyerId" />
	<br><br>

	<span style="margin: 10px;" class="glyphicon glyphicon-lock" aria-hidden="true"></span>
	<input class="form-control" style="height: 30px; width : 250px;" type="password" name="buyerPw" id="buyerPw" />
	<br>

	<div style="text-align: right; margin: 10px;">
	<input style="margin: 10px;" type="checkbox" id="saveId" /><label for="saveId" id="saveId">로그인 정보 저장</label>
	<!-- <input style="margin: 10px;" type="checkbox" id="autoLogin" /><label for="autoLogin" id="autoLogin">자동 로그인</label> -->
	</div>

	<button style="width: 300px;" class="btn btn-primary">로그인</button>
	
	<br><br>
	<small>
		<a href="/buyer/join">회원가입</a>&nbsp;|
		<a href="/buyer/findid">아이디 찾기</a>&nbsp;|&nbsp;
		<a href="/buyer/findpw">비밀번호 찾기</a>
	</small>
	
</div>
</form>
<!-- </div> -->
</div>
</c:if>
</div>

<%-- <c:if test="${buyerLogin }"> --%>
<%-- <strong>${buyerId } 님, 환영합니다</strong>  --%>
<!-- <a href="#"><input type="button" value="main"></a> -->
<!-- 	<a href="/buyer/logout"><input type="button" value="로그아웃"></a> -->
<%-- </c:if> --%>