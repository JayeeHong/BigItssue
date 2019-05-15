<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<hr>

<div style="padding-left: 120px; padding-right: 120px; padding-top: 10px;">
<h4><strong>BigItssue 아이디 찾기</strong></h4>
<hr>
</div>

<div style="margin-left:40%; margin-right:40%">
<form action="/buyer/findid" method="post" onsubmit="return buyerfindid()">
<label>이름</label> <input class="form-control" style="width : 250px;" type="text" name="buyerName" id="buyerName"><br>
<label>이메일</label> <input class="form-control" style="width : 250px;" type="text" name="buyerEmail" id="buyerEmail"><br>
<input class="btn btn-default" type="submit" value="찾기">


</form>
</div>