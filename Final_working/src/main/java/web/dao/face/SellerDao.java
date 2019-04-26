package web.dao.face;

import java.util.List;

import web.dto.BookListInfo;
import web.dto.Reservation;
import web.dto.SellerInfo;
import web.dto.SellerLoc;

public interface SellerDao {

	// 로그인 정보 조회
	public int selectCntLogin(SellerInfo sellerInfo);

	// 판매자 정보 조회
	public SellerInfo selectSellerInfo(String sellerId);

	// 판매자(sellerId) 판매정보 조회
	public SellerLoc selectSellerLoc(String sellerId);

	// sellerId의 판매부수 조회
	public List<BookListInfo> selectBookList(String sellerId);

	// 판매 호수, 판매 부수 업데이트 쿼리
	public void updateBookList(BookListInfo bookListInfo);

	// 판매 호수, 판매 부수 삭제 쿼리
	public void deleteMegazine(int magazineNo);

	// 판매할 빅이슈 추가 쿼리
	public void insertMegazine(BookListInfo bookListInfo);

	// 오픈 마감시간 업데이트 쿼리
	public void updateSellerTime(SellerLoc sellerLoc);

	// 판매자의 예약내역 조회
	public List<Reservation> selectReserve(String sellerId);

	// reserveNo로 예약내역-예약취소로 변경 쿼리
	public void updateToCancelReserve(int reserveNo);

	// reserveNo로 예약내역-수령 으로 변경 쿼리
	public void updateToCompleteReserve(int reserveNo);

	// 수령시간이 지났을 경우 예약취소로 변경 쿼리
	public void updatePickupDate(Reservation bookList);

	// view에서 오픈버튼 눌렀을 때 오픈시간 변경 쿼리
	public void updateStartTime(SellerLoc sellerLoc);

	// view에서 마감버튼 눌렀을 때 마감시간 변경 쿼리
	public void updateEndTime(SellerLoc sellerLoc);

}
