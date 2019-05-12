package web.service.face;

import java.util.List;
import java.util.Map;

import web.dto.BookListInfo;
import web.dto.BuyerInfo;
import web.dto.Notice;
import web.dto.MainBanner;
import web.dto.Reservation;
import web.dto.SellerLoc;
import web.dto.User;
import web.util.MyBookingPaging;
import web.util.Paging;
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

	
	
	// /buyer/my/info 에서 구매자 회원정보 가져오기
	public BuyerInfo getBuyerInfoAtBuyermyinfo(BuyerInfo buyerInfo);

	// /buyer/my/info 에서 구매자 전화번호 업데이트
	public void setBuyerPhone(BuyerInfo buyerInfo);

	// /buyer/my/info 에서 구매자 이메일 업데이트
	public void setBuyerEmail(BuyerInfo buyerInfo);
	
	//zone,station으로 sellerLoc 개수새기
	public int getTotalCountOfSellerLocByZoneAndStation(Map<String, Object> map);
	
	//zone,station으로 sellerLoc 조회
	public List<SellerLoc> getPagingListOfSellerLocByZoneAndStation(SellerLocPaging paging);
	
	//나의 예약내역의 총count구하기
	public int getTotalCountOfMyBooking(String buyerId);
	
	//나의 예약페이징리스트 조회
	public List<Reservation> getPagingListOfMyReservation(MyBookingPaging paging);
	
	//공지사항 갯수조회
	public int getNoticeCnt();
		
	//공지사항 페이징리스트조회
	public List<Notice> getNoticeList(Paging paging);
		
	//공지사항 상세보기
	public Notice getNoticeView(int noticeNo);

	//reservation예약테이블 status "예약"=>"취소"로 변경하기
	public void setStatusOfReservation(int magazineNo);
	
	//magazineNo으로 Reservation 조회
	public Reservation getReservaionByMagazineNo(int magazineNo);
	
	//bookListInfo 빅이슈테이블 circulation(보유부수) 예약취소한 수 만큼 증가시키기
	public void increaseCirculation(Reservation reservationInfo);

	//메인베너 정보 가져오기
	public List<MainBanner> getBannerList();

	// 마이페이지 비밀번호 변경
	public void setBuyerInfoAtMypage(BuyerInfo buyerInfo);
	
	
}
