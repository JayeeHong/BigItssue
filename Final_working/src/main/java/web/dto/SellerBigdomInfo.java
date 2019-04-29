package web.dto;

public class SellerBigdomInfo {
	
	private String sellerId; // 아이디
	private String sellerPw; // 비밀번호
	private String sellerPhone; // 전화번호
	private String sellerName; // 이름
	private String sellerImg; // 판매자 사진
	private String sort; // 유저분류
	private String bigdomId; // 판매자에 따른 빅돔아이디
	
	@Override
	public String toString() {
		return "SellerBigdomInfo [sellerId=" + sellerId + ", sellerPw=" + sellerPw + ", sellerPhone=" + sellerPhone
				+ ", sellerName=" + sellerName + ", sellerImg=" + sellerImg + ", sort=" + sort + ", bigdomId="
				+ bigdomId + "]";
	}
	
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getSellerPw() {
		return sellerPw;
	}
	public void setSellerPw(String sellerPw) {
		this.sellerPw = sellerPw;
	}
	public String getSellerPhone() {
		return sellerPhone;
	}
	public void setSellerPhone(String sellerPhone) {
		this.sellerPhone = sellerPhone;
	}
	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
	public String getSellerImg() {
		return sellerImg;
	}
	public void setSellerImg(String sellerImg) {
		this.sellerImg = sellerImg;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getBigdomId() {
		return bigdomId;
	}
	public void setBigdomId(String bigdomId) {
		this.bigdomId = bigdomId;
	}
	
}
