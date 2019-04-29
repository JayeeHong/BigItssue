package web.dao.face;

import web.dto.BigdomInfo;
import web.dto.User;

public interface BigdomDao {

	// 로그인 정보 조회
	public int selectCntLogin(BigdomInfo bigdomInfo);

	// 빅돔 정보 조회
	public BigdomInfo selectBigdomInfo(String bigdomId);
	
	// 빅돔 정보 조회(User반환)
	public User selectBigdomInfoUser(BigdomInfo bigdomInfo);

}
