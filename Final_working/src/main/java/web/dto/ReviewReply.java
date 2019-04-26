package web.dto;

import java.util.Date;

public class ReviewReply { // 후기댓글
	
	private int replyNo; // 후기댓글 번호
	private String replyContent; // 내용
	private Date replyDate; // 작성일
	private String writer; // 작성자 아이디
	private int reviewNo; // 후기번호 (fk)
	
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

	@Override
	public String toString() {
		return "ReviewReply [replyNo=" + replyNo + ", replyContent=" + replyContent + ", replyDate=" + replyDate
				+ ", writer=" + writer + ", reviewNo=" + reviewNo + "]";
	}
	
}
