package web.dto;

public class BuyerInfo { // 구매자 계정
	
	private String buyerId; // 아이디
	private String buyerPw; // 비밀번호
	private String buyerPhone; // 전화번호
	private String buyerEmail; // 이메일
	private String buyerName; // 이름
	private String sort; // 유저분류
	
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	public String getBuyerPw() {
		return buyerPw;
	}
	public void setBuyerPw(String buyerPw) {
		this.buyerPw = buyerPw;
	}
	public String getBuyerPhone() {
		return buyerPhone;
	}
	public void setBuyerPhone(String buyerPhone) {
		this.buyerPhone = buyerPhone;
	}
	public String getBuyerEmail() {
		return buyerEmail;
	}
	public void setBuyerEmail(String buyerEmail) {
		this.buyerEmail = buyerEmail;
	}
	public String getBuyerName() {
		return buyerName;
	}
	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Override
	public String toString() {
		return "BuyerInfo [buyerId=" + buyerId + ", buyerPw=" + buyerPw + ", buyerPhone=" + buyerPhone + ", buyerEmail="
				+ buyerEmail + ", buyerName=" + buyerName + ", sort=" + sort + "]";
	}
	
}
