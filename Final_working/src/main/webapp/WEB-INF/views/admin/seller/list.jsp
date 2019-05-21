<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style type="text/css">
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
	
	.table>thead>th {
		vertical-align: middle;
	}
  
  a{
cursor: pointer;
}
.centered { display: table; margin-left: auto; margin-right: auto; }
</style>

<script type="text/javascript">
$(document).ready(function(){
	getLocList();
})
var curPage = 0;
var condition;
var searchWord;
function getCurPage(a){
	curPage = a
	getLocList();
}


function detailView(a){
	window.location.href="/admin/seller/view?locNo="+a
}


function listDelete(a){
	var msg = confirm("삭제하시겠습니까?")
	if(msg==true){
		
	
	$.ajax({
		url :"/admin/seller/sellerInfoDelete"
		,type:"get"
		,data:{
			locNo : a
		}
		,dataType:"json"
		,success : function(){
			console.log('성공')
			getLocList()
			alert('삭제되었습니다.')
			
		}
		,error : function(e){
			console.log('실패')
			console.log(e)
		}
	})
	}else{
		alert('취소되었습니다.')
	}
	
}

function goBack(){
	curPage = 0;
	condition = 'zone';
	searchWord =''
	$("#searchWord").val('')
	$("#condition").val('zone').prop("selected", true);

	
	getLocList();
}

function searchSeller(){
	curPage = 0;
	condition =$("#condition").val()
	searchWord =$("#searchWord").val()
	getLocList();
}


