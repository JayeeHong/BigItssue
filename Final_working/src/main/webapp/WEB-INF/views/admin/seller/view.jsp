<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h4>판매자정보</h4>
<div class="container-center">
<form class="form-inline">
	<table class="table table-bordered">
	<tr>
		<td class="tdLeft">지역</td>
		<td class="tdRight">
			<label class="radio-inline">
			<input type="radio" name="sellerArea">서울
			</label>
			<label class="radio-inline">
			<input type="radio" name="sellerArea">경기
			</label>
			<label class="radio-inline">
			<input type="radio" name="sellerArea">부산
			</label>
		</td>
	</tr>

	<tr>
		<td class="tdLeft">판매장소</td>
		<td class="tdRight">
		<select>
		<option>서울역</option>
		<option>요기역</option>
		</select>
		</td>
	</tr>

	<tr>
		<td class="tdLeft">출구(위치)</td>
		<td class="tdRight"><select>
			<option>9-1</option>
		</select>
		</td>
	</tr>
	
	<tr>
		<td class="tdLeft">카드결제여부</td>
		<td class="tdRight">
		<label class="checkbox-inline">
		<input type="radio" name="cardPossible">가능
		</label>
		<label class="checkbox-inline">
		<input type="radio" name="cardPossible">불가능
		</label>
		</td>
	</tr>
	
	<tr>
		<td class="tdLeft">판매시간</td>
		<td class="tdRight">
			<div class="form-group">
			<input class="form-control" style="width:75px;" type="number"><b> :</b>
			<input class="form-control" style="width:75px;" type="number"><b> ~</b>
			<input class="form-control" style="width:75px;" type="number"><b> :</b>
			<input class="form-control" style="width:75px;" type="number">
			</div>
		</td>
	</tr>
	
	<tr>
		<td class="tdLeft">판매자</td>
		<td class="tdRight">
		<input class="form-control" type="text">
		</td>
	</tr>
	
	
	</table>
	<div class="container container-center">
	<input class="btn btn-primary" type="submit" value="수정">
	<button class="btn btn-danger" type="button">취소</button>
	</div>
	
</form>

</div>

</div>

</div>