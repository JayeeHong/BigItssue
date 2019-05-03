<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">



</script>




<h1>비밀번호찾기</h1>


<div class="container container-center" style="margin-left:40%; margin-right:40%">
<form action="/buyer/findpw" method="post">

아이디 : <input class="form-control" style="width : 250px;" type="text" name="buyerId" id="buyerId"><br>
이름 : <input class="form-control" style="width : 250px;" type="text" name="buyerName" id="buyerName"><br>
이메일 : <input class="form-control" style="width : 250px;" type="email" name="buyerEmail" id="buyerEmail"><br>
<input class="btn" type="submit" value="찾기">


</form>
</div>