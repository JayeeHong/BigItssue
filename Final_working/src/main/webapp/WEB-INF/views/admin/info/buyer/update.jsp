<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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

$(document).ready(function() {
	$("select option[value=${buyerInfo.buyerPhone1 }]").attr("selected","selected");

});


function email_change() {
	if (document.upForm.emailSelect.options[document.upForm.emailSelect.selectedIndex].value == '0') {
// 		document.upForm.buyerEmail2.disabled = true;
		document.upForm.buyerEmail2.value = "";

	}

	if (document.upForm.emailSelect.options[document.upForm.emailSelect.selectedIndex].value == '9') {
// 		document.upForm.buyerEmail2.disabled = false;
		document.upForm.buyerEmail2.value = "";
		document.upForm.buyerEmail2.focus();

	} else {
// 		document.upForm.buyerEmail2.disabled = true;
		document.upForm.buyerEmail2.value = document.upForm.emailSelect.options[document.upForm.emailSelect.selectedIndex].value;

	}
}

function toList() {
	form = document.upForm;
	form.method="post";
	form.action = "/admin/info/buyer";
	form.submit();
}

function upBuyer(buyerId) {
	
	if(document.upForm.buyerPw.value) { // 비밀번호 정보가 있는경우
		pwResult = confirm('사용자의 비밀번호가 변경됩니다.\n진행하시겠습니까?');
		
		if(pwResult == true) { // 비밀번호 변경 ok
			result = confirm('구매자 정보를 변경하시겠습니까?');

			if (result == true) {
				form = document.upForm;
				form.action = "/admin/info/buyerUp?buyerId=" + buyerId;
				form.submit();
				
			} else {
				return false;
				
			}
			
		} else { // 비밀번호 변경 취소
			return false;
		}
		
	} else { // 비밀번호 정보가 없는 경우
		
		result = confirm('구매자 정보를 변경하시겠습니까?');

		if (result == true) {
			form = document.upForm;
			form.action = "/admin/info/buyerUp?buyerId=" + buyerId;
			form.submit();
			
		} else {
			return false;
			
		}
			
	}
	
	
}

function delBuyer(buyerId) {
	result = confirm('구매자 정보를 삭제하시겠습니까?');

	if (result == true) {
		form = document.upForm;
		form.action = "/admin/info/buyerDel?buyerId=" + buyerId;
		form.submit();
	} else {
		return false;
	}

}
</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>구매자 계정 수정</h3>
<hr>

<form name="upForm">
<input type="hidden" name="buyerId" value="${buyerInfo.buyerId }" />
<table class="table table-bordered">

<tr>
	<td style="width: 35%">구매자 이름</td>
	<td style="width: 65%"><input style="width:100px;" type="text" value="${buyerInfo.buyerName }" name="buyerName" /></td>
</tr>

<tr>
	<td>아이디</td>
	<td>${buyerInfo.buyerId }</td>
</tr>

<tr>
	<td>비밀번호</td>
	<td><input style="width:200px;" type="text" value="" name="buyerPw" placeholder="변경할 경우에만 입력하세요." /></td>
</tr>

<tr>
	<td>연락처</td>
	<td>
		<c:if test="${buyerInfo.buyerPhone ne null }">
		<select name="buyerPhone1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="02">02</option>
			<option value="031">031</option>
		</select>
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="${buyerInfo.buyerPhone2 }" name="buyerPhone2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="${buyerInfo.buyerPhone3 }" name="buyerPhone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		</c:if>
		
		<c:if test="${buyerInfo.buyerPhone eq null }">
		<select name="buyerPhone1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="02">02</option>
			<option value="031">031</option>
		</select>
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="" name="buyerPhone2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="" name="buyerPhone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		</c:if>
	</td>
</tr>

<tr>
	<td>이메일</td>
	<td>
		<input style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail1 }" name="buyerEmail1" />
		&nbsp;@&nbsp;
		<input style="width: 80px; text-align: center;" type="text" value="${buyerInfo.buyerEmail2 }" name="buyerEmail2" />
		<select name="emailSelect" onchange="email_change()">
			<option value="0" >선택하세요</option>
			<option value="9">직접입력</option>
			<option value="naver.com">naver.com</option>
			<option value="daum.net">daum.net</option> 
			<option value="gmail.com">gmail.com</option> 
			<option value="nate.com">nate.com</option> 
		</select>
	</td>
</tr>

</table>

<div style="text-align: center;">
<button id="" class="btn btn-default" onclick="toList();">목록</button>
<button class="btn btn-primary" onclick="upBuyer('${buyerInfo.buyerId }');">수정</button>
<button class="btn btn-danger" onclick="delBuyer('${buyerInfo.buyerId}');">삭제</button>
</div>
</form>

</div>

</div>