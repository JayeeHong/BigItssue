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
	
</style>

<script type="text/javascript">

$(document).ready(function() {
	$("select option[value=${sbList.sellerPhone1 }]").attr("selected","selected");

});

function inNumber(){
	if(event.keyCode<48 || event.keyCode>57){
		event.returnValue=false;
	}
}



// function delBigdom(bigdomId) {
// 	result=confirm('빅돔 정보를 삭제하시겠습니까?');
	
// 	if(result==true) {
// 		form = document.upForm;
// 		form.action="/admin/info/bigdomDel?bigdomId="+bigdomId;
// 		form.submit();
// 	} else {
// 		return false;
// 	}
// }

function toList() {
	form = document.upForm;
	form.action="/admin/info/seller";
	form.submit();
}

function upSeller(sellerId) {
	result = confirm('판매자 정보를 변경하시겠습니까?');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/info/sellerUp?sellerId="+sellerId;
		form.submit();
// 		$(location).attr("href", "/admin/info/sellerUp?sellerId="+sellerId);
	} else {
		return false;
	}
}

function deactivateSeller(sellerId) {
	result = confirm('판매자를 비활성화하시겠습니까?');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/info/deactivateSeller?sellerId="+sellerId;
		form.submit();
	} else {
		return false;
	}
}

function activateSeller(sellerId) {
	result = confirm('판매자를 활성화하시겠습니까?'+'\n'
			+'확인을 클릭하시면 판매장소관리 페이지로 넘어갑니다.');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/loc/list";
		form.submit();
	} else {
		return false;
	}
}

function deactivateBigdom(bigdomId) {
	result = confirm('빅돔을 비활성화하시겠습니까?');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/info/deactivateBigdom?bigdomId="+bigdomId;
		form.submit();
	} else {
		return false;
	}
}

function activateBigdom(bigdomId) {
	result = confirm('빅돔을 활성화하시겠습니까?');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/info/activateBigdom?bigdomId="+bigdomId;
		form.submit();
	} else {
		return false;
	}
}

</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>판매자 계정 수정</h3>
<hr>

<c:if test="${not sellerStatus }">
해당 판매자는 비활성화 상태입니다.
</c:if>

<form name="upForm">
<input type="hidden" name="sellerId" value="${sbList.sellerId }"/>
<input type="hidden" name="bigdomId" value="${sbList.bigdomId }"/>
<table class="table table-bordered">

<tr>
	<td style="width: 35%">판매자 이름</td>
	<td style="width: 65%"><input style="width: 100px;" type="text" value="${sbList.sellerName }" name="sellerName" /></td>
</tr>

<tr>
	<td>아이디</td>
	<td>${sbList.sellerId }</td>
</tr>

<tr>
	<td>비밀번호</td>
	<td><input style="width: 100px;" type="text" value="${sbList.sellerPw }" name="sellerPw" /></td>
</tr>


<tr>
	<td>연락처</td>
	<td>
		<c:if test="${sbList.sellerPhone ne null }">
		<select name="sellerPhone1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="02">02</option>
			<option value="031">031</option>
		</select>
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="${sbList.sellerPhone2 }" name="sellerPhone2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="${sbList.sellerPhone3 }" name="sellerPhone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		</c:if>
		
		<c:if test="${sbList.sellerPhone eq null }">
		<select name="sellerPhone1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="02">02</option>
			<option value="031">031</option>
		</select>
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="" name="sellerPhone2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="" name="sellerPhone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		</c:if>
	</td>
</tr>

</table>

<table class="table table-bordered">

<tr>
	<td colspan="2">
	판매자와 연동된 빅돔<br>
	<small>*빅돔은 판매자가 활성화 상태인 경우에만 활성화/비활성화가 가능합니다.</small>
	</td>
</tr>

<tr>
	<td width="20%" style="text-align: center; background: none;">
	${sbList.bigdomId }&nbsp;&nbsp;&nbsp;
<%-- 	<button class="btn btn-xs btn-danger" onclick="delBigdom('${sbList.bigdomId }');">삭제</button> --%>
	<c:if test="${sellerStatus }">
		<c:if test="${not bigdomStatus }">
		<button class="btn btn-xs btn-success" onclick="activateBigdom('${sbList.bigdomId}');">활성화</button>
		</c:if>
		<c:if test="${bigdomStatus }">
		<button class="btn btn-xs btn-danger" onclick="deactivateBigdom('${sbList.bigdomId}');">비활성화</button>
		</c:if>
	</c:if>
	
	</td>
</tr>

</table>
<br><br>
<div style="text-align: center;">
<button class="btn btn-default" onclick="toList();">목록</button>
<button class="btn btn-primary" onclick="upSeller('${sbList.sellerId}');">수정</button>

<c:if test="${not sellerStatus }">
<button class="btn btn-success" onclick="activateSeller('${sbList.sellerId}');">활성화</button>
</c:if>
<c:if test="${sellerStatus }">
<button class="btn btn-danger" onclick="deactivateSeller('${sbList.sellerId}');">비활성화</button>
</c:if>

</div>
</form>

</div>
</div>