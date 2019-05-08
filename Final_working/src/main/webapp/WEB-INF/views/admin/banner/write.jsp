<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>배너 등록</h3>
<hr>
    

	<div>
		<form action="/admin/banner/write" method="post" enctype="multipart/form-data">
		<table class="table table-bordered">
		<tr>
			<td class="info">배너번호</td>
			<td><input type="text" style='border:none;' name="bannerNo" value="${bannerno }" readonly onfocus='this.blur()'/></td>
		</tr>
		</table>
		
		<label>등록할 사진 : <input type="file" name="bannerImg" /></label>
		
		</form>
	</div>
	
	<div class="text-center">	
		<button type="button" id="btnWrite" class="btn btn-primary">등록</button>
		<button type="button" id="btnCancel" class="btn btn-info">취소</button>
	</div>
	

	
</div>
</div>