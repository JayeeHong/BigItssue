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
	var magazineNo = ${sellerInfo.magazineNo }
	var sellerId = '${sellerInfo.sellerId }'
	var bigdomId = '${sellerInfo.bigdomId }'
	var spothtml;
	
	var zoneSub = zone.split('/')
	var getCheck= RegExp(/^[0-9]$/);
	for(var i=0 in zoneSub){
		if(getCheck.test(zoneSub[i])){
			arr.push(zoneSub[i]+'호선')
		}else{
			arr.push(zoneSub[i])
		}
	}
// 	arr.push(zone);//DB값을 배열에 담는다.
	
	
	
	add()//버튼 생성펑션을 실행한다.
	
	if(zone=='부산'){
	$('input:radio[name="bigArea"][value="부산"]').prop('checked', true);
	spothtml = "";	
	spothtml += '<select name="zone" onchange="changeSpotSelect(this.options[this.selectedIndex].value)">';
	spothtml += '<option value="부산">부산</option>';
	

	spothtml += '</select>';
	$("#stationInfo").html(spothtml)
	value='부산'//초기값세팅
		
	}else{
		$('input:radio[name="bigArea"][value="서울"]').prop('checked', true);	
		spothtml = "";	
		spothtml += '<select name="zone" onchange="changeSpotSelect(this.options[this.selectedIndex].value)">';
		spothtml += '<option value="1호선">1호선</option>';
		spothtml += '<option value="2호선">2호선</option>';
		spothtml += '<option value="3호선">3호선</option>';
		spothtml += '<option value="4호선">4호선</option>';
		spothtml += '<option value="5호선">5호선</option>';
		spothtml += '<option value="6호선">6호선</option>';
		spothtml += '<option value="7호선">7호선</option>';
		spothtml += '<option value="8호선">8호선</option>';
		spothtml += '<option value="9호선">9호선</option>';
		spothtml += '<option value="경의">경의중앙선</option>';
		spothtml += '<option value="분당">분당선</option>';
		spothtml += '<option value="신분당">신분당선</option>';
		spothtml += '<option value="공항">공항철도</option>';
		spothtml += '</select>';
		$("#stationInfo").html(spothtml)
		value='1호선'//초기값세팅
	}
	
	if(sellerCard =='카드 가능'){
		$('input:radio[name="sellerCard"][value="카드 가능"]').prop('checked', true);
	}else{
		$('input:radio[name="sellerCard"][value="카드 불가능"]').prop('checked', true);
		
	}
	
	$("#locNo").val(locNo)
	
	
	$("#station").val(station)
	$("#spot").val(spot)

	$('input[name="bigArea"]').change(function(){
		if(this.value == '서울'){
		spothtml = "";	
		spothtml += '<select name="zone" onchange="changeSpotSelect(this.options[this.selectedIndex].value)">';
		spothtml += '<option value="1호선">1호선</option>';
		spothtml += '<option value="2호선">2호선</option>';
		spothtml += '<option value="3호선">3호선</option>';
		spothtml += '<option value="4호선">4호선</option>';
		spothtml += '<option value="5호선">5호선</option>';
		spothtml += '<option value="6호선">6호선</option>';
		spothtml += '<option value="7호선">7호선</option>';
		spothtml += '<option value="8호선">8호선</option>';
		spothtml += '<option value="9호선">9호선</option>';
		spothtml += '<option value="경의">경의중앙선</option>';
		spothtml += '<option value="분당">분당선</option>';
		spothtml += '<option value="신분당">신분당선</option>';
		spothtml += '<option value="공항">공항철도</option>';
		spothtml += '</select>';
		value = '1호선' //초기값세팅
		}else{
			spothtml = "";	
			spothtml += '<select name="zone" onchange="changeSpotSelect(this.options[this.selectedIndex].value)">';
			spothtml += '<option value="부산">부산</option>';
			
	
			spothtml += '</select>';
			value='부산'//초기값세팅
		}
	$("#stationInfo").html(spothtml)
	})
		
	
	
	
	
	$("#startTime1").val(sellerTimeS1);
	$("#startTime2").val(sellerTimeS2);
	
	$("#endTime1").val(sellerTimeE1);
	$("#endTime2").val(sellerTimeE2);
	
	
	$("#sellerId").val(sellerId);
	
	
	
	

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
		html += '<input class="form control" style="border:none; width:40px;"type="text" value="'+arr[i]+'">'
		html += '<input class="btn btn-danger" "type="button" style="width:40px; height:25px; padding:0px; border:0px;" value="삭제" onclick="arrDelete('+i+')">'
		html += '&nbsp;'
	}
	
	$("#addZone").html(html);
	
}

//버튼 삭제펑션
function arrDelete(i){
	arr.splice(i, 1)//배열에 담겨있는 i번째인덱스 값 1개를 지운다.
	add()//삭제후 버튼생성펑션을 실행한다.
}


</script>
    
<style>

.tdLeft{
	background: #e6e4e4;
	text-align: center;
	width : 100px;
}

.tdRight{
	width : 400px;
}


input[type=number]{
	width : 100px;
}

</style>    


<div class="row row-offcanvas row-offcanvas-right" >


<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<h3>판매자정보 수정</h3>
	<div class="container-center" style="float:left; width:70%;" >
	<form class="form-inline" action="/admin/seller/view" method="post">
		<input type="hidden" name="locNo" id="locNo" value="">
		<table class="table table-bordered">
		<tr>
			<td class="tdLeft">지역</td>
			<td class="tdRight">
				<label class="radio-inline" id="sellerArea">
				<input type="radio" name="bigArea" value="서울">서울/경기
				</label>
				<label class="radio-inline">
				<input type="radio" name="bigArea" value="부산">부산
				</label>
			</td>
		</tr>
		
		<tr>
			<td class="tdLeft">호선</td>
			<td class="tdRight">
			<div id="stationInfo">
			
			</div>
			<input type="button" value="추가" onclick="addZone()" >
			<div id="addZone">
			</div>
			</td>
		
		</tr>
	
		<tr>
			<td class="tdLeft">판매장소</td>
			<td class="tdRight">
			<input type="text" id="station" name="station">
			</td>
		</tr>
	
		<tr>
			<td class="tdLeft">출구(위치)</td>
			
			<td class="tdRight"><div id="spotInfo">
			<input type="text" id="spot" name="spot"placeholder="직접입력">
			</div></td>
		</tr>
		
		<tr>
			<td class="tdLeft">카드결제여부</td>
			<td class="tdRight">
			<label class="radio-inline">
			<input type="radio" name="sellerCard" value="카드 가능">카드 가능
			</label>
			<label class="checkbox-inline">
			<input type="radio" name="sellerCard" value="카드 불가능">카드 불가능
			</label>
			</td>
		</tr>
		
		<tr>
			<td class="tdLeft">판매시간</td>
			<td class="tdRight">
				<div class="form-group">
				<input class="form-control" style="width:75px;" type="number" name="startTime1" id="startTime1"><b> :</b>
				<input class="form-control" style="width:75px;" type="number" name="startTime2" id="startTime2"><b> ~</b>
				<input class="form-control" style="width:75px;" type="number" name="endTime1" id="endTime1"><b> :</b>
				<input class="form-control" style="width:75px;" type="number" name="endTime2" id="endTime2">
				</div>
			</td>
		</tr>
		
		<tr>
			<td class="tdLeft">판매자</td>
			<td class="tdRight">
			<input class="form-control" type="text" id="sellerId">
			</td>
		</tr>
		
		
		
		
		
		</table>
		<div class="container container-center">
		<input class="btn btn-primary" type="submit" value="수정">
		<a href="/admin/seller/list"><button class="btn btn-danger" type="button">취소</button></a>
		</div>
		
	</form>
	
	</div>

</div>
