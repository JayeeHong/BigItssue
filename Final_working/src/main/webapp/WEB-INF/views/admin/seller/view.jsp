<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script type="text/javascript">
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
	
	
	if(zone=='부산'){
	$('input:radio[name="sellerArea"][value="부산"]').prop('checked', true);
		
	}else{
		$('input:radio[name="sellerArea"][value="서울"]').prop('checked', true);	
	}
	
	if(sellerCard =='카드 가능'){
		$('input:radio[name="cardPossible"][value="카드 가능"]').prop('checked', true);
	}else{
		$('input:radio[name="cardPossible"][value="카드 불가능"]').prop('checked', true);
		
	}
	
	
	var stationhtml ="";
		stationhtml += '<select>'
		stationhtml += '<option>${sellerInfo.station }</option>'
		stationhtml +='</select>'
	
	
	
	$("#stationInfo").html(stationhtml)
	
	var spothtml = "";
		spothtml += '<select>';
		spothtml += '<option>${sellerInfo.spot }</option>';
		spothtml += '</select>';
	
	
	$("#spotInfo").html(spothtml)
	
	
	
	$("#startTime1").val(sellerTimeS1);
	$("#startTime2").val(sellerTimeS2);
	
	$("#endTime1").val(sellerTimeE1);
	$("#endTime2").val(sellerTimeE2);
	
	
	$("#sellerName").val(sellerId);

})





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


<h4>판매자정보</h4>
<div class="container-center">
<form class="form-inline" action="/admin/seller/view" method="post">
	<table class="table table-bordered">
	<tr>
		<td class="tdLeft">지역</td>
		<td class="tdRight">
			<label class="radio-inline" id="sellerArea">
			<input type="radio" name="sellerArea" value="서울">서울/경기
			</label>
<!-- 			<label class="radio-inline"> -->
<!-- 			<input type="radio" name="sellerArea" value="경기">경기 -->
<!-- 			</label> -->
			<label class="radio-inline">
			<input type="radio" name="sellerArea" value="부산">부산
			</label>
		</td>
	</tr>

	<tr>
		<td class="tdLeft">판매장소</td>
		<td class="tdRight" id="stationInfo">
		<div>
		
		</div>
		</td>
	</tr>

	<tr>
		<td class="tdLeft">출구(위치)</td>
		
		<td class="tdRight"><div id="spotInfo"></div></td>
	</tr>
	
	<tr>
		<td class="tdLeft">카드결제여부</td>
		<td class="tdRight">
		<label class="radio-inline">
		<input type="radio" name="cardPossible" value="카드 가능">카드 가능
		</label>
		<label class="checkbox-inline">
		<input type="radio" name="cardPossible" value="카드 불가능">카드 불가능
		</label>
		</td>
	</tr>
	
	<tr>
		<td class="tdLeft">판매시간</td>
		<td class="tdRight">
			<div class="form-group">
			<input class="form-control" style="width:75px;" type="number" id="startTime1"><b> :</b>
			<input class="form-control" style="width:75px;" type="number" id="startTime2"><b> ~</b>
			<input class="form-control" style="width:75px;" type="number" id="endTime1"><b> :</b>
			<input class="form-control" style="width:75px;" type="number" id="endTime2">
			</div>
		</td>
	</tr>
	
	<tr>
		<td class="tdLeft">판매자</td>
		<td class="tdRight">
		<input class="form-control" type="text" id="sellerName">
		</td>
	</tr>
	
	
	</table>
	<div class="container container-center">
	<input class="btn btn-primary" type="submit" value="수정">
	<a href="/admin/seller/list"><button class="btn btn-danger" type="button">취소</button></a>
	</div>
	
</form>

</div>