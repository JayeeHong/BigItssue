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
	
</style>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>판매자 계정 수정</h3>
<hr>

<table class="table table-bordered">

<tr>
	<td style="width: 35%">판매자 이름</td>
	<td style="width: 65%"><input style="width: 100px;" type="text" value="name" name="sellerName" /></td>
</tr>

<tr>
	<td>아이디</td>
	<td>id</td>
</tr>

<tr>
	<td>비밀번호</td>
	<td><input style="width: 100px;" type="text" value="pw02" name="sellerPw" /></td>
</tr>


<tr>
	<td>연락처</td>
	<td>
		<select name="sellerPhone1">
			<option value="010" selected>010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="02">02</option>
			<option value="031">031</option>
		</select>
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" value="3333" name="sellerPhone2" />
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" value="5555" name="sellerPhone3" />
	</td>
</tr>

</table>

<table class="table table-bordered">

<tr>
	<td colspan="2">판매자와 연동된 빅돔</td>
</tr>

<tr>
	<td width="20%" style="text-align: center; background: none;">
	빅돔아이디&nbsp;&nbsp;&nbsp;<button class="btn btn-xs btn-danger">삭제</button>
	</td>
</tr>

</table>
</div>
</div>