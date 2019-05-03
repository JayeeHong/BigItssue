package web.service.face;

import java.util.List;
import java.util.Map;

import web.dto.BookListInfo;
import web.dto.BuyerInfo;
import web.dto.Reservation;
import web.dto.SellerLoc;
import web.dto.User;
import web.util.MyBookingPaging;
import web.util.SellerLocPaging;

public interface BuyerService {
	public boolean haveId(BuyerInfo bi);

	public void buyerJoin(BuyerInfo buyerInfo);

	public boolean buyerLogin(BuyerInfo buyerInfo);

	public void mailSender(String email, String subject, String body);

	public BuyerInfo buyerFindId(BuyerInfo buyerInfo); //정보 2개로 조회 id찾기

	public int buyerCnt(BuyerInfo buyerInfo);//정보 2개로 조회 id찾기 있는지 없는지 COUNT(*)

	public BuyerInfo buyerFindInfo(BuyerInfo buyerInfo); //정보 3개로 조회 비밀번호 찾기

	public int buyerFindCnt(BuyerInfo buyerInfo);//정보 3개로 조회 비밀번호 찾기 있는지 없는지 COUNT(*)

	public void pwUpdate(BuyerInfo buyerInfo);

	public int eamilSerch(String email);
	
	//buyerId로 Buyer정보 검색(반환User)
	public User getBuyerInfo(BuyerInfo buyerInfo);
	
	//판매처 총 게시글 수 얻기
	public int getTotalCountOfSellerLoc();
	
	//판매처 페이징 리스트 얻기
	public List getPagingListOfSellerLoc(SellerLocPaging paging);
	
	public SellerLoc getSellerLoc(int sellerLoc);
	

	public List<BookListInfo> getBookListInfoBySellerId(String sellerId);

	public BookListInfo getBookListInfo(int magazineNo);

	// 비밀번호 확인
	public boolean confirmpw(BuyerInfo buyerInfo);

	
	//예약하기
	public void booking(Reservation reservationInfo);
	
	
	//예약 buyerId,sellerId로 검색
	public List<Reservation> getResrvaionList(Reservation reservationInfo);
	//예약 buyerId,sellerId로 개수 검색
	public int getResrvaionCnt(Reservation reservationInfo);
	
	//예약 buerId로 검색
	public List<Reservation> getResrvaionListByBuyerId(String buyerId);
	
	// 현재시간이 디비에 저장된 시간보다 클 때 예약취소로 상태 변경
	public void setPickupDate(Reservation bookList);
	
	//중복뺀 zoneList얻기
	public List<SellerLoc> getZoneList();
	
	//중복뺸 stationList얻기
	public List<SellerLoc> getStationList();
	
	//zone,station으로 sellerLoc 개수새기
	public int getTotalCountOfSellerLocByZoneAndStation(Map<String, Object> map);
	
	//zone,station으로 sellerLoc 조회
	public List<SellerLoc> getPagingListOfSellerLocByZoneAndStation(SellerLocPaging paging);
	
	//나의 예약내역의 총count구하기
	public int getTotalCountOfMyBooking(String buyerId);
	
	//나의 예약페이징리스트 조회
	public List<Reservation> getPagingListOfMyReservation(MyBookingPaging paging);
	
	
	
}
