<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_buyer.jsp" />

<div>

<h3>마이페이지-정보수정</h3>

<!-- 비밀번호 확인 전 -->
<div style="padding-top: 50px; padding-left: 500px;">

보안을 위해 회원님의 비밀번호를 한번 더 입력받고 있습니다<br>
비밀번호를 입력해주세요<br><br>
	<form action="/buyer/my/confirmpw" method="POST">
		비밀번호 : <input type="password" name="buyerPw" />
		<button class="btn btn-primary btn-sm">확인</button>
	</form>
	
</div>
<!-- ---------------- -->

</div>

</div>