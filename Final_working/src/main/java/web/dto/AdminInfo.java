package web.dto;

public class AdminInfo { // 관리자계정
	
	private String adminId; // 아이디
	private String adminPw; // 비밀번호
	
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}

	@Override
	public String toString() {
		return "AdminInfo [adminId=" + adminId + ", adminPw=" + adminPw + "]";
	}

}
