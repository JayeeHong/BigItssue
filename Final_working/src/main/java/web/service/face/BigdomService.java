package web.service.face;

import web.dto.BigdomInfo;

public interface BigdomService {

	// 빅돔 로그인
	public boolean login(BigdomInfo bigdomInfo);

	// 빅돔 정보 가져오기
	public BigdomInfo getBigdomInfo(String bigdomId);

}
