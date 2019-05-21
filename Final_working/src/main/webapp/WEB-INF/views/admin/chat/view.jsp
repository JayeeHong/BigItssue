<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.2.4.min.js"></script>

<style>
	li {
		list-style: none;
	}
	
	.btnBack {
		position: fixed;
		right: 0;
		margin-right: 32px;
	}
	
	.buyer {
		background: white;
	}
</style>


<script type="text/javascript">
var chkNo = null;
var chkRoomNo = <%=request.getParameter("chatRoomNo") %>
console.log(chkRoomNo);

var isEnd = false;

$(window).scroll(function() {
//		console.log($(window).scrollTop()+", "+$(document).height()+", "+$(window).height());
	if (Math.ceil($(window).scrollTop()) >= $(document).height() - $(window).height()) {
		fetchMessage();
	}
});

var fetchMessage = function() {
	if(isEnd == true) {
		return;
	}
	
	chkNo = $("#chk li:last").attr("data-chatmessageno") || 0;
	console.log(chkNo);
	
	$.ajax({
		url: "/admin/chat/view",
		type: "POST",
		data: {"chatRoomNo": chkRoomNo, "chatMessageNo": chkNo},
		success: function(result) {
			for(var i=0; i<result.list.length; i++) {
				if(result.list[i].chatSender.indexOf("buyer") == 0) {
					var d = result.list[i].chatDate;
					
					var date = new Date();
					
					//년, 월, 일
					date.setTime(d);
					var dateArr = date.toISOString().split("T");
					//console.log(dateArr[0]);
					
					var dateTimeArr = date.toString().split(" ");
					//console.log(dateTimeArr[4]);
					
					$("#chk li:last").append("<li data-chatMessageNo='"+result.list[i].chatMessageNo+"'><pre id='chatMessage' class='buyer'>"+result.list[i].chatSender+" : "+result.list[i].chatContent+"	"+"<p style='float: right; margin: 0;' align='right'>"+dateArr[0]+" "+dateTimeArr[4]+"</p></pre></li>");
					
				} else if(result.list[i].chatSender.indexOf("seller") == 0 || result.list[i].chatSender.indexOf("bigdom") == 0) {
					var d = result.list[i].chatDate;
					
					var date = new Date();
					
					//년, 월, 일
					date.setTime(d);
					var dateArr = date.toISOString().split("T");
					//console.log(dateArr[0]);
					
					var dateTimeArr = date.toString().split(" ");
					//console.log(dateTimeArr[4]);
					
					$("#chk li:last").append("<li data-chatMessageNo='"+result.list[i].chatMessageNo+"'><pre id='chatMessage'>"+result.list[i].chatSender+" : "+result.list[i].chatContent+"	"+"<p style='float: right; margin: 0;' align='right'>"+dateArr[0]+" "+dateTimeArr[4]+"</p></pre></li>");
					
				}
			}
			//$("#enter").append("<h3>하이요!<h3><br>");
		},
		error: function(jqXHR, textStatus, errorThrown) {
			alert("에러 발생함");
		}
	});
}
</script>

<div id="enter">
<form class="btnBack">
	<input type="button" class="btn btn-sm btn-primary" value="이전" onClick="history.go(-1);"/>
</form>
<ul id="chk">
<c:forEach var="item" items="${message}">
	<c:if test="${fn:contains(item.chatSender, 'buyer') }">
		<li data-chatMessageNo="${item.chatMessageNo }"><pre id="chatMessage" class="buyer" >${item.chatSender } : ${item.chatContent }		<p style="float: right; margin: 0;" align="right"><fmt:formatDate value="${item.chatDate }" pattern="yyyy-MM-dd HH:mm:ss"/></p></pre></li>
	</c:if>
	<c:if test="${fn:contains(item.chatSender, 'seller') || fn:contains(item.chatSender, 'bigdom') }">
		<li data-chatMessageNo="${item.chatMessageNo }"><pre id="chatMessage" >${item.chatSender } : ${item.chatContent }		<p style="float: right; margin: 0;" align="right"><fmt:formatDate value="${item.chatDate }" pattern="yyyy-MM-dd HH:mm:ss"/></p></pre></li>
	</c:if>
</c:forEach>
</ul>

</div>