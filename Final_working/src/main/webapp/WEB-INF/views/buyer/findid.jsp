<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>






<h1>아이디찾기</h1>

<div class="container container-center" style="margin-left:40%; margin-right:40%">
<form action="/buyer/findid" method="post" onsubmit="return buyerfindid()">
이름 : <input class="form-control" style="width : 250px;" type="text" name="buyerName" id="buyerName"><br>
이메일 : <input class="form-control" style="width : 250px;" type="text" name="buyerEmail" id="buyerEmail"><br>
<input class="btn" type="submit" value="찾기">


</form>
</div>