<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="sysdate" class="java.util.Date"/>


<script type="text/javascript">
$(document).ready(function(){
	getLocList();
})
var curPage = 0;

function getCurPage(a){
	curPage = a
	getLocList();
}


// function detailView(a){
// 	window.location.href="/admin/notice/view?noticeNo="+a
// }




function searchSeller(){
	curPage = 0;
	getLocList();
}


function getLocList(){
	
	$.ajax({
		url:"/admin/notice/getNoticeList"
		,type:"get"
		,data:{
			curPage : curPage
		}
		,dataType: "json"
		,success : function(res){
			console.log('성공');
			var list = res.notice;
			var p = res.paging;
			var spmpc = p.startPage - p.pageCount
			var cpm1 = p.curPage - 1
			var cpp1 = p.curPage + 1
			var spppc = p.startPage + p.pageCount
			
			console.log('${sysdate}');
			
			var html =""
				html ='<div id="tableAndpaging" style="height:400px;">'
				html += '<div class="row row-offcanvas" style="height:400px;">'
				html += '<table class="table table-striped" style="float:left;  width:75%;">'
				html += '<tr style="background: gray; text-align: center;">'
				html += '<td><b>No.</b></td>'
				html += '<td><b>제목</b></td>'
				html += '<td><b>날짜</b></td>'
				html += '<td><b>조회수</b></td>'
				html += '</tr>'
				$.each(list, function(index, value){
					var date = new Date(value.noticeDate);
					var now = new Date();
					
					console.log(now)
					
					html +='<tr style="text-align: center;">'
					html += '<td>'+value.noticeNo+'</td>'
					html += '<td class="goDetailView" onclick="goDetailView('+value.noticeNo+')">'
// 					html += '<a href="/admin/notice/view?noticeNo='+value.noticeNo+'">'
					
					html += value.noticeTitle
// 					html += '</a>'
					html += '</td>'
					
					
					html += '<td>'+date.getFullYear(2)+'-'
					if(date.getMonth()<10){
					html += 0	
					}
					html += date.getMonth()+'-'
					if(date.getDate()<10){
					html += 0
					}
					html += date.getDate()+'</td>'
					html += '<td>'+value.noticeHit+'</td>'
					html +='</tr>'
					
					
				})
					html += '</table>'
					html += '</div>'
					
					html += '<div class="text-center">'
					html += '<ul class="pagination pagination-sm">'
					if(p.curPage != 1){
// 					html +=	'<li><a href='+'"/admin/seller/list?curPage=1&condtion='+condition+'&searchWord='+searchWord+'">&larr;처음</a></li>'
					html += '<li><a onclick="getCurPage('+1+')">&larr;처음</a></li>'
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
					
					
					html += '</ul>'
					html += '</div>'
					html += "</div>"
			$("#noticeListArea").html(html);
			
		}
		,error : function(e){
			console.log('실패')
		}
	})
	
}

function noticeWrite(){
	window.location.href="/admin/notice/write"
	
}

function goDetailView(a){
	window.location.href="/admin/notice/view?noticeNo="+a
}

</script>    
<style>
.goDetailView:hover{
text-decoration: underline;
cursor: pointer;
}
a{
cursor: pointer;
}
</style>



<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="" style="width: 1000px;">
<div style="width:auto; position:static;  left:20%;">
<h3>공지사항 게시판 관리</h3>
<hr>
</div>
    
<div class="text-right">
<input type="button" class="btn btn info" value="글쓰기" onclick="noticeWrite()" style="maging-right:300px;">
<div id="noticeListArea">
	

</div>    
</div>    
</div>
    



