<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<script type="text/javascript">





</script> 
<style>
.form{
	width : 200px;
}
</style>
    
<h1>로그인</h1>



<c:if test="${not buyerLogin }">
<div class="container container-center" style="margin-left:40%; margin-right:40%">
<form action="/buyer/login" method="POST" >

	 
	아이디 : <input class="form-control" style="width : 250px;" type="text" name="buyerId" id="buyerId" ><br>
	비밀번호 : <input class="form-control" style="width : 250px;" type="password" name="buyerPw" id="buyerPw" ><br>
	<input class="btn" type="submit" value="로그인"><a href="/buyer/join">
	<input class="btn" type="button" value="가입"></a><br>
	<input type="checkbox" >아이디 저장<br>
	<input type="checkbox" >자동로그인<br>
	
	<a href="/buyer/findid"><input class="btn" type="button" value="아이디찾기"></a>
	<a href="/buyer/findpw"><input class="btn" type="button" value="비밀번호찾기"></a>
	
</form>
</div>
</c:if>

<c:if test="${buyerLogin }">
<strong>${buyerId } 님, 환영합니다</strong> 
<a href="#"><input type="button" value="main"></a>
	<a href="/buyer/logout"><input type="button" value="로그아웃"></a>
</c:if>