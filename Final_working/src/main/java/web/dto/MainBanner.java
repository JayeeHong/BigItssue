package web.dto;

public class MainBanner { // 메인배너

	private int bannerNo; // 배너 번호
	private String bannerImg; // 배너 이미지
	
	public int getBannerNo() {
		return bannerNo;
	}
	public void setBannerNo(int bannerNo) {
		this.bannerNo = bannerNo;
	}
	public String getBannerImg() {
		return bannerImg;
	}
	public void setBannerImg(String bannerImg) {
		this.bannerImg = bannerImg;
	}
	
	@Override
	public String toString() {
		return "MainBanner [bannerNo=" + bannerNo + ", bannerImg=" + bannerImg + "]";
	}
	
}
