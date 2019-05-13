package web.dao.face;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import web.dto.AdminInfo;
import web.dto.BigdomInfo;
import web.dto.BigdomSellerInfo;
import web.dto.BookListInfo;
import web.dto.BuyerInfo;
import web.dto.ChatReport;
import web.dto.MainBanner;
import web.dto.Message;
import web.dto.Notice;
import web.dto.SellerBigdomInfo;
import web.dto.SellerInfo;
import web.dto.SellerLoc;
import web.util.Paging;

public interface AdminDao {
	
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
  
  public void addHit(Notice notice);
  
  public void noticeInsert(Notice notice);

	public void noticeUpdate(Notice notice);

	// 관리자 아이디, 비밀번호 count(*) 쿼리
	public int selectCntLogin(AdminInfo adminInfo);

	public void adminSellserUpdate(SellerLoc sellerLoc);

	public String getSellerName(SellerLoc locInfo);

	public void changeSellerName(HashMap hm);

	//판매 지역 추가
	public void insertList(SellerLoc sellerLoc);

	//판매 지역 삭제
	public void deleteList(SellerLoc sellerLoc);

	// 판매자 정보와 판매자에 따른 빅돔 정보 조회 쿼리(전체)
	public List<SellerBigdomInfo> selectSellerBigdomInfo(Paging paging);

	// 구매자 정보 조회 쿼리
	public List<BuyerInfo> selectBuyerInfoList(Paging paging);

	// 빅돔 정보와 빅돔에 따른 빅돔 정보 조회 쿼리
	public List<BigdomSellerInfo> selectBigdomSellerInfo(Paging paging);

	// 판매자 정보와 판매자에 따른 빅돔 정보 조회 쿼리(sellerid에 해당하는것만)
	public SellerBigdomInfo selectSBInfo(String sellerId);

	// 판매자 계정관리에서 이미지 업로드
	public void updateSellerImgupAtadmin(SellerInfo sellerinfo);

	// 판매자 정보 업데이트 쿼리
	public void updateSellerInfo(SellerBigdomInfo sbInfo);

	// 판매자 정보 삭제 쿼리
//	public void deleteSellerInfo(String sellerId);

	// 판매자 정보 삭제하면 sellerloc 테이블에 seller, bigdom null로 업데이트 쿼리
	public void updateSellerAndBigdomNull(String sellerId);

	// sellerloc에 해당 판매자가 있는지 조회 쿼리
	public int selectSellerStatus(String sellerId);

	// sellerloc에 해당 판매자의 빅돔이 있는지 조회 쿼리
	public int selectBigdomStatus(SellerBigdomInfo sbList);

	// sellerloc에 sellerid의 bigdomid 비활성화(null로 세팅)
	public void updateBigdomDeactivate(SellerBigdomInfo sbInfo);

	// sellerloc에 sellerid의 bigdomid 비활성화(sellerid에 맞는 bigdomid 세팅)
	public void updateBigdomActivate(SellerBigdomInfo sbInfo);

	// 마지막 seller 조회 쿼리
	public String selectLastSeller();

	// 새로운 bigdom 추가 쿼리(newNo는 seller뒤에 붙을 번호)
	public void insertNewBigdom(BigdomInfo bigdomInfo);

	// 새로운 seller 추가 쿼리(newNo는 seller뒤에 붙을 번호)
	public void insertNewSeller(SellerInfo sellerInfo);

	// 마지막에 추가한 seller 조회 쿼리
	public SellerInfo selectLastSellerInfo();

	// 구매자 정보 조회(수정페이지) 쿼리
	public BuyerInfo selectBuyerInfo(String buyerId);

	// 구매자 정보 수정 쿼리
	public void updateBuyerInfo(BuyerInfo buyerInfo);

	// 구매자 정보 삭제 쿼리
	public void deleteBuyerInfo(BuyerInfo buyerInfo);

	// 빅돔 정보 조회 쿼리(수정페이지)
	public BigdomSellerInfo selectBigdomInfo(BigdomSellerInfo bsl);

	// 빅돔 정보 업데이트 쿼리
	public void updateBigdomInfo(BigdomInfo bigdomInfo);

	// ------ 계정관리 페이징 ------
	// 판매자 정보 갯수 조회 쿼리
	public int selectSellerInfoCnt();

	// 구매자 정보 갯수 조회 쿼리
	public int selectBuyerInfoCnt();

	// 빅돔 정보 갯수 조회 쿼리
	public int selectBigdomInfoCnt();
	// ----------------------------- 계정관리 페이징 끝

	// ------------- 판매자 빅이슈 관리 ----------------
	// sellerloc 갯수 조회 쿼리
	public int selectSellerLocInfoCnt();

	// sellerloc 리스트 전체 조회 쿼리
	public List<SellerLoc> selectSellerLocInfoList(Paging paging);

	// sellerloc 비활성화구역 갯수 조회 쿼리
	public int selectSellerLocInfoDeactivateCnt();

	// sellerloc 비활성화구역 리스트 조회 쿼리
	public List<SellerLoc> selectSellerLocInfoDeactivateList(Paging paging);

	// sellerloc 활성화구역 갯수 조회 쿼리
	public int selectSellerLocInfoActivateCnt();

	// sellerloc 활성화구역 리스트 조회 쿼리
	public List<SellerLoc> selectSellerLocInfoActivateList(Paging paging);

	// 해당 판매자의 정보 조회 쿼리
	public SellerLoc selectSellerLocInfo(SellerLoc sellerloc);

	// 해당 판매자의 보유 빅이슈 조회 쿼리
	public List<BookListInfo> selectBookListInfoAtBookview(String sellerId);

	// ----------------- 판매자 빅이슈 관리에서 빅이슈 추가할때 -------------------
	// 해당 판매자가 보유한 빅이슈인지 count(*) 조회 쿼리
	public int selectCntBookListInfoBySelleridAndMonth(BookListInfo bli);
	// 해당 판매자가 보유한 빅이슈라면 circulation만 update 쿼리
	public void insertBookListInfoByMagazineno(BookListInfo bli);
	// 해당 판매자의 보유 빅이슈 정보 삽입 쿼리
	public void insertBookListInfoAtadminBook(BookListInfo bli);
	// ------------------------------------------------------------
	
	// 해당 판매자의 보유 빅이슈 추가 쿼리
	public void updateAdminBookView(BookListInfo booklistInfo);

	// 해당 판매자의 보유 빅이슈 삭제 쿼리
	public void deleteAdminBookView(BookListInfo booklistInfo);

	// 신고내역 전체 조회 쿼리
	public List<ChatReport> selectChatReportList();

	// 신고내역 갯수 조회 쿼리
	public int selectReportListCnt();
  
	// reportNo로 해당하는 신고내역 조회 쿼리
	public ChatReport selectReportByReportNo(int reportNo);

	// reportByReportNo의 채팅방번호와 날짜가 일치하는 경우 조회 쿼리
	public List<ChatReport> selectReportByChatReport(ChatReport reportByReportNo);




	
	//배너 리스트 조회
	public List<MainBanner> selectBanner();
	
	//배너번호 조회
	public int selectBannerNo();
	
	//배너 insert
	public void insertBanner(MainBanner mainBanner);

	//배너 delete
	public void deleteBanner(int bannerNo);
	
	


	public List<String> userIdList(String abc);

	public List<SellerInfo> nullUserInfo(String i);

	
	public List<Message> getChatRoomNo();

	// 판매자 이미지만 지우기
	public void deleteSellerImg(SellerBigdomInfo sbInfo);

	// 판매자 정보 이미지 제외하고 업데이트 쿼리(이미지가 없을 때)
	public void updateSellerWithoutImg(SellerBigdomInfo sbInfo);





}

