<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>판매자 추가</h3>
<hr>

${sellerInfo.sellerId }<br>
${sellerInfo.sellerPw }<br>
${sellerInfo.sellerName }<br>
${sellerInfo.sellerPhone }<br>
${sellerInfo.bigdomId }<br>

</div>

</div>