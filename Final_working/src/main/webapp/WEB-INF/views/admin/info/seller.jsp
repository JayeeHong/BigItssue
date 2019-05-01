<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
	.nav-tabs {
		border-bottom: none;
	}
	
	.table {
		text-align: center;
	}
	
	.table thead {
		font-weight: bold;
	}
</style>

<script type="text/javascript">

$(document).ready(function () {
	$("#addSeller").click(function() {
		location.href="/admin/info/seller/add";
	});
})

function upSeller(sellerId) {
	$(location).attr("href", "/admin/info/seller/update?sellerId="+sellerId);
}

function delSeller(sellerId) {
	result = confirm('정말 삭제하시겠습니까?');
	
	if(result==true) {
		$(location).attr("href", "/admin/info/sellerDel?sellerId="+sellerId);
	} else {
		return false;
	}
}

</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>계정관리</h3>
<hr>

<div id="sellerList">
	<ul class="nav nav-tabs" style="height: 45px;">
		<li role="presentation" class="active"><a href="/admin/info/seller">판매자</a></li>
		<li role="presentation"><a href="/admin/info/buyer">구매자</a></li>
		<li role="presentation"><a href="/admin/info/bigdom">빅돔</a></li>
	</ul>
</div>
<br>
<button id="addSeller" class="btn btn-default">판매자 추가</button>
<br>
<div>

	<table class="table">
		<thead>
			<tr>
				<td style="width: 10%">번호</td>
				<td style="width: 20%">판매자</td>
				<td style="width: 20%">아이디</td>
				<td style="width: 20%">비밀번호</td>
				<td style="width: 15%">연락처</td>
				<td style="width: 15%">수정|(비)활성화</td>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach var="i" begin="0" end="${sellerbigdomList.size()-1 }" step="1">
			<tr>
				<td style="padding-top: 48px;" rowspan="3">${i+1 }</td>
				<td>${sellerbigdomList[i].sellerName }</td>
				<td>${sellerbigdomList[i].sellerId }</td>
				<td>${sellerbigdomList[i].sellerPw }</td>
				<td>${sellerbigdomList[i].sellerPhone }</td>
				<td style="padding-top: 45px;" rowspan="3">
					<button class="btn btn-xs btn-primary" onclick="upSeller('${sellerbigdomList[i].sellerId}');">수정</button>
					
					<c:if test="${not sellerStatusList[i] }">
					<button id="${sellerStatusList[i] }" class="btn btn-xs btn-success" onclick="activateSeller('${sbList.sellerId}');">활성화</button>
					</c:if>
					<c:if test="${sellerStatusList[i] }">
					<button id="${sellerStatusList[i] }" class="btn btn-xs btn-danger" onclick="deactivateSeller('${sbList.sellerId}');">비활성화</button>
					</c:if>
				</td>
			</tr>
			
			<tr>
				<td colspan="4" style="background: #cccccc6e">빅돔 아이디</td>
			</tr>
			<tr>
				<td colspan="4">
					${sellerbigdomList[i].bigdomId }
					<c:if test="${sellerbigdomList[i].bigdomId eq null }">
					빅돔이 없습니다
					</c:if>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>

</div>

</div>

</div>