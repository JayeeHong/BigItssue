<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
$(document).ready(function() {
	$('#Mcarousel').carousel('cycle');
});
</script>


<style type="text/css">
.carousel-inner,
.img {
  width: 100%;
  height: 638.469px;
  background-size: cover;
}
</style>

<div class="mainBanner" style="margin-bottom: 50px;">

	<div id="Mcarousel" class="carousel slide" data-ride="carousel">
	  <!-- Indicators -->
	  <ol class="carousel-indicators">
<!-- 	    <li data-target="#Mcarousel" data-slide-to="0" class="active"></li> -->
<!-- 	    <li data-target="#Mcarousel" data-slide-to="1"></li> -->
<!-- 	    <li data-target="#Mcarousel" data-slide-to="2"></li> -->
	    
	    <c:forEach var="i" begin="0" end="${mainBannerList.size()-1 }">
			<c:if test="${i eq 0 }">
   			<li data-target="#Mcarousel" data-slide-to="${i }" class="active"></li>
			</c:if>
			<c:if test="${i ne 0 }">
   			<li data-target="#Mcarousel" data-slide-to="${i }" class=""></li>
   			</c:if>
		</c:forEach>
	    
	    
	    
	    
	  </ol>

	  <!-- Wrapper for slides -->
	  <div class="carousel-inner" role="listbox">
<!-- 	    <div class="item active"> -->
<!-- 	      <img src="//bigissue.kr/wp-content/uploads/2019/04/홈페이지202호_대지-1.jpg"> -->
<!-- 	    </div> -->
<!-- 	    <div class="item"> -->
<!-- 	      <img src="//bigissue.kr/wp-content/uploads/2019/04/홈페이지201호_대지-1.jpg"> -->
<!-- 	    </div> -->
<!-- 	    <div class="item"> -->
<!-- 	      <img src="//bigissue.kr/wp-content/uploads/2019/04/홈페이지200호A형-29_대지-1.jpg"> -->
<!-- 	    </div> -->
	    
	    
	    <c:forEach var="i" begin="0" end="${mainBannerList.size()-1 }">
	  		<c:if test="${i eq 0 }">
	    	<div class="item active">
	      		<img src="/upload/${mainBannerList[i].bannerImg }">
	    	</div>
	    	</c:if>
	    	<c:if test="${i ne 0 }">
	    	<div class="item">
	      		<img src="/upload/${mainBannerList[i].bannerImg }">
	    	</div>
	    	</c:if>
		</c:forEach>
	    
	    
	  </div>
	
	  <!-- Controls -->
	  <a class="left carousel-control" href="#Mcarousel" role="button" data-slide="prev">
	    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	    <span class="sr-only">Previous</span>
	  </a>
	  <a class="right carousel-control" href="#Mcarousel" role="button" data-slide="next">
	    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	    <span class="sr-only">Next</span>
	  </a>
	</div>

</div>