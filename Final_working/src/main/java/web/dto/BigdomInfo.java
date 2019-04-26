package web.dto;

public class BigdomInfo { // 빅돔계정
	
	private String bigdomId; // 아이디
	private String bigdomPw; // 비밀번호
	private String sort; // 유저분류
	
	public String getBigdomId() {
		return bigdomId;
	}
	public void setBigdomId(String bigdomId) {
		this.bigdomId = bigdomId;
	}
	public String getBigdomPw() {
		return bigdomPw;
	}
	public void setBigdomPw(String bigdomPw) {
		this.bigdomPw = bigdomPw;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	
	@Override
	public String toString() {
		return "BigdomInfo [bigdomId=" + bigdomId + ", bigdomPw=" + bigdomPw + ", sort=" + sort + "]";
	}
	
}
