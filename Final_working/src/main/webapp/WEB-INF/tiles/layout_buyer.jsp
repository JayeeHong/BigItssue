<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BigItssue</title>

<!-- 모든 페이지에 jQuery 2.2.4.min 추가 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- 부트스트랩 3.3.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<style type="text/css">
	/* 모든 페이지에 적용되는 스타일 */
	
/* 	.wrap { */
/* 		width: 1100px; */
/* 		margin: 0 auto; */
/* 		border: 1px solid #ccc; */
/* 	} */


</style>

<script type="text/javascript">
	/* 모든 페이지에 적용되는 자바스크립트 */

</script>

</head>
<body>

<!-- HEADER -->
<tiles:insertAttribute name="header" />

<!-- BODY -->
<div class="wrap container">
	<tiles:insertAttribute name="body" />
</div>

<!-- FOOTER -->
<tiles:insertAttribute name="footer" />

</body>
</html>