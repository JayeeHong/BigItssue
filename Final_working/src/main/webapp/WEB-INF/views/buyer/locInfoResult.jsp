<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<select name="stationSelect" id="stationSelect" class="form-control" style="height: 30px; width:180px; margin-bottom: 6px; padding-top: 0px; padding-bottom: 0px;">
	
	<c:if test="${locList eq null }">
		      <option value="장소 없음">		
	</c:if>
	<c:if test="${locList ne null}">
		<option value="">장소를 선택하세요</option>
		<c:forEach items="${locList }" var="list">
			<option value="${list.station }">${list.station }</option>
		</c:forEach>
	</c:if>
		
</select>
<button class="btn btn-default" onclick="pagingFunc(0)">검색</button>