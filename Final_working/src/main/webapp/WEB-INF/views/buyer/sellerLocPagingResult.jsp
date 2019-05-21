<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<div style="text-align: center; margin-bottom:50px;">
<div style="padding: 10px;">
	<table class="table table-bordered">
		<thead style="background: #cccccc6e;">
		<tr>
		<th style="width: 10%;">장소(호선)</th>
		<th style="width: 40%">세부위치(지도)</th>
		<th style="width: 25%">판매시간</th>
		<th style="width: 25%">판매자</th>
	 	</tr>
		</thead>
		<tbody>
		<c:forEach var="item" items="${sellerLocList }" begin="0" end="${sellerLocList.size() }" step="1">
			<tr>
			<td>${item.zone }</td>
			<td>${item.station } ${item.spot }<button class="btn btn-success btn-sm fr" onclick="mapView(${item.locNo })">지도보기</button></td>
			<td>
				<c:if test="${item.sellerTimeS.length() eq 4 && item.sellerTimeE.length() eq 4 }">
				${item.sellerTimeS.substring( 0, 2 ) }:${item.sellerTimeS.substring( 2, 4 ) } ~ ${item.sellerTimeE.substring( 0, 2 )}:${item.sellerTimeE.substring( 2, 4 )} 
				</c:if>
				
				<c:if test="${item.sellerTimeS.length() eq 3 && item.sellerTimeE.length() eq 4 }">
				${item.sellerTimeS.substring( 0, 1 ) }:${item.sellerTimeS.substring( 1, 3 ) } ~ ${item.sellerTimeE.substring( 0, 2 )}:${item.sellerTimeE.substring( 2, 4 )} 
				</c:if>
				
				<c:if test="${item.sellerTimeS.length() eq 4 && item.sellerTimeE.length() eq 3 }">
				${item.sellerTimeS.substring( 0, 2 ) }:${item.sellerTimeS.substring( 2, 4 ) } ~ ${item.sellerTimeE.substring( 0, 1 )}:${item.sellerTimeE.substring( 1, 3 )} 
				</c:if>
				
				<c:if test="${item.sellerTimeS.length() eq 3 && item.sellerTimeE.length() eq 3 }">
				${item.sellerTimeS.substring( 0, 1 ) }:${item.sellerTimeS.substring( 1, 3 ) } ~ ${item.sellerTimeE.substring( 0, 1 )}:${item.sellerTimeE.substring( 1, 3 )} 
				</c:if>	
				
				<!-- sellerId가 null이 아닐때 -->
				<c:if test="${item.sellerId ne null }">
					<!-- 예약시간이 지나지 않았을 때 -->
					<c:if test="${item.sellerTimeE ge intNow }">
						<button class="btn btn-info btn-sm fr" onclick="booking(${item.locNo })">예약하기</button>
					</c:if>
					<!-- 예약시간이 지났을 떄 -->
					<c:if test="${item.sellerTimeE lt intNow }">		
						<button class="btn btn-info btn-sm fr" disabled>예약하기</button>
					</c:if>
				</c:if>
				<!-- sellerId가 null이 일때 -->
				<c:if test="${item.sellerId eq null }">
					<button class="btn btn-info btn-sm fr" disabled>예약하기</button>
				</c:if>
			</td>
			<!-- sellerId가 null이 아닐때 -->
			<c:if test="${item.sellerId ne null }">
				<!-- 예약시간이 지나지 않았을 때 -->
				<c:if test="${item.sellerTimeE ge intNow}">
					<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" onclick="inquire('${item.sellerId}','판매자')">문의하기</button></td>
				</c:if>
				<!-- 예약시간이 지났을 떄 -->
				<c:if test="${item.sellerTimeE lt intNow}">
					<td>${item.sellerId }<button class="btn btn-warning btn-sm fr" disabled>문의하기</button></td>
				</c:if>		
			</c:if>
			<!-- sellerId가 null이 일때 -->
			<c:if test="${item.sellerId eq null }">
				<td><button class="btn btn-warning btn-sm fr" disabled>문의하기</button></td>
			</c:if>
		
	</c:forEach>
	</tbody>
</table>

<!-- 페이징 -->
<jsp:include page="sellerLocPaging.jsp" />
<div id="pagingResult"></div>

</div> <!-- 판매처보기로 이동을 위한 div -->

</div>