<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
.table {
	margin: 10px;
	width: 100%;
	vertical-align: middle;
}

.table tr td:first-child {
	text-align: center;
	background: #cccccc4d;
}

.table tr td select {
	height: 26px;
}

.table>tbody>tr>td {
	vertical-align: middle;
}

.table>thead>tr>td {
	vertical-align: middle;
}

.sellerInfo tr td {
	height: 70px;
}

/* input file 디자인 테스트 */
.filebox label { 
	display: inline-block; 
	padding: .5em .75em; 
	color: #999; 
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #e8e8e8; 
	cursor: pointer; 
	border: 0px; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em;
	width: 143.36px;
	text-align: center;
	margin: auto 0; 
}

.filebox input[type="file"] { /* 파일 필드 숨기기 */ 
 	position: absolute;  
 	width: 1px;  
 	height: 1px;  
 	padding: 0;  
	margin: -1px;  
 	overflow: hidden;  
 	clip:rect(0,0,0,0); 
 	border: 0;  
}

/* named upload */
.filebox .upload-name {
	display: inline-block;
	paddimg: .5em .75em; /* label의 패딩값과 일치 */
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none; /* native 외형 감추기 */
	-moz0apperarance: none;
	appearance: none;
}

/* image preview */
.filebox .upload-display { /* 이미지가 표시될 지역 */
	margin-bottom: 5px;
}

@media(min-width: 768px) {
	.filebox .upload-display {
		display: inline-block;
		margin-right: 5px;
		margin-bottom: 0;
	}
}

.filebox .upload-thumb-wrap { /* 추가될 이미지를 감싸는 요소 */
	display: inline-block;
	width: 150px; /* 이미지 크기 변경시 이 값 수정 */
	padding: 2px;
	margin-left: 30px;
	margin-right: 30px;
	margin-bottom: 5px;
	vertical-align: middle;
	border: 0px;
	border-radius: 5px;
	background-color: #fff;
}

.filebox .upload-display img { /* 추가될 이미지 */
	display: block;
	max-width: 100%;
/* 	width: 100% \9; */
 	height: 150px;
 	margin: 0px auto; 
}

#deleteImg {
	display: inline-block; 
	padding: .5em .75em; 
	color: #999; 
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #e8e8e8; 
	cursor: pointer; 
	border: 0px; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em;
	text-align: center;
	margin: auto 0; 
	font-weight: bold;
}

</style>

<script type="text/javascript">

// -------- input file 디자인 테스트 --------
/*
$.fn.setPreview = function(opt){
    "use strict"
    var defaultOpt = {
        inputFile: $(this),
        img: null,
        w: 200,
        h: 200
    };
    $.extend(defaultOpt, opt);
 
    var previewImage = function(){
        if (!defaultOpt.inputFile || !defaultOpt.img) return;
 
        var inputFile = defaultOpt.inputFile.get(0);
        var img       = defaultOpt.img.get(0);
 
        // FileReader
        if (window.FileReader) {
            // image 파일만
            if (!inputFile.files[0].type.match(/image\//)) return;
 
            // preview
            try {
                var reader = new FileReader();
                reader.onload = function(e){
                    img.src = e.target.result;
                    img.style.width  = defaultOpt.w+'px';
                    img.style.height = defaultOpt.h+'px';
                    img.style.display = '';
                }
                reader.readAsDataURL(inputFile.files[0]);
            } catch (e) {
                // exception...
            }
        // img.filters (MSIE)
        } else if (img.filters) {
            inputFile.select();
            inputFile.blur();
            var imgSrc = document.selection.createRange().text;
 
            img.style.width  = defaultOpt.w+'px';
            img.style.height = defaultOpt.h+'px';
            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";           
            img.style.display = '';
        // no support
        } else {
            // Safari5, ...
        }
    };
 
    // onchange
    $(this).change(function(){
        previewImage();
    });
};
*/

// -------------------------------------------

$(document).ready(function() {
	
	// ----- input file 디자인 테스트 -----
/*
	var opt = {
        img: $('#img_preview'),
        w: 200,
        h: 200
    };
 
    $('#input-file').setPreview(opt);
*/
	
	var fileTarget = $('.filebox .upload-hidden'); 
	fileTarget.on('change', function() { // 값이 변경되면 
		
		if(window.FileReader){ // modern browser 
			var filename = $(this)[0].files[0].name; 
		
		} else { // old IE 
			var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
		
		} // 추출한 파일명 삽입 
		
		$(this).siblings('.upload-name').val(filename); 
		
	});

	var imgTarget = $('.preview-image .upload-hidden'); 
	
	imgTarget.on('change', function() {
		var parent = $(this).parent(); 
		parent.children('.upload-display').remove(); 
		
		if(window.FileReader){ //image 파일만 
			if (!$(this)[0].files[0].type.match(/image\//)) return; 
		
			var reader = new FileReader(); 
			reader.onload = function(e){ 
				var src = e.target.result; 
// 				parent.prepend('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb" name="sellerImg"></div></div>'); 
				$("#imgUp_area").html('<img src="'+src+'" class="upload-thumb" name="sellerImg">');
			}
			
			reader.readAsDataURL($(this)[0].files[0]); 
		
		} else {
			$(this)[0].select(); 
			$(this)[0].blur(); 
			var imgSrc = document.selection.createRange().text; 
			parent.html('<img class="upload-thumb" name="sellerImg">'); 
			
			var img = $(this).siblings('.upload-display').find('img'); 
			img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")"; 
			
		}
		
	});

	//출처: https://webdir.tistory.com/435 [WEBDIR]
	
	// ------------------------------------

	
	$("select option[value=${sbList.sellerPhone1 }]").attr("selected","selected");
	
// 	$("#imgUp").click(function() {
		
// 		$.ajax({
// 			type: "post"
// 			, url: "/admin/info/seller/imgUp"
// 			, data: {"sellerinfo": sellerinfo}
// 			, dataType: "json"
// 			, success: function(res) {
// 				console.log("성공");
// 				console.log(res);
// 			}
// 			, error: function(e) {
// 				console.log("실패");
// 				console.log(e);
// 			}
// 		});
		
// 	});
});

function deleteImage() { // 사진 삭제 버튼
// 	console.log('ㅁㄴㅇㅁㄴㅇ');
	$('.filebox .upload-hidden2').value=''; // 파일명 위치 값 지우기
	$('#imgUp_area2').html('사진이 없습니다.<br>사진을 등록해주세요.'); // 이미지 위치에 사진없음으로 표시
}

function inNumber(){
	if(event.keyCode<48 || event.keyCode>57){
		event.returnValue=false;
	}
}



// function delBigdom(bigdomId) {
// 	result=confirm('빅돔 정보를 삭제하시겠습니까?');
	
// 	if(result==true) {
// 		form = document.upForm;
// 		form.action="/admin/info/bigdomDel?bigdomId="+bigdomId;
// 		form.submit();
// 	} else {
// 		return false;
// 	}
// }

function toList() {
	form = document.upForm;
	form.method="post";
	form.action="/admin/info/seller";
	form.submit();
}

// function imgUp(sellerId) {
// 	form = document.upForm;
// 	form.method="post";
// 	form.action="/admin/info/seller/imgUp";
// 	form.submit();
// }

function upSeller(sellerId) {
	
	if(true) {
		if(!document.upForm.sellerPhone2.value) {
			alert("전화번호를 입력하세요!");
			return false;
		}
		if(!document.upForm.sellerPhone3.value) {
			alert("전화번호를 입력하세요!");
			return false;
		}
	}
	
	result = confirm('판매자 정보를 변경하시겠습니까?');
	
	if(result==true) {
		form = document.upForm;
		form.method="post";
		form.enctype="multipart/form-data";
		form.action="/admin/info/sellerUp?sellerId="+sellerId;
		form.submit();
// 		$(location).attr("href", "/admin/info/sellerUp?sellerId="+sellerId);
	} else {
		return false;
	}
}

function deactivateSeller(sellerId) {
	result = confirm('판매자를 비활성화하시겠습니까?');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/info/deactivateSeller?sellerId="+sellerId;
		form.submit();
	} else {
		return false;
	}
}

function activateSeller(sellerId) {
	result = confirm('판매자를 활성화하시겠습니까?'+'\n'
			+'확인을 클릭하시면 판매장소관리 페이지로 넘어갑니다.');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/loc/list";
		form.submit();
	} else {
		return false;
	}
}

function deactivateBigdom(bigdomId) {
	result = confirm('빅돔을 비활성화하시겠습니까?');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/info/deactivateBigdom?bigdomId="+bigdomId;
		form.submit();
	} else {
		return false;
	}
}

function activateBigdom(bigdomId) {
	result = confirm('빅돔을 활성화하시겠습니까?');
	
	if(result==true) {
		form = document.upForm;
		form.action="/admin/info/activateBigdom?bigdomId="+bigdomId;
		form.submit();
	} else {
		return false;
	}
}

</script>

<div class="row row-offcanvas row-offcanvas-right">

<jsp:include page="/WEB-INF/tiles/layout/sidebar_admin.jsp" />

<div class="col-xs-12 col-sm-9">

<h3>판매자 계정 수정</h3>
<hr>

<c:if test="${not sellerStatus }">
해당 판매자는 비활성화 상태입니다.
</c:if>

<form name="upForm">
<input type="hidden" name="sellerId" value="${sbList.sellerId }"/>
<input type="hidden" name="bigdomId" value="${sbList.bigdomId }"/>
<table class="table table-bordered sellerInfo">

<tr>
	<td style="width: 35%; height: 70px;">판매자 이름</td>
	<td style="width: 40%;"><input style="width: 100px;" type="text" value="${sbList.sellerName }" name="sellerName" /></td>
	<td style="width: 25%; padding: 0px;" rowspan="3">
<!-- 		<div style="height: 90px; text-align: center;"> -->
<%-- 			<img id="sellerImg" style="width: 90px; height: 90px;" name="sellerImg" src="${sellerinfo.sellerImg }"/> --%>
<!-- 		</div> -->
<!-- 		<div style="text-align: center;"> -->
<!-- 			<button style="width: 90px; border-style: solid;">사진 수정</button> -->
<%-- 			<input type="file" id="imgUp" style="width: 125.6px; background-color: #e8e8e8; border:0px;" onclick="imgUp('${sbList.sellerId }')" /> --%>
<!-- 		</div> -->
		<!-- input file 디자인 테스트 -->
		
		<div class="filebox preview-image"> 
			<c:if test="${sbList.sellerImg eq null }">
				<div style="text-align: center;" class="upload-display">
					<div style="width: 150px; height: 150px;" class="upload-thumb-wrap" id="imgUp_area">
							사진이 없습니다.<br>사진을 등록해주세요.
					</div>
	<!-- 			<img id="img_preview" style="display:none;"/> -->
				<label for="file">사진 편집</label>
				<input type="file" id="file" name="file" class="upload-hidden" accept="image/*" />
				</div>
			</c:if>
					
			<c:if test="${sbList.sellerImg ne null }">
				<div style="text-align: center;" class="upload-display">
					<div style="width: 150px; height: 150px;" class="upload-thumb-wrap" id="imgUp_area2">
						<img class="upload-thumb" name="sellerImg" src="/upload/${sbList.sellerImg }" />
					</div>	
				<button type="button" id="deleteImg" onclick="deleteImage();" style="width: 81px;">사진 삭제</button>
				<label style="width: 81px;" for="file">사진 편집</label>
				<input type="file" id="file" name="file" class="upload-hidden2" accept="image/*" />
				</div>
			</c:if>
		</div>


	</td>
</tr>

<tr>
	<td>아이디</td>
	<td>${sbList.sellerId }</td>
</tr>

<tr>
	<td>비밀번호</td>
	<td><input style="width: 100px;" type="text" value="${sbList.sellerPw }" name="sellerPw" /></td>
</tr>


<tr>
	<td>연락처</td>
	<td colspan="2">
		<c:if test="${sbList.sellerPhone ne null }">
		<select name="sellerPhone1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="02">02</option>
			<option value="031">031</option>
		</select>
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="${sbList.sellerPhone2 }" name="sellerPhone2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="${sbList.sellerPhone3 }" name="sellerPhone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		</c:if>
		
		<c:if test="${sbList.sellerPhone eq null }">
		<select name="sellerPhone1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="017">017</option>
			<option value="02">02</option>
			<option value="031">031</option>
		</select>
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="" name="sellerPhone2" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		&nbsp;-&nbsp;
		<input style="width: 40px; text-align: center;" type="text" maxlength="4" value="" name="sellerPhone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" />
		</c:if>
	</td>
</tr>

</table>

<table class="table table-bordered">

<tr>
	<td colspan="2">
	판매자와 연동된 빅돔<br>
	<small>*빅돔은 판매자가 활성화 상태인 경우에만 활성화/비활성화가 가능합니다.</small>
	</td>
</tr>

<tr>
	<td width="20%" style="text-align: center; background: none;">
	${sbList.bigdomId }&nbsp;&nbsp;&nbsp;
<%-- 	<button class="btn btn-xs btn-danger" onclick="delBigdom('${sbList.bigdomId }');">삭제</button> --%>
	<c:if test="${sellerStatus }">
		<c:if test="${not bigdomStatus }">
		<button type="button" class="btn btn-xs btn-success" onclick="activateBigdom('${sbList.bigdomId}');">활성화</button>
		</c:if>
		<c:if test="${bigdomStatus }">
		<button type="button" class="btn btn-xs btn-danger" onclick="deactivateBigdom('${sbList.bigdomId}');">비활성화</button>
		</c:if>
	</c:if>
	
	</td>
</tr>

</table>
<br><br>
<div style="text-align: center;">
<button type="button" class="btn btn-default" onclick="toList();">목록</button>
<button type="button" class="btn btn-primary" onclick="upSeller('${sbList.sellerId}');">수정</button>

<c:if test="${not sellerStatus }">
<button type="button" class="btn btn-success" onclick="activateSeller('${sbList.sellerId}');">활성화</button>
</c:if>
<c:if test="${sellerStatus }">
<button type="button" class="btn btn-danger" onclick="deactivateSeller('${sbList.sellerId}');">비활성화</button>
</c:if>

</div>
</form>

</div>
</div>