<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>배너 등록</h3>
<hr>
    

	<div>
		<form action="/admin/banner/add" method="post" enctype="multipart/form-data">
		
		
			<input type="file" name="bannerFile"><br><br>
			<button class="btn btn-primary btn-sm">등록</button>
		
		</form>
	</div>


</div>
</div>