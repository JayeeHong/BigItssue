package web.dto;

import java.util.Date;

public class ReviewReply { // 후기댓글
	
	private int replyNo; // 후기댓글 번호
	private String replyContent; // 내용
	private Date replyDate; // 작성일
	private String writer; // 작성자 아이디
	private int reviewNo; // 후기번호 (fk)
	
	//-----댓글 웹소켓 적용때문에 추가-----
	private String stringDate; //String타입으로 날짜 보내주기 위해서추가. append로 댓글 넣으려했는데 <fmt>태그를 인식못해서 여기서 바꿔주었음.
	private String reviewViewSellerId; //댓글방 주인. 으로 이용하려고 추가
	//---------------------------
	
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}	
	
	public String getStringDate() {
		return stringDate;
	}
	public void setStringDate(String stringDate) {
		this.stringDate = stringDate;
	}

	public String getReviewViewSellerId() {
		return reviewViewSellerId;
	}
	public void setReviewViewSellerId(String reviewViewSellerId) {
		this.reviewViewSellerId = reviewViewSellerId;
	}
	
	@Override
	public String toString() {
		return "ReviewReply [replyNo=" + replyNo + ", replyContent=" + replyContent + ", replyDate=" + replyDate
				+ ", writer=" + writer + ", reviewNo=" + reviewNo + ", stringDate=" + stringDate
				+ ", reviewViewSellerId=" + reviewViewSellerId + "]";
	}
	
	

	
	
}
