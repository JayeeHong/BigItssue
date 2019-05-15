<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<script type="text/javascript">
$(document).ready(function() {
	$("#addBanner").click(function() {
// 		location.href = "/admin/banner/add";
		window.open("/addBanner","dd", "width=500,height=500");
	});
});

/* 체크박스 전체 선택, 해제 */
function checkAll() {
	if( $("#checkAll").is(':checked') ) {
		$("input[name=checkRow]").prop("checked", true);
	} else {
		$("input[name=checkRow]").prop("checked", false);
	}
}

/* 체크박스 삭제 */
function checkDelete() {
	var checkRow = "";
	$("input[name='checkRow']:checked").each(function() {
		checkRow = checkRow + $(this).val() + ",";
	});
	checkRow = checkRow.substring(0, checkRow.lastIndexOf(",")); //맨끝 콤마 지우기
	
	if(checkRow == '') {
		alert("삭제할 배너를 선택하세요");
		return false;
	}
	console.log("### checkRow => {}" + checkRow);
	
	if(confirm("삭제?")) {
		//삭제 후 다시 불러올 리스트 url
		location.href = "/admin/banner/delete?checkRow="+checkRow;
	}
}
</script>


<style type="text/css">

</style>





<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4><strong>배너관리</strong></h4>
<hr>

	<div id="bannerList">
		<table class="table">
			<thead>
				<tr>
					<th style="width: 20%"><input type="checkbox" name="checkAll" id="checkAll" onclick="checkAll();" /></th>
					<th style="width: 80%">배너 이미지</th>
				</tr>
			</thead>
			
			<tbody>
			<c:forEach items="${bannerList}" var="b">
				<tr>
					<td><input type="checkbox" name="checkRow" value="${b.bannerNo }" /></td>
					<td><img src="/upload/${b.bannerImg }" width="300px" height="150px"></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>	
	</div>


	<div id="btnBox">
		<input class="btn btn-danger btn-sm" type="button" id="checkDelete" onclick="checkDelete();" value="선택 삭제" />
		<button class="btn btn-primary btn-sm" id="addBanner">배너추가</button>
	</div>


</div>

</div>

<br><br><br>