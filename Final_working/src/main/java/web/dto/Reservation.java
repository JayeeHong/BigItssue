package web.dto;

import java.util.Date;

public class Reservation { // 마이페이지 예약내역
	
	private int reserveNo; // 예약내역 번호
	private String sellerId; // 판매자 아이디
	private String buyerId; // 구매자 아이디
	private String zone; // 지역(호선)
	private String station; // 판매장소(역)
	private String spot; //출구(위치)
	private String bookMonth; // 예약호수
	private int bookNumber; // 예약부수
	private String status; // 상태
	private int total; // 결제 예정금액
	private Date pickupDate; // 수령할 날짜
	private Date bookDate; // 예약신청 날짜
	
	@Override
	public String toString() {
		return "Reservation [reserveNo=" + reserveNo + ", sellerId=" + sellerId + ", buyerId=" + buyerId + ", zone="
				+ zone + ", station=" + station + ", spot=" + spot + ", bookMonth=" + bookMonth + ", bookNumber="
				+ bookNumber + ", status=" + status + ", total=" + total + ", pickupDate=" + pickupDate + ", bookDate="
				+ bookDate + "]";
	}
	
	public int getReserveNo() {
		return reserveNo;
	}
	public void setReserveNo(int reserveNo) {
		this.reserveNo = reserveNo;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
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
	public String getBookMonth() {
		return bookMonth;
	}
	public void setBookMonth(String bookMonth) {
		this.bookMonth = bookMonth;
	}
	public int getBookNumber() {
		return bookNumber;
	}
	public void setBookNumber(int bookNumber) {
		this.bookNumber = bookNumber;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public Date getPickupDate() {
		return pickupDate;
	}
	public void setPickupDate(Date pickupDate) {
		this.pickupDate = pickupDate;
	}
	public Date getBookDate() {
		return bookDate;
	}
	public void setBookDate(Date bookDate) {
		this.bookDate = bookDate;
	}
	
}
