package web.dto;

import java.util.Date;

public class ChatReport { // 채팅신고내용
	
	private int reportNo; // 채팅신고번호
	private String reportId; // 신고자
	private String buyerId; // 구매자
	private String chatContent; // 채팅내용
	private Date chatDate; // 채팅날짜
	
	public int getReportNo() {
		return reportNo;
	}
	public void setReportNo(int reportNo) {
		this.reportNo = reportNo;
	}
	public String getReportId() {
		return reportId;
	}
	public void setReportId(String reportId) {
		this.reportId = reportId;
	}
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public Date getChatDate() {
		return chatDate;
	}
	public void setChatDate(Date chatDate) {
		this.chatDate = chatDate;
	}
	
	@Override
	public String toString() {
		return "ChatReport [reportNo=" + reportNo + ", reportId=" + reportId + ", buyerId=" + buyerId + ", chatContent="
				+ chatContent + ", chatDate=" + chatDate + "]";
	}
	
}
