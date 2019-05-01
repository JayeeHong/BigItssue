package web.dto;

public class BuyerInfo { // 구매자 계정
	
	private String buyerId; // 아이디
	private String buyerPw; // 비밀번호
	private String buyerPhone; // 전화번호
	// --- 전화번호 split ---
	private String buyerPhone1;
	private String buyerPhone2;
	private String buyerPhone3;
	// ----------------------
	private String buyerEmail; // 이메일
	// --- 이메일 split ---
	private String buyerEmail1;
	private String buyerEmail2;
	// --------------------
	private String buyerName; // 이름
	private String sort; // 유저분류
	
	public String getBuyerEmail1() {
		return buyerEmail1;
	}
	public void setBuyerEmail1(String buyerEmail1) {
		this.buyerEmail1 = buyerEmail1;
	}
	public String getBuyerEmail2() {
		return buyerEmail2;
	}
	public void setBuyerEmail2(String buyerEmail2) {
		this.buyerEmail2 = buyerEmail2;
	}
	public String getBuyerPhone1() {
		return buyerPhone1;
	}
	public void setBuyerPhone1(String buyerPhone1) {
		this.buyerPhone1 = buyerPhone1;
	}
	public String getBuyerPhone2() {
		return buyerPhone2;
	}
	public void setBuyerPhone2(String buyerPhone2) {
		this.buyerPhone2 = buyerPhone2;
	}
	public String getBuyerPhone3() {
		return buyerPhone3;
	}
	public void setBuyerPhone3(String buyerPhone3) {
		this.buyerPhone3 = buyerPhone3;
	}
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
		return "BuyerInfo [buyerId=" + buyerId + ", buyerPw=" + buyerPw + ", buyerPhone=" + buyerPhone
				+ ", buyerPhone1=" + buyerPhone1 + ", buyerPhone2=" + buyerPhone2 + ", buyerPhone3=" + buyerPhone3
				+ ", buyerEmail=" + buyerEmail + ", buyerEmail1=" + buyerEmail1 + ", buyerEmail2=" + buyerEmail2
				+ ", buyerName=" + buyerName + ", sort=" + sort + "]";
	}

}
