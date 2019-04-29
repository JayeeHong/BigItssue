<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
<form action="/buyer/join" method="post" onsubmit="return joinConfirm()" class="form-horizontal">
	<div class="form-control">
		<label style="float: left;">아이디</label>
		<div style="">
			${buyerId }
		</div>
	</div>
	
	<div class="form-control">
		<label style="float:left; ">비밀번호</label>
		<div style="">
			<input class="" type="password" name="buyerPw" id="buyerPw">
		</div> 
		<div id="pwTest"></div>
	</div>
	
	<div class="">
		<label class="col-sm-3 col-sm-offset-1 control-label">비밀번호 확인</label>
		<div class="col-sm-5">
			<input class="form-control" type="password" name="pwConfirm" id="pwConfirm">
		</div>
		<div id="okPw"></div>
	</div>
	
	<div class="">
		<label class="col-sm-3 col-sm-offset-1 control-label">이름</label>
		<div class="col-sm-5">
			<input class="form-control" type="text" name="buyerName" id="buyerName">
		</div>
	</div>
	
	<div class="">
		<label class="col-sm-3 col-sm-offset-1 control-label">Email</label>
		<div class="col-sm-5">
			<input class="form-control" type="email" name="buyerEmail" id="buyerEmail">
		</div>
		<input class="btn"type="button" value="인증코드발송" id="okemail">
		<div id="isItEmail"></div>
	</div>
	
	<div class="">
		<label class="col-sm-3 col-sm-offset-1 control-label">인증코드</label>
		<div class="col-sm-5">
			<input class="form-control" type="text" name="emailCode" id="emailCode"> <!-- 메일로 받은 인증코드를 입력하는 값  -->
		</div>
		<input class="btn" type="button" id="codeSame" value="확인">		<!-- 메일의 인증코드와 같은지 확인하는 버튼 -->
		<input type="hidden" value="" id="emailConfirm">		<!-- 메일로 보낸 인증코드를 저장하여 비교하는 hidden값 -->
	</div>
	
	<div class="">
		<label class="col-sm-3 col-sm-offset-1 control-label">휴대전화</label>
		<div class="col-sm-5">
			<input class="form-control" type="text" name="buyerPhone" id="buyerPhone">
		</div>
	</div>
	
	<br><br>
	
	<div class="col-sm-3 col-sm-offset-1"></div>
	<div class="col-sm-3">
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