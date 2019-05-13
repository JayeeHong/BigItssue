<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
$(document).ready(function() {
	$('#Mcarousel').carousel('cycle');
});
</script>


<style type="text/css">
.carousel-inner {
  width: 100%;
  height: 460px;
/*   background-size: contain; */
}

.bannerImg { 
  width: 100%;
  height: 460px; 
}

</style>

<div class="mainBanner" style="margin-bottom: 50px;">

	<div id="Mcarousel" class="carousel slide" data-ride="carousel">
	  
	  <!-- Indicators -->
	  <ol class="carousel-indicators">
	    
	    <c:forEach var="i" begin="0" end="${mainBannerList.size()-1 }">
			<c:if test="${i eq 0 }">
   			<li data-target="#Mcarousel" data-slide-to="${i }" class="active"></li>
			</c:if>
			<c:if test="${i ne 0 }">
   			<li data-target="#Mcarousel" data-slide-to="${i }"></li>
   			</c:if>
		</c:forEach>
	    
	  </ol>



	  <!-- Wrapper for slides -->
	  <div class="carousel-inner" role="listbox">
	    
	    <c:forEach var="i" begin="0" end="${mainBannerList.size()-1 }">
	  		<c:if test="${i eq 0 }">
	    	<div class="item active">
	      		<img class="bannerImg" src="/upload/${mainBannerList[i].bannerImg }">
	    	</div>
	    	</c:if>
	    	<c:if test="${i ne 0 }">
	    	<div class="item">
	      		<img class="bannerImg" src="/upload/${mainBannerList[i].bannerImg }">
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