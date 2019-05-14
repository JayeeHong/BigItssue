<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/javascript">
var curPage = 0;
$(document).ready(function(){
	getNoticeList();
	
	$(".btn-xs").toggle(250);
})

function getCurPage(a){
	curPage = a;
	getNoticeList();
}

function getNoticeList(){
	$.ajax({
		url:"/buyer/notice/getNoticeList"
		,type:"get"
		,data:{
			curPage : curPage
		}
		,dataType: "json"
		,success : function(res){
			console.log('성공');
			var list = res.map.noticeList;
			var p = res.map.paging;
			var spmpc = p.startPage - p.pageCount
			var cpm1 = p.curPage - 1
			var cpp1 = p.curPage + 1
			var spppc = p.startPage + p.pageCount
			
			
			var html =""
				html ='<div id="tableAndpaging" style="height:400px;">'
				html += '<div class="row row-offcanvas" style="height:400px; width:1000px;">'
				html += '<table class="table table-striped">'
				html += '<tr style="background: gray; text-align: center;">'
				html += '<td><b>No.</b></td>'
				html += '<td><b>제목</b></td>'
				html += '<td><b>날짜</b></td>'
				html += '<td><b>조회수</b></td>'
				html += '</tr>'
				$.each(list, function(index, value){
					var date = new Date(value.noticeDate);
					var now = new Date();
					
					html +='<tr style="text-align: center;">'
					html += '<td>'+value.noticeNo+'</td>'
					html += '<td class="goDetailView" onclick="goDetailView('+value.noticeNo+')">'
					if(now.getTime()-value.noticeDate <= 24*60*60*1000){
					html += '<input type="button" class="btn btn-xs" value="new">&nbsp;'
					}
					html += value.noticeTitle
					html += '</td>'
					
				
					
					html += '<td>'+date.getFullYear(2)+'-'
					if(date.getMonth()<10){
					html += 0	
					}
					html += date.getMonth()+1+'-'
					if(date.getDate()+1<10){
					html += 0
					}
					html += date.getDate()+'</td>'
					html += '<td>'+value.noticeHit+'</td>'
					html +='</tr>'
					
					
				})
					html += '</table>'
					html += '</div>'
					
					html += '<div class="text-center" style="width:1000px;">'
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

function goDetailView(a){
	window.location.href="/buyer/notice/view?noticeNo="+a
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
.btn-xs{
background: none;
color: red;
}
.centered { display: table; margin-left: auto; margin-right: auto; }
</style>



<div class="container" style="width: 1100px; height:400px; margin-top: 100px; ">
	<div class="container" style="margin-bottom: 100px;">
		<div id="noticeListArea">
			<div class="centered">
			<img class="item"src="/upload/loading.gif" style="width: 180px; height: 180px;">
			</div>

		</div>
	
	</div>
</div>