function getLocList(){
	
	$.ajax({
		url:"/admin/seller/getSellerInfolist"
		,type:"get"
		,data:{condition : condition
			,searchWord : searchWord
			,curPage : curPage
		}
		,dataType: "json"
		,success : function(res){
			console.log('성공');
			var list = res.sellerLocList;
			var p = res.paging;
			var condition = res.condition;
			var searchWord = res.searchWord;
			var spmpc = p.startPage - p.pageCount
			var cpm1 = p.curPage - 1
			var cpp1 = p.curPage + 1
			var spppc = p.startPage + p.pageCount
			
			console.log("'a'");
			
			console.log(p);
			console.log(condition);
			console.log(searchWord);
			var html =""

				html ="<div id='tableAndpaging' >"
				html += '<div class="yapyap">'

				html += '<table class="table table-striped" style="table-layout: fixed; left: 240px; top: 230px; width:80%;">'
				html += '<tr style="background: #cccccc6e; text-align: center;">'
				html += '<td><b>No.</b></td>'
				html += '<td><b>역명</b></td>'
				html += '<td><b>판매장소</b></td>'
				html += '<td><b>출구(위치)</b></td>'
				html += '<td><b>카드결제여부</b></td>'
				html += '<td><b>판매시간</b></td>'
				html += '<td><b>판매자</b></td>'
				html += '<td><b> 수정 │ 삭제</b></td>'
				html += '</tr>'
				$.each(list, function(index, value){
					html +='<tr style="text-align: center;">'
					html += '<td>'+value.locNo+'</td>'
					
					if(value.zone ==null){
					html += '<td></td>'	
					}else{
					html += '<td>'+value.zone+'</td>'
					}
					
					if(value.station == null){
					html += '<td></td>'		
					}else{
					html += '<td>'+value.station+'</td>'
					}
					
					if(value.spot == null){
					html += '<td></td>'	
					}else{
					html += '<td>'+value.spot+'</td>'
					}
					
					html += '<td>'+value.sellerCard+'</td>'
					
					html +='<td>'
					if(value.sellerTimeS == 0){
					html += '0000' + '~'	
					}else{
					html += value.sellerTimeS + '~'		
					}
					
					if(value.sellerTimeE == 0){
					html += '0000'
					}else{
					html += value.sellerTimeE	
					}
					
					html += '</td>'
					if(value.sellerId == null){
					html += '<td>'+'연결된 계정이 없습니다'+'</td>'
					}else{
					html += '<td>'+value.sellerName+'</td>'
					}
// 					html += '<td><label><input class="btn btn-sm" style="background:#e0effd;" type="button" value="수정" onclick="detailView('+value.locNo+')">'
// 					html += '<input class="btn btn-sm" style="background:#ff8a8a;" type="button" value="삭제" onclick="listDelete('+value.locNo+')"></label> </td>'
					html += '<td><label><input class="btn btn-xs btn-primary" type="button" value="수정" onclick="detailView('+value.locNo+')">'
					html += ' │ ';
					html += '<input class="btn btn-xs btn-danger" type="button" value="삭제" onclick="return listDelete('+value.locNo+')"></label> </td>'
					html +='</tr>'
					
				})
					html += '</table>'
					html += '</div>'
					
					html += '<div class="text-center">'
					html += '<ul class="pagination pagination-sm">'
					if(p.curPage != 1){
// 					html +=	'<li><a href='+'"/admin/seller/list?curPage=1&condtion='+condition+'&searchWord='+searchWord+'">&larr;처음</a></li>'
// 					html += '<li><a onclick="getCurPage('+1+')">&larr;처음</a></li>'
					}
					if(p.curPage <= p.pageCount){		
// 					html +=	'<li class="disabled" id="id"><span>&laquo;</span></li>'
					html += '<li class="disabled"><a>&laquo;</a></li>'
					}
					if(p.curPage >= p.pageCount){
// 					html +=	'<li><a href='+'"/admin/seller/list?curPage='+spmpc+"&condition="+condition+"&searchWord="+searchWord+'">&laquo;</a></li>'
					html += '<li><a onclick="getCurPage('+spmpc+')">&laquo;</a></li>'
					}
					
					
					if(p.curPage == 1){
// 					html += '<li class="disabled"><span>&lt;</span></li>'
					html += '<li class="disabled"><a>&lt;</a></li>'
					}
					if(p.curPage != 1){
					html += '<li><a onclick="getCurPage('+cpm1+')">&lt;</a></li>'	
// 					html += '<li><a href='+'"/admin/seller/list?curPage='+cpm1+"&condition="+condition+"&searchWord="+searchWord+'">&lt;</a></li>'	
					}
					
					for(var i = p.startPage; i <= p.endPage; i++){
						if(p.curPage == i){
							html += '<li class="active"><a onclick="getCurPage('+i+')">'+i+'</a></li>'
// 							html += '<li class="active"><a href='+'"/admin/seller/list?curPage='+i+'&condition='+condition+'&searchWord='+searchWord+'">'+i+'</a></li>'
// 							html += '<li class="active"><a herf="#">'+i+'</a></li>'
						}
						if(p.curPage != i){
							html += '<li><a '+ 'onclick="getCurPage('+i+')">'+i+'</a></li>'
// 							html += '<li><a href='+'"/admin/seller/list?curPage='+i+'&condition='+condition+'&searchWord='+searchWord+'">'+i+'</a></li>'
						}
					}
					
					if(p.curPage == p.totalPage){
// 						html += '<li class="disabled"><span>&gt;</span></li>'
						html += '<li><a>&gt;</a></li>'
					}
					if(p.curPage != p.totalPage){
// 						html += '<li><a href='+'"/admin/seller/list?curPage='+cpp1+"&condition="+condition+"&seachWord="+searchWord+'">&gt;</a></li>'
						html += '<li><a onclick="getCurPage('+cpp1+')">&gt;</a></li>'
					}
					
					
					
					if(p.endPage == p.totalPage){
// 						html += '<li class="disabled"><span>&raquo;</span></li>'
						html += '<li><a>&raquo;</a><li>'
					}
					if(p.endPage != p.totalPage){
// 						html += '<li><a href='+'"/admin/seller/list?curPage='+spppc+"&condition="+condition+"&searchWord="+searchWord+'">&raquo;</a></li>'
						html += '<li><a onclick="getCurPage('+spppc+')">&raquo;</a></li>'
					}
					
					
					html += '</div>'
					html += '</ul>'
					html += "</div>"
				
			$("#locListArea").html(html);
			
		}
		,error : function(e){
			console.log('실패')
		}
	})
	
}

</script>    

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />
<div class="qna" style="width: 1100px;">


<h4><strong>판매자 판매정보 관리</strong></h4>
<hr>

<div class="right-block">
	<div class="" style="width: 125px; float: left;">
		<select class="form-control" style="width: 120px;" name="condition" id="condition" >
			<option value="zone">호선</option>
			<option value="station">판매장소</option>
			<option value="sellerId">판매자</option>
		</select>
	</div>
	<div class="" style="width: 185px; float: left;">
		<input class="form-control form-inline" style="width: 180px;" type="search" name="searchWord" value="${searchWord }" id="searchWord">
	</div>
	<div class="" style="float: left;">
		<input class="form-inline btn btn-default" type="button" onclick="searchSeller()" value="찾기">
	
	</div>
	<div class="text-right" style="margin-bottom: 5px;">
		<input class="btn btn-default" type="button" value="처음으로" onclick="goBack()" style="margin-right: 25px;">
	</div>

		
		<!-- 스크립트로 html들어가는 영역  -->
		<div id="locListArea">
		<div class="centered">
		<img class="item"src="/upload/loading.gif" style="width: 180px; height: 180px;">
		</div>

		
		
		</div>    
</div>    





</div>


