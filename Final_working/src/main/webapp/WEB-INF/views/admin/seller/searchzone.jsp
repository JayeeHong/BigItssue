<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

function searchSubway(){
	$.ajax({
		url : "/admin/seller/searchzone"
		,type : "post"
		,data : {searchWord : $("#searchWord").val()}
		,dataType : "json"
		,success : function(res){
			console.log(res)
		}
		, error : function(e){
			console.log(e)
		}
	})
}



</script>    
    
    

	
	검색<input type="search" name="searchWord" id="searchWord">
	<input type="button" value="찾기" onclick="searchSubway()">
