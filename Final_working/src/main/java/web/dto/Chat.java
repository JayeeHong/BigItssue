package web.dto;

import java.util.Date;

public class Chat { // 채팅내역
	
	private int chatRoomNo; // 채팅방 번호
	private String bigdomId; // 빅돔 아이디
	private String buyerId; // 구매자 아이디
	private String sellerId; // 판매자 아이디
	private String TheOtherParty; //상대방  - 채팅내역의 상대방 이름을 띄워 주기위해서 추가
	private Date chatFinalDate; //채팅방에서 메시지 오갈때, 최신 날짜.
	
	public int getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	public String getBigdomId() {
		return bigdomId;
	}
	public void setBigdomId(String bigdomId) {
		this.bigdomId = bigdomId;
	}
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getTheOtherParty() {
		return TheOtherParty;
	}
	public void setTheOtherParty(String theOtherParty) {
		TheOtherParty = theOtherParty;
	}
	
	public Date getChatFinalDate() {
		return chatFinalDate;
	}
	public void setChatFinalDate(Date chatFinalDate) {
		this.chatFinalDate = chatFinalDate;
	}
	
	@Override
	public String toString() {
		return "Chat [chatRoomNo=" + chatRoomNo + ", bigdomId=" + bigdomId + ", buyerId=" + buyerId + ", sellerId="
				+ sellerId + ", TheOtherParty=" + TheOtherParty + ", chatFinalDate=" + chatFinalDate + "]";
	}
	

	
}
