package web.service.face;

import java.util.HashMap;
import java.util.List;


import web.dto.AdminInfo;
import web.dto.BigdomInfo;
import web.dto.Notice;
import web.dto.SellerBigdomInfo;
import web.dto.SellerInfo;

import web.dto.SellerLoc;
import web.util.Paging;

public interface AdminService {
	
	public int getTotalCount(HashMap doubleString);

	public List<SellerLoc> getPagingList(HashMap map);

	public void adminSellerListDelete(SellerLoc sellerLoc);

	public SellerLoc getSellerInfo(SellerLoc sellerloc);

	public List<SellerLoc> viewLoc(String zone);

	public List viewDetail(String station);
	
	public int getNoticeCount();

	public List<Notice> getNoticeList(Paging p);

	public Notice noticeView(Notice notice);

	public void adminNoticeDelete(Notice notice);
  
  public void noticeInsert(Notice notice);

	public void addHit(Notice notice);

	public void noticeUpdate(Notice notice);

	// 관리자 로그인
	public boolean login(AdminInfo adminInfo);

	// 판매자 정보와 판매자에 따른 빅돔 정보 불러오기
	public List<SellerBigdomInfo> getSellerBigdomInfo();
}

