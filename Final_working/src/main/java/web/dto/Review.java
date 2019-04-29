package web.dto;

import java.util.Date;

public class Review { // 후기
	
	private int reviewNo; // 후기번호
	private String reviewTitle; // 제목
	private String reviewContent; // 내용
	private Date reviewDate; // 작성일
	private int reviewHit; //조회수
	private String sellerId; // 판매자 아이디(fk)
	
	
	public int getReviewHit() {
		return reviewHit;
	}
	public void setReviewHit(int reviewHit) {
		this.reviewHit = reviewHit;
	}

	
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public Date getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	
	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", reviewTitle=" + reviewTitle + ", reviewContent=" + reviewContent
				+ ", reviewDate=" + reviewDate + ", reviewHit=" + reviewHit + ", sellerId=" + sellerId + "]";
	}
	
}
