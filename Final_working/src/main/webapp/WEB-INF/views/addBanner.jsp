<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

</head>
<body>



<h3>배너 등록</h3>
<hr>
    

	<div>
		<form action="/addBanner" method="post" enctype="multipart/form-data">
		
		
			<input type="file" name="bannerFile"><br><br>
			<button class="btn btn-primary btn-sm">등록</button>
		
		</form>
	</div>






</body>
</html>