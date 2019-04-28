package web.service.face;

import web.dto.BigdomInfo;
import web.dto.User;

public interface BigdomService {

	// 빅돔 로그인
	public boolean login(BigdomInfo bigdomInfo);

	// 빅돔 정보 가져오기
	public BigdomInfo getBigdomInfo(String bigdomId);
	
	// 빅돔 정보 User로 가져오기
	public User getBigdomInfoUser(BigdomInfo bigdomInfo);

}
