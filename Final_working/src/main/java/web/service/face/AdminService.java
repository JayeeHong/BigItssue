package web.service.face;

import java.util.HashMap;
import java.util.List;

import web.dto.Notice;
import web.dto.SellerLoc;
import web.util.Paging;

public interface AdminService {
	//
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

	public void noticeInsert(Notice notice);

	public void addHit(Notice notice);

	public void noticeUpdate(Notice notice);
}
//