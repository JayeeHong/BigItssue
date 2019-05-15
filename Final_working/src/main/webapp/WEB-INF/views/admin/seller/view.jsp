<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
var arr = new Array();//값을 담는 배열
var value;//변경된 값을 저장하는 변수

$(document).ready(function(){
	
	var locNo = ${sellerInfo.locNo }
	var zone = '${sellerInfo.zone }'
	var station = '${sellerInfo.station }'
	var spot = '${sellerInfo.spot }'
	var sellerTimeS1 = '${sellerInfo.sellerTimeS.substring(0, 2) }'
	var sellerTimeS2 = '${sellerInfo.sellerTimeS.substring(2, 4) }'
	var sellerTimeE1 = '${sellerInfo.sellerTimeE.substring(0, 2) }'
	var sellerTimeE2 = '${sellerInfo.sellerTimeE.substring(2, 4) }'
	var sellerCard = '${sellerInfo.sellerCard }'
	
	
	var spothtml;
	
	//시작시
	if(zone=='부산'){
		$('input:radio[name="bigArea"][value="부산"]').prop('checked', true);
		$("#divSearch").hide()
	}else{
		$('input:radio[name="bigArea"][value="서울"]').prop('checked', true);
		$("#divSearch").show()
	}
	
	
	
	
	
	var zoneSub = zone.split('/')
	var getCheck= RegExp(/^[0-9]$/);
	
	for(var i=0 in zoneSub){
		if(getCheck.test(zoneSub[i])){
			arr.push(zoneSub[i]+'호선')//숫자만 넘어올 경우 '호선'을 붙여 배열에 저장
		}else{
			arr.push(zoneSub[i]) //숫자가 아닐경우 배열에 바로 저장
		}
	}
// 	arr.push(zone);//DB값을 배열에 담는다.
	
	add()//버튼 생성펑션을 실행한다.
	
	if(sellerCard =='카드 가능'){
		$('input:radio[name="sellerCard"][value="카드 가능"]').prop('checked', true);
	}else{
		$('input:radio[name="sellerCard"][value="카드 불가능"]').prop('checked', true);
		
	}
	
	$("#locNo").val(locNo)
	
	$("#station").val(station)
	$("#spot").val(spot)

	$("#startTime1").val(sellerTimeS1);
	$("#startTime2").val(sellerTimeS2);
	
	$("#endTime1").val(sellerTimeE1);
	$("#endTime2").val(sellerTimeE2);
	
	

	$('input[name="bigArea"]').change(function(){
		if(this.value == '서울'){
			$("#divSearch").show()
			$("#station").val()
			arr.splice(0)
			add()
		}else{
			$("#divSearch").hide()
			$("#station").val()
			arr.splice(0)
			value='부산'
			arr.push(value)
			add()
		}
	})
	

	
	$("#sellerId").click(function(){
		var openWin;
		var url= "/admin/seller/select";    //팝업창 페이지 URL
		var winWidth = 550;
	   	var winHeight = 550;

	    var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
		openWin = window.open(url,"사용자선택",popupOption);
	    
	})
	
	
	//지도 팝업
	$("#spot").click(function() {
		var openMap;
		var station = $("#station").val();
		var spot = $("#spot").val();
		
		var url = "/revSpot?station="+station+"&spot="+spot; //지도는 header, footer 필요없음
		var w = (screen.availWidth)/3;
		var h = (screen.availHeight)/2.5;
		
		var popupOption = "width="+w+", height="+h;
		openMap = window.open(url, "변경될 출구를 찾을 지도", popupOption);
		
	})
	
	
})


function changeSpotSelect(a){
	value = a//변경된 값을 value라는 변수에 넣는다.
}

//추가버튼을 클릭하였을때
function addZone(){
	//배열에 value에 담긴 변수를 넣는다.
	arr.push(value)
	//버튼생성펑션을 실행한다.
	add()
}

//버튼 생성 펑션
function add(){
	var html =""
	for(var i=0; i< arr.length; i++){
		html += '<input class="form control" style="margin-right:3px; border:none; background:white; width:40px;"type="text" value="'+arr[i]+'" disabled/>'
		html += '<input class="btn btn-xs btn-danger" style="; width:30px; padding:0px; border:0px;" "type="button" value="삭제" onclick="arrDelete('+i+')">'
		html += '&nbsp;'
	}
	
	$("#addZone").html(html);
	$("#arrZone").val(arr)//submit을 위해 zone데이터를 value로 저장함
}

//버튼 삭제펑션
function arrDelete(i){
	arr.splice(i, 1)//배열에 담겨있는 i번째인덱스 값 1개를 지운다.
	add()//삭제후 버튼생성펑션을 실행하여 버튼을 다시만든다.
}


function arrAllDelete(){
	arr.splice(0);//배열에 담겨있는 모든 요소를 삭제한다.
	add()//삭제후 버튼생성펑션을 실행한다.
}


function subwayList(){
	arr.splice(0)
	$.ajax({
		url : "/admin/seller/searchzone"
		,type : "post"
		,data : {searchWord : $("#searchWord").val()}
		,dataType : "json"
		,success : function(res){
			
			console.log(Object.keys(res.zoneList).length)
			
			var a = Object.keys(res.zoneList)
			
			$("#station").val($("#searchWord").val());
			
			var list = res.zoneList
			var getCheck= RegExp(/^[0-9]$/);
			
			$.each(list, function(index, val){
				console.log(val)
				if(getCheck.test(val)){
				arr.push(val+'호선')
				}else{
					arr.push(val)
				}
			})
			
			add();
		}
		, error : function(e){
			console.log(e)
		}
	})
}

function btnCc(){
	window.location.href="/admin/seller/list"
}

</script>
    
<style>

.tdLeft{
	background: #cccccc6e;
	text-align: center;
	font-weight: bold;
	width : 100px;
}

.tdRight{
	width : 400px;
}


input[type=number]{
	width : 100px;
}

</style>    


<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<!-- <div class="" style=" width:1200px;" > -->
<div class="col-xs-12 col-sm-9">

<h4><strong>판매자 판매정보 수정</strong></h4>
<hr>
<!-- 	<div class="container-center" style="float:left; width:70%;" > -->
	<form class="form-inline" action="/admin/seller/view" method="post">
		<input type="hidden" name="locNo" id="locNo" value="">
		<table class="table table-bordered">
		<tr>
			<td style="vertical-align: middle;" class="tdLeft" >지역</td>
			<td class="tdRight" colspan="3">
				<label class="radio-inline" id="sellerArea">
				<input type="radio" name="bigArea" value="서울">서울/경기
				</label>
				<label class="radio-inline">
				<input type="radio" name="bigArea" value="부산">부산
				</label>
			</td>
<!-- 			<td style="border-bottom: hidden;border-top: hidden;border-right: hidden;">&nbsp;</td> -->
		</tr>
		
		<tr>
			<td style="vertical-align: middle;" class="tdLeft">호선</td>
			<td class="tdRight" colspan="3">
			<div id="divSearch">
			<input type="search" name="searchWord" id="searchWord"><input type="button" onclick="subwayList()" value="찾기">
			</div>
			<div id="stationInfo"><!-- selet타입의 호선선택이 들어오는 영역 -->
			
			</div>
			
			<div id="addZone"><!-- 추가한 버튼이 들어오는 영역 -->
			</div>
			</td>
			
		</tr>
	
		<tr>
			<td style="vertical-align: middle;" class="tdLeft">판매장소</td>
			<td class="tdRight" colspan="3">
			<input class="form-control" type="text" id="station" name="station">
			</td>
			
		</tr>
	
		<tr>
			<td style="vertical-align: middle;" class="tdLeft">출구(위치)</td>
			
			<td class="tdRight"><div id="spotInfo">
			<input class="form-control" type="text" id="spot" name="spot"placeholder="직접입력">
			</div></td>
			<td class="tdLeft" style="display:none">좌표</td>
			<td class="tdRight" style="display:none"><div id="LatLng">
			<input class="form-control" type="text" id="lat" name="lat" value="${sellerInfo.lat }">
			<input class="form-control" type="text" id="lng" name="lng" value="${sellerInfo.lng }">
			</div>
		</tr>
		
		<tr>
			<td style="vertical-align: middle;" class="tdLeft">카드결제여부</td>
			<td class="tdRight" colspan="3">
			<label class="radio-inline">
			<input type="radio" name="sellerCard" value="카드 가능">카드 가능
			</label>
			<label class="checkbox-inline">
			<input type="radio" name="sellerCard" value="카드 불가능">카드 불가능
			</label>
			</td>
			
		</tr>
		
		<tr>
			<td style="vertical-align: middle;" class="tdLeft">판매시간</td>
			<td class="tdRight" colspan="3">
				<div class="form-group">
				<input class="form-control" style="width:75px;" type="number" name="startTime1" id="startTime1"><b> :</b>
				<input class="form-control" style="width:75px;" type="number" name="startTime2" id="startTime2"><b> ~</b>
				<input class="form-control" style="width:75px;" type="number" name="endTime1" id="endTime1"><b> :</b>
				<input class="form-control" style="width:75px;" type="number" name="endTime2" id="endTime2">
				</div>
			</td>
			
		</tr>
		
		<tr>
			<td style="vertical-align: middle;" class="tdLeft">판매자ID</td>
			<td class="tdRight" colspan="3">
			<input class="form-control" type="text" id="sellerId" name="sellerId" value="${sellerInfo.sellerId }" >
			</td>
			
		</tr>
		
		
		
		
		
		</table>
		<div class="" style="text-align: center;">
<!-- 		<input class="btn" style="background:#e0effd;" type="submit" value="수정"> -->
<!-- 		<button class="btn" style="background:#ff8a8a;" type="button" onclick="btnCc()">취소</button> -->
		<button class="btn btn-default" type="button" onclick="btnCc()">취소</button>
		<input class="btn btn-primary" type="submit" value="수정">
		</div>
		
		<input type="hidden" id="arrZone" name="arrZone"> <!-- 배열로 만들어진 zone을 보내기 위한 input type히든 건들지마시오 -->
<%-- 		<input type="hidden" id="sellerId" name="sellerId" value="${sellerInfo.sellerId }"> --%>
	</form>
	
</div>
<!-- 	</div> -->

<!-- </div> -->

