<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
function selectId(a){
	opener.document.getElementById("sellerId").value=a;
	window.close();
}


</script>

<div class="container text-center" style="width:500px; height:400px;">
<h4>연결할 계정을 선택하세요</h4>
<hr>
<table class="table table-striped table-bordered table-hover">
<thead style="background: #cccccc6e">
<tr>
<th style="width: 25%" class="container text-center">판매자 이름</th>
<th style="width: 25%" class="container text-center">판매자 아이디</th>
<th style="width: 25%" class="container text-center">핸드폰번호</th>
<th style="width: 25%" class="container text-center">빅돔계정</th>
</tr>
</thead>
<c:forEach items="${sellerInfo }" var="i">
<tr onclick="selectId('${i.sellerId}')">
	<td>${i.sellerName }</td>
	<td>${i.sellerId }</td>
	<td>${i.sellerPhone }</td>
	<td>${i.bigdomId }</td>
</tr>
</c:forEach>

</table>
</div>