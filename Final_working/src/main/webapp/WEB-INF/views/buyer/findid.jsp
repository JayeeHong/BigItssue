<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>






<h1>아이디찾기</h1>


<form action="/buyer/findid" method="post" onsubmit="return buyerfindid()">
이름 : <input type="text" name="buyerName" id="buyerName"><br>
이메일 : <input type="text" name="buyerEmail" id="buyerEmail"><br>
<input type="submit" value="찾기">


</form>