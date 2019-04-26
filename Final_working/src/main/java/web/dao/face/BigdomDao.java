package web.dao.face;

import web.dto.BigdomInfo;

public interface BigdomDao {

	// 로그인 정보 조회
	public int selectCntLogin(BigdomInfo bigdomInfo);

	// 빅돔 정보 조회
	public BigdomInfo selectBigdomInfo(String bigdomId);

}
