<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
function selectId(a){
	opener.document.getElementById("sellerId").value=a;
	window.close();
}


</script>

<div class="container text-center" style="width:400px; height:400px;">
<h4>연결한 계정을 선택하세요</h4>
<table class="table table-striped table-bordered table-hover">
<tr>
<th class="container text-center">판매자 이름</th>
<th class="container text-center">판매자 아이디</th>
<th class="container text-center">핸드폰번호</th>
<th class="container text-center">빅돔계정</th>
</tr>
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