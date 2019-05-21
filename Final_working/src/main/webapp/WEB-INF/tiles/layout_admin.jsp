<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BigItssue 관리자 페이지</title>

<!-- 모든 페이지에 jQuery 2.2.4.min 추가 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- 부트스트랩 3.3.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<style type="text/css">
	/* 모든 페이지에 적용되는 스타일 */
pre {
	white-space: pre-wrap; /* CSS3*/
	white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
	white-space: -pre-wrap; /* Opera 4-6 */
	white-space: -o-pre-wrap; /* Opera 7 */
	word-wrap: break-all; /* Internet Explorer 5.5+ */ 
}

</style>

<script type="text/javascript">
/* 모든 페이지에 적용되는 자바스크립트 */

</script>

</head>
<body>

<!-- HEADER -->
<div class="container">
	<tiles:insertAttribute name="header" />
</div>

<!-- BODY -->
<div class="wrap container">
	<tiles:insertAttribute name="body" />
</div>

</body>
</html>