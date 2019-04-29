package web.dao.face;

import java.util.HashMap;
import java.util.List;

import web.dto.AdminInfo;
import web.dto.Notice;
import web.dto.SellerLoc;
import web.util.Paging;

public interface AdminDao {
	
	public int getTotalCount(HashMap doubleString);

	public List<SellerLoc> getPagingList(HashMap map);

	public void adminSellerListDelete(SellerLoc sellerLoc);

	public SellerLoc getSellerInfo(SellerLoc sellerloc);

	public List<SellerLoc> viewLoc(String zone);

	public List<SellerLoc> viewDetail(String station);
	
	public int getNoticeCount();

	public List<Notice> getNoticeList(Paging p);

	public Notice noticeView(Notice notice);

	public void adminNoticeDelete(Notice notice);

	// 관리자 아이디, 비밀번호 count(*) 쿼리
	public int selectCntLogin(AdminInfo adminInfo);
	
}
