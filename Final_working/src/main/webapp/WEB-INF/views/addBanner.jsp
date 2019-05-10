<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BigItssue</title>

<!-- 모든 페이지에 jQuery 2.2.4.min 추가 -->
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<!-- jQuery Form Plugin -->
<script src="http://malsup.github.com/min/jquery.form.min.js"></script> 
 
<script type="text/javascript">
$(document).ready(function() {
	
	//jquery.form.js 플러그인 사용
	//	http://malsup.com/jquery/form/
	
	//<form> 태그가 submit 되면 ajaxForm 자동으로 실행됨
	
	$("#fileForm").ajaxForm({
// 		type: "post", //form에 설정한 값이 기본값
// 		url: "/addBanner", //form에 설정한 값이 기본값
		data: { }, 
		dataType: "json", 
		success: function( res ) {
			
// 			console.log("성공");
			
			var a = '';
			a += '<tr>';
			a += '<td><input type="checkbox" name="checkRow" value="' + res.mainBanner.bannerNo + '" /></td>';
			a += '<td><img src="/upload/' + res.mainBanner.bannerImg + '" width="300px" height="150px"></td>';
			a += '</tr>';
			
			var op = opener.document.getElementById("bannerList");
			
			$(op).find("tbody").append($(a));
			
// 			console.log(res);
			window.close();
		}, 
		error: function() {
			console.log("실패");
		}
	});
});
</script>

</head>
<body>



<h3>배너 등록</h3>
<hr>
    

	<div>
		<form id="fileForm" action="/addBanner" method="post" enctype="multipart/form-data">
		
		
			<input type="file" name="bannerFile"><br><br>
			<button id="btnSend">등록</button>
		
		</form>
	</div>






</body>
</html>