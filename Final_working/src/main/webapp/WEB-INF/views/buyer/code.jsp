<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
$(document).ready(function(){
	$("#codeConfirm").click(function(){
		
		var a = $("#wirteCode").val()
		var b = $("#emailCode").val()
		
		if( a == b ) {
			alert("ok")
			var c = true
			window.opener.emailConfirm(c)
			window.close()
		}else{
			alert("코드를 다시 한번 확인해주세요")
			
		}
	})
})


</script>
    
    
코드를입력하세요 : <input type="text" name="wirteCode" id="wirteCode">
<input type="button" name="" id="codeConfirm" value="확인">
<input type="text" name="" id="emailCode" value="1234">

${emailCode }