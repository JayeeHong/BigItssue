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
	
	.table>tbody>tr>td {
		vertical-align: middle;
	}
	
	.table>thead>tr>td {
		vertical-align: middle;
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

function deactivateSeller(sellerId) {
	result = confirm('판매자를 비활성화하시겠습니까?');
	
	if(result==true) {
		$(location).attr("href", "/admin/info/deactivateSeller?sellerId="+sellerId);
	} else {
		return false;
	}
}

function activateSeller(sellerId) {
	result = confirm('판매자를 활성화하시겠습니까?'+'\n'
			+'확인을 클릭하시면 판매자 판매정보 관리 페이지로 넘어갑니다.');
	
	if(result==true) {
		$(location).attr("href", "/admin/seller/list");
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
<table class="table">
	<thead>
		<tr>
			<td style="width: 10%">번호</td>
			<td style="width: 20%">판매자</td>
			<td style="width: 20%">아이디</td>
			<td style="width: 20%">비밀번호</td>
			<td style="width: 15%">연락처</td>
			<td style="width: 15%">수정</td>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach varStatus="status" var="i" begin="0" end="${sellerbigdomList.size()-1 }" step="1">
		<tr>
			<c:if test="${curPage eq 0 }">
			<td rowspan="3">${(totalCount-status.index)-((1-1)*10) }</td>
			</c:if>
			<c:if test="${curPage ne 0 }">
			<td rowspan="3">${(totalCount-status.index)-((curPage-1)*10) }</td>
			</c:if>
		
			<td>
				<c:if test="${sellerbigdomList[i].sellerImg ne null }">
					<img style="width: 25px; height: 25px;" src="/upload/${sellerbigdomList[i].sellerImg }">
				</c:if>
				<c:if test="${sellerbigdomList[i].sellerImg eq null }">
					<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
				</c:if>
				${sellerbigdomList[i].sellerName }
			</td>
			<td>${sellerbigdomList[i].sellerId }</td>
			<td>${sellerbigdomList[i].sellerPw }</td>
			<td>${sellerbigdomList[i].sellerPhone }</td>
			<td rowspan="3">
				<button class="btn btn-xs btn-primary" onclick="upSeller('${sellerbigdomList[i].sellerId}');">수정</button>
				
				<c:if test="${not sellerStatusList[i] }">
				<button id="${sellerStatusList[i] }" class="btn btn-xs btn-success" onclick="activateSeller('${sellerbigdomList[i].sellerId}');">활성화</button>
				</c:if>
				<c:if test="${sellerStatusList[i] }">
				<button id="${sellerStatusList[i] }" class="btn btn-xs btn-danger" onclick="deactivateSeller('${sellerbigdomList[i].sellerId}');">비활성화</button>
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

<jsp:include page="/WEB-INF/views/admin/info/seller/paging.jsp"/>

</div>

</div>