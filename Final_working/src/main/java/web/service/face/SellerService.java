package web.service.face;

import java.util.List;

import web.dto.BookListInfo;
import web.dto.Reservation;
import web.dto.SellerInfo;
import web.dto.SellerLoc;
import web.dto.User;

public interface SellerService {

	// 판매자 로그인
	public boolean login(SellerInfo sellerInfo);

	// 판매자 정보 가져오기
	public SellerInfo getSellerInfo(String sellerId);

	// 판매자(sellerId) 판매정보 가져오기
	public SellerLoc getSellerLoc(String sellerId);

	// sellerId의 판매부수 가져오기
	public List<BookListInfo> getBookList(String sellerId);

	// bookListInfo의 magazineNo로 판매 호수, 판매 부수 수정
	public void setMegazine(BookListInfo bookListInfo);

	// bookListInfo의 magazineNo로 판매 호수, 판매 부수 삭제
	public void deleteMegazine(int magazineNo);

	// 판매할 빅이슈 추가
	public void putMegazine(BookListInfo bookListInfo);

	// 오픈, 마감시간 변경
	public void setSellerTime(SellerLoc sellerLoc);

	// 판매자의 예약내역 가져오기
	public List<Reservation> getReserve(String sellerId);

	// reserveNo로 예약내역-예약취소로 변경
	public void cancelReserve(int reserveNo);

	// reserveNo로 예약내역-수령으로 변경
	public void updateReserve(int reserveNo);

	// 현재시간보다 디비에 저장된 시간이 클 때 예약취소로 상태 변경
	public void setPickupDate(Reservation bookList);

	// view에서 오픈버튼 눌렀을 때 오픈시간 변경 
	public void setStartTime(SellerLoc sellerLoc);

	// view에서 마감버튼 눌렀을 때 마감시간 변경
	public void setEndTime(SellerLoc sellerLoc);
	
	//User으로 정보가 필요해서 추가
	public User getSellerInfoUser(SellerInfo sellerInfo);

}
