<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

</script>

<hr>

<div style="padding-left: 120px; padding-right: 120px; padding-top: 10px;">
<h4><strong>BigItssue 비밀번호 찾기</strong></h4>
<hr>
</div>

<div style="margin-left:40%; margin-right:40%">
<form action="/buyer/findpw" method="post">

<label>아이디</label> <input class="form-control" style="width : 250px;" type="text" name="buyerId" id="buyerId"><br>
<label>이름</label> <input class="form-control" style="width : 250px;" type="text" name="buyerName" id="buyerName"><br>
<label>이메일</label> <input class="form-control" style="width : 250px;" type="email" name="buyerEmail" id="buyerEmail"><br>
<input class="btn" type="submit" value="찾기">


</form>
</div>