package web.dto;

public class SellerLoc { // 판매자 판매정보
	
	private int locNo; // 판매위치 번호
	private String zone; // 지역(호선) - 서울:호선, 그외지역:지역이름
	private String station; // 판매장소(역) - 서울:역이름, 그외지역:판매장소이름
	private String spot; // 출구(위치) - 서울:출구번호, 그외지역:판매위치
	private String sellerTimeS; // 판매시작시간
	private String startTime1; // 판매시작시간-jsp에서 가져올 값(추가)
	private String startTime2; // 판매시작시간-jsp에서 가져올 값(추가)
	private String sellerTimeE; // 판매종료시간
	private String endTime1; // 판매종료시간-jsp에서 가져올 값(추가)
	private String endTime2; // 판매종료시간-jsp에서 가져올 값(추가)
	private String sellerCard; // 카드결제여부 - 가능, 불가능
	private int magazineNo; // 판매부수번호 (fk)
	private String sellerId; // 판매자아이디 (fk)
	private String bigdomId; // 빅돔아이디 (fk)
	private String sellerName; // 판매자이름(추가)
	private double lat; //경도
	private double lng; //위도
	
	
	
	@Override
	public String toString() {
		return "SellerLoc [locNo=" + locNo + ", zone=" + zone + ", station=" + station + ", spot=" + spot
				+ ", sellerTimeS=" + sellerTimeS + ", startTime1=" + startTime1 + ", startTime2=" + startTime2
				+ ", sellerTimeE=" + sellerTimeE + ", endTime1=" + endTime1 + ", endTime2=" + endTime2 + ", sellerCard="
				+ sellerCard + ", magazineNo=" + magazineNo + ", sellerId=" + sellerId + ", bigdomId=" + bigdomId
				+ ", sellerName=" + sellerName + ", lat=" + lat + ", lng=" + lng + "]";
	}
	
	
	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getLng() {
		return lng;
	}
	public void setLng(double lng) {
		this.lng = lng;
	}
	public int getLocNo() {
		return locNo;
	}
	public void setLocNo(int locNo) {
		this.locNo = locNo;
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
	public String getSpot() {
		return spot;
	}
	public void setSpot(String spot) {
		this.spot = spot;
	}
	public String getSellerTimeS() {
		return sellerTimeS;
	}
	public void setSellerTimeS(String sellerTimeS) {
		this.sellerTimeS = sellerTimeS;
	}
	public String getStartTime1() {
		return startTime1;
	}
	public void setStartTime1(String startTime1) {
		this.startTime1 = startTime1;
	}
	public String getStartTime2() {
		return startTime2;
	}
	public void setStartTime2(String startTime2) {
		this.startTime2 = startTime2;
	}
	public String getSellerTimeE() {
		return sellerTimeE;
	}
	public void setSellerTimeE(String sellerTimeE) {
		this.sellerTimeE = sellerTimeE;
	}
	public String getEndTime1() {
		return endTime1;
	}
	public void setEndTime1(String endTime1) {
		this.endTime1 = endTime1;
	}
	public String getEndTime2() {
		return endTime2;
	}
	public void setEndTime2(String endTime2) {
		this.endTime2 = endTime2;
	}
	public String getSellerCard() {
		return sellerCard;
	}
	public void setSellerCard(String sellerCard) {
		this.sellerCard = sellerCard;
	}
	public int getMagazineNo() {
		return magazineNo;
	}
	public void setMagazineNo(int magazineNo) {
		this.magazineNo = magazineNo;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getBigdomId() {
		return bigdomId;
	}
	public void setBigdomId(String bigdomId) {
		this.bigdomId = bigdomId;
	}
	
}
