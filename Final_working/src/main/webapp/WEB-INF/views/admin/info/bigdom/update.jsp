<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

	.table {
		margin: 10px;
		width: 100%;
	}
	
	.table tr td:first-child {
		text-align: center;
		background: #cccccc4d;
	}
	
	.table tr td select {
		height: 26px;
	}
	
	.table>tbody>tr>td {
		vertical-align: middle;
	}
	
	.table>thead>tr>td {
		vertical-align: middle;
	}
	
</style>

<script type="text/javascript">

function toList() {
	form = document.upForm;
	form.method="post";
	form.action="/admin/info/bigdom";
	form.submit();
}

function upBigdom(bigdomId) {
	result = confirm('빅돔 정보를 변경하시겠습니까?');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/info/bigdomUp?bigdomId="+bigdomId;
		form.submit();
	} else {
		return false;
	}
}

</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>빅돔 계정 수정</strong></h4>
<hr>

<form name="upForm">
<input type="hidden" name="bigdomId" value="${bigdomInfo.bigdomId }" />
<input type="hidden" name="sellerId" value="${bigdomInfo.sellerId }" />
<table class="table table-bordered">

<tr>
	<td style="width: 35%">빅돔 아이디</td>
	<td style="width: 65%">${bigdomInfo.bigdomId }</td>
</tr>

<tr>
	<td>빅돔 비밀번호</td>
	<td><input type="text" name="bigdomPw" value="${bigdomInfo.bigdomPw }" /></td>
</tr>

<tr>
	<td>연결된 판매자 정보</td>
	<td>${bigdomInfo.sellerId }</td>
</tr>

</table>

<div style="text-align: center;">
<button class="btn btn-default" onclick="toList();">목록</button>
<button class="btn btn-primary" onclick="upBigdom('${bigdomInfo.bigdomId }')">수정</button>
</div>
</form>

</div>

</div>