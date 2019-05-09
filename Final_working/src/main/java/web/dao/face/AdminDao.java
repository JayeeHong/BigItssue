package web.dao.face;

import java.util.HashMap;
import java.util.List;

import web.dto.AdminInfo;
import web.dto.BigdomInfo;
import web.dto.BigdomSellerInfo;
import web.dto.BookListInfo;
import web.dto.BuyerInfo;
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

	// 판매자 정보와 판매자에 따른 빅돔 정보 조회 쿼리(전체)
	public List<SellerBigdomInfo> selectSellerBigdomInfo(Paging paging);

	// 구매자 정보 조회 쿼리
	public List<BuyerInfo> selectBuyerInfoList(Paging paging);

	// 빅돔 정보와 빅돔에 따른 빅돔 정보 조회 쿼리
	public List<BigdomSellerInfo> selectBigdomSellerInfo(Paging paging);

	// 판매자 정보와 판매자에 따른 빅돔 정보 조회 쿼리(sellerid에 해당하는것만)
	public SellerBigdomInfo selectSBInfo(String sellerId);

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

	// 해당 판매자의 보유 빅이슈 정보 삽입 쿼리
	public void insertBookListInfoAtadminBook(BookListInfo bli);


	public void adminSellserUpdate(SellerLoc sellerLoc);

	public String getSellerName(SellerLoc locInfo);


	//판매 지역 추가
	public void insertList(SellerLoc sellerLoc);

	//판매 지역 삭제
	public void deleteList(SellerLoc sellerLoc);


	
	//배너 리스트 조회
	public List<MainBanner> selectBanner();

	public List<String> userIdList(String abc);

	public List<SellerInfo> nullUserInfo(String i);

	
	public List<Message> getChatRoomNo();


}

