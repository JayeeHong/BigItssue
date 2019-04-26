<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
	.login {
		width: 310px;
		margin: 0 auto;
	}
	
	/**/
	
</style>

<script type="text/javascript">

	// 아이디 저장
	$(document).ready(function() {
		
		// 저장된 쿠키값을 가져와서 ID칸에 넣어준다. 없으면 공백
		var key = getCookie("key");
		$("#sellerId").val(key);
		
// 		console.log(key);
		
		if($("#sellerId").val() != "") { // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
			$("#saveId").attr("checked", true); // ID 저장하기를 체크 상태로 두기
		}
		
		$("#saveId").change(function() { // 체크박스에 변화가 있다면,
			if($("#saveId").is(":checked")) { // ID저장하기 체크했을 대
				setCookie("key", $("#sellerId").val(), 7); // 7일 동안 쿠키 보관
			} else { // ID저장 체크 해제 시
				deleteCookie("key");
			}
		});
		
		// ID저장을 체크한 상태에서 ID를 입력하는 경우, 이경우에도 쿠키 저장
		$("#sellerId").keyup(function() { // id 입력칸에 id 입력할 때
			if($("#saveId").is(":checked")) { // id 저장하기를 체크한 상태라면
				setCookie("key", $("#sellerId").val(), 7); // 7일 동안 쿠키 보관
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
		if(!document.sellerInfo.sellerId.value) {
			alert("아이디를 입력하세요!");
			return false;
		}
		
		if(!document.sellerInfo.sellerPw.value) {
			alert("비밀번호를 입력하세요!");
			return false;
		}
	}

</script>

<div class="login">

<c:if test="${not sellerLogin }">
<div>
<h3>판매자 로그인</h3>
</div>

<form action="/seller/login" method="POST" name="sellerInfo" onsubmit="return checkValue()">
<div style="text-align: center;">
<span style="margin: 10px;" class="glyphicon glyphicon-user" aria-hidden="true"></span>
<input style="height: 30px; width: 250px; margin: 10px" type="text" id="sellerId" name="sellerId" />
<br>
<span style="margin: 10px;" class="glyphicon glyphicon-lock" aria-hidden="true"></span>
<input style="height: 30px; width: 250px; margin: 10px" type="password" name="sellerPw" />
<br>

<div style="text-align: right; margin: 10px;">
<input style="margin: 10px;" type="checkbox" id="saveId" /><label for="saveId" id="saveId">아이디 저장</label>
<input style="margin: 10px;" type="checkbox" id="autoLogin" /><label for="autoLogin" id="autoLogin">자동 로그인</label>
</div>

<button style="width: 300px;" class="btn btn-primary">로그인</button>
</div>
</form>
</c:if>

<c:if test="${sellerLogin }">
채팅창
</c:if>

</div>