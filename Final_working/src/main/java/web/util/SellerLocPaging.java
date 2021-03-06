package web.util;

public class SellerLocPaging {
	private int curPage; //현재 페이지 번호 (선택한 페이지)
	
	private int totalCount; //총 게시글 수 (DB조회 결과로 얻어옴)
	private int listCount; //한 페이지당 출력될 게시글 수 (직접 설정함)
	private int totalPage; //총 페이지 수 (계산으로 알아냄)
	
	private int pageCount; //한 화면에 출력될 페이지 수 (직접 설정함)
	private int startPage; //화면에 보이는 시작 페이지 (계산으로 알아냄)
	private int endPage; //화면에 보이는 끝 페이지(계산으로 알아냄)
	
	private int startNo; //게시글 시작번호(계산으로 알아냄)
	private int endNo; //게시글 끝번호(계산으로 알아냄)
	
	private String zone;
	private String station;
	
	// 총 게시글 수 입력하는 생성자
	public SellerLocPaging(int totalCount) {
		this.setTotalCount(totalCount);
		
		makePaging();
	}
	
	// 총 게시글 수, 현재 페이지 엽력하는 생성자
	public SellerLocPaging(int totalCount, int curPage) {
		this.setTotalCount(totalCount);
		this.setCurPage(curPage);
		
		makePaging();
	}
	
	// 총 게시글 수, 현재 페이지, 페이지당 게시글 수 입력하는 생성자
	public SellerLocPaging(int totalCount, int curPage, int listCount) {
		this.setTotalCount(totalCount);
		this.setCurPage(curPage);
		this.setListCount(listCount);
		
		makePaging();
	}
	
	// 총 게시글 수, 현재 페이지, 페이지당 게시글 수, 페이지카운트 입력하는 생성자
	public SellerLocPaging(int totalCount, int curPage, int listCount, int pageCount) {
		this.setTotalCount(totalCount);
		this.setCurPage(curPage);
		this.setListCount(listCount);
		this.setPageCount(pageCount);
		
		makePaging();
	}
	

	
	@Override
	public String toString() {
		return "SellerLocPaging [curPage=" + curPage + ", totalCount=" + totalCount + ", listCount=" + listCount
				+ ", totalPage=" + totalPage + ", pageCount=" + pageCount + ", startPage=" + startPage + ", endPage="
				+ endPage + ", startNo=" + startNo + ", endNo=" + endNo + ", zone=" + zone + ", station=" + station
				+ "]";
	}

	private void makePaging() {
		if(totalCount == 0) return; //게시글이 없는 경우 중단
		
		//기본값 설정
		if(curPage == 0)	setCurPage(1); //첫페이지로 설정
		if(listCount == 0)	setListCount(5); //게시글 5개로 설정
		if(pageCount == 0)	setPageCount(10); //페이징 10개로 설정
		
		//총 페이징 수 (계산)
		totalPage = totalCount / listCount;
		if( totalCount % listCount >0 ) totalPage++;
		

		//현재 페이지가 총 페이지보다 크게 입력되면
		//강제로 마지막 페이지로 고정시키기
		if(totalPage < curPage) curPage = totalPage;
		
		//시작 페이지 번호를 알아내서 처리	
		startPage = ((curPage-1)/pageCount)*pageCount+1;
		endPage = startPage+pageCount-1;
		
		//마지막으로 계산된 페이지가 totalPage보다 커질 경우
		//강제로 최종 페이지까지만 보이도록 설정
		if(endPage > totalPage) endPage = totalPage;
		
		//화면에 보이는 시작 게시글 & 끝 게시글 번호 계산
		startNo = (curPage-1)*listCount+1;
		endNo = curPage*listCount;	
		

		
	}
	
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getStarNo() {
		return startNo;
	}
	public void setStarNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public int getStartNo() {
		return startNo;
	}

	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}

	public String getZone() {
		return zone;
	}

	public void setZone(String zone) {
		this.zone = zone;
	}

	public String getStation() {
		return station;
	}

	public void setStation(String station) {
		this.station = station;
	}
	
	

}
