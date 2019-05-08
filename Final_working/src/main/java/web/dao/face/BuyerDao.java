package web.dao.face;

import java.util.List;
import java.util.Map;

import web.dto.BookListInfo;
import web.dto.BuyerInfo;
import web.dto.MainBanner;
import web.dto.Reservation;
import web.dto.SellerLoc;
import web.dto.User;
import web.util.MyBookingPaging;
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
	
	//zone,station으로 sellerLoc 개수새기
	public int selectTotalCountOfSellerLocByZoneAndStation(Map<String, Object> map);
	
	//zone,station으로 sellerLoc 조회
	public List<SellerLoc> selectPagingListOfSellerLocByZoneAndStation(SellerLocPaging paging);
	
	//나의 예약내역의 총count구하기
	public int selectTotalCountOfMyBooking(String buyerId);
	
	//나의 예약페이징리스트 조회
	public List<Reservation> selectPagingListOfMyReservation(MyBookingPaging paging);
	
	//reservation예약테이블 status "예약"=>"취소"로 변경하기
	public void updateStatusOfReservation(int magazineNo);
	
	//magazineNo으로 Reservation 조회
	public Reservation selectReservationByMagazineNo(int magazineNo);
	
	//bookListInfo 빅이슈테이블 circulation(보유부수) 예약취소한 수 만큼 증가시키기
	public void increaseCirculation(Reservation reservationInfo);

	//배너 정보 조회
	public List<MainBanner> selectBanner();
}
