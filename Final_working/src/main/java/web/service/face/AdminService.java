package web.service.face;

import java.util.HashMap;
import java.util.List;

import web.dto.AdminInfo;
import web.dto.BigdomInfo;
import web.dto.BigdomSellerInfo;
import web.dto.BuyerInfo;
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

	// 판매자 정보와 판매자에 따른 빅돔 정보 불러오기(전체)
	public List<SellerBigdomInfo> getSellerBigdomInfo();

	// 구매자 정보 불러오기
	public List<BuyerInfo> getBuyerInfoList();

	// 빅돔 정보와 빅돔에 따른 판매자 정보 불러오기
	public List<BigdomSellerInfo> getBigdomSellerInfo();

	// 판매자 정보와 판매자에 따른 빅돔 정보 불러오기(sellerid에 해당하는것만)
	public SellerBigdomInfo getSellerBigdomInfo(String sellerId);

	// 판매자 정보 업데이트
	public void sellerUpdate(SellerBigdomInfo sbInfo);

	// 판매자 정보 삭제
//	public void sellerDelete(String sellerId);

	// 판매자 정보 삭제하면 sellerloc 테이블에 판매자, 빅돔 null 설정
	public void setSellerAndBigdomNull(String sellerId);

	// sellerloc에 해당 판매자가 있는지 불러오기
	public boolean getSellerStatus(String sellerId);

	// sellerloc에 해당판매자의 빅돔이 있는지 불러오기
	public boolean getBigdomStatus(SellerBigdomInfo sbList);

	// 판매자 계정관리페이지에서 빅돔비활성화
	public void deactivateBigdom(SellerBigdomInfo sbInfo);

	// 판매자 계정관리페이지에서 빅돔활성화
	public void activateBigdom(SellerBigdomInfo sbInfo);

	// 마지막 판매자 조회
	public String getLastSeller();

	// 새로운 빅돔 추가(newNo는 seller 뒤에 붙을 번호)
	public void putNewBigdom(BigdomInfo bigdomInfo);

	// 새로운 판매자 추가(newNo는 seller 뒤에 붙을 번호)
	public void putNewSeller(SellerInfo sellerInfo);

	// 마지막에 추가한 판매자 조회(view에서 사용)
	public SellerInfo getLastSellerInfo();

	// 구매자 계정 조회(수정페이지)
	public BuyerInfo getBuyerInfo(String buyerId);

	// 구매자 정보 수정
	public void setBuyerInfo(BuyerInfo buyerInfo);

	// 구매자 정보 삭제
	public void delBuyerInfo(BuyerInfo buyerInfo);

}

