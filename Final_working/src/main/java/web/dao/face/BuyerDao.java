package web.dao.face;

import java.util.List;

import web.dto.BookListInfo;
import web.dto.BuyerInfo;
import web.dto.Reservation;
import web.dto.SellerLoc;
import web.dto.User;
import web.util.SellerLocPaging;

public interface BuyerDao {

	public int usingid(BuyerInfo bi);

	public void buyerJoin(BuyerInfo buyerInfo);

	public int buyerLogin(BuyerInfo buyerInfo);

	public BuyerInfo buyerFindId(BuyerInfo buyerInfo);

	public int buyerCnt(BuyerInfo buyerInfo);

	public BuyerInfo buyerFindInfo(BuyerInfo buyerInfo);

	public int buyerFindCnt(BuyerInfo buyerInfo);

	public void pwUpdate(BuyerInfo buyerInfo);

	public int eamilSerch(String email);
	
	//buyerId로 Buyer정보 검색(반환User)
	public User selectBuyerInfoByBuyerId(BuyerInfo buyerInfo);
	
	//-----SellerLoc-----
	//판매처 총 게시글 수 반환
	public int selectCntOfSellerLoc();
	
	//판매처 페이징 리스트 얻기
	public List selectPaginglistOfSellerLoc(SellerLocPaging paging);
	
	public SellerLoc selectSellerLoc(int sellerLoc);
	

	public List<BookListInfo> selectBookListInfoBySellerId(String sellerId);

	public BookListInfo selectBookListInfo(int magazineNo);

	// 입력한 pw가 구매자의 id의 pw인지 조회 쿼리
	public int selectBuyerIdAndPw(BuyerInfo buyerInfo);

	
	//예약하기
	public void insertResrvation(Reservation reservationInfo);
	public void decreaseBookNumber(Reservation reservationInfo);
	
	//예약 buyerId,sellerId로 검색
	public List<Reservation> selectResrvation(Reservation reservationInfo);
	
	//예약 buyerId,sellerId로 개수 검색
	public int selectResrvaionCnt(Reservation reservationInfo);
	
	//예약 buyerId로 검색
	public List<Reservation> selectResrvationByBuyerId(String buyerId);
	
	// 수령시간이 지났을 경우 예약취소로 변경 쿼리
	public void updatePickupDate(Reservation bookList);
	
	//중복 뺀 zoneList 얻기
	public List<SellerLoc> selectZoneList();
	//중복 뺸 stationList 얻기
	public List<SellerLoc> selectStationList();
	
}
