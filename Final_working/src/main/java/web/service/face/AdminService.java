package web.service.face;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import web.dto.AdminInfo;
import web.dto.BigdomInfo;
import web.dto.BigdomSellerInfo;
import web.dto.BookListInfo;
import web.dto.BuyerInfo;
import web.dto.ChatReport;
import web.dto.MainBanner;
import web.dto.Message;
import web.dto.Notice;
import web.dto.Review;
import web.dto.ReviewReply;
import web.dto.SellerBigdomInfo;
import web.dto.SellerInfo;
import web.dto.SellerLoc;
import web.dto.User;
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

	// 판매자 정보관리 수정
	public void adminSellserUpdate(SellerLoc sellerLoc);

	public String getSellerName(SellerLoc locInfo);

	// 판매 장소 추가하기
	public void insertList(SellerLoc sellerLoc);

	// 판매 장소 삭제하기
	public void deleteList(SellerLoc sellerLoc);

	// 관리자 로그인
	public boolean login(AdminInfo adminInfo);

	// ------- 계정관리 -------
	// 판매자 정보와 판매자에 따른 빅돔 정보 불러오기(전체)
	public List<SellerBigdomInfo> getSellerBigdomInfo(Paging paging);

	// 구매자 정보 불러오기
	public List<BuyerInfo> getBuyerInfoList(Paging paging);

	// 빅돔 정보와 빅돔에 따른 판매자 정보 불러오기
	public List<BigdomSellerInfo> getBigdomSellerInfo(Paging paging);

	// 판매자 정보와 판매자에 따른 빅돔 정보 불러오기(sellerid에 해당하는것만)
	public SellerBigdomInfo getSellerBigdomInfo(String sellerId);

	// 판매자 계정관리에서 이미지 업로드
	public void sellerImgupAtadmin(SellerInfo sellerinfo);

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

	// 빅돔 정보 조회(수정페이지)
	public BigdomSellerInfo getBigdomInfo(BigdomSellerInfo bsl);

	// 빅돔 정보 수정
	public void setBigdomInfo(BigdomInfo bigdomInfo);
	// -------------------------------- 계정관리 끝

	// ----- 계정관리 페이징 -----
	// 요청파라미터로 현재페이지 받기-계정관리_판매자
	public int getSellerInfoCurPage(HttpServletRequest req);

	// 해당게시글 수 불러오기-계정관리_판매자
	public int getSellerInfoTotalCount();

	// 요청파라미터로 현재페이지 받기-계정관리_구매자
	public int getBuyerInfoCurPage(HttpServletRequest req);

	// 해당게시글 수 불러오기-계정관리_판매자
	public int getBuyerInfoTotalCount();

	// 요청파라미터로 현재페이지 받기-계정관리_빅돔
	public int getBigdomInfoCurPage(HttpServletRequest req);

	// 해당게시글 수 불러오기-계정관리_빅돔
	public int getBigdomInfoTotalCount();
	// --------------------------- 계정관리 페이징 끝

	// ------- 판매자 빅이슈 관리 -------
	// 요청파라미터로 현재페이지 받기-판매자 빅이슈 관리
	public int getSellerLocInfoCurPage(HttpServletRequest req);

	// 해당게시글 수 불러오기-판매자 빅이슈 관리
	public int getSellerLocInfoTotalCount();

	// sellerloc 전체 불러오기
	public List<SellerLoc> getSellerLocList(Paging paging);

	// 요청파라미터로 현재페이지 받기-판매자 빅이슈 관리_비활성화구역
	public int getSellerLocInfoDeactivateCurPage(HttpServletRequest req);

	// 해당게시글 수 불러오기-판매자 빅이슈 관리_비활성화구역
	public int getSellerLocInfoDeactivateTotalCount();

	// sellerloc 비활성화구역(sellerid가 null) 불러오기
	public List<SellerLoc> getSellerLocListDeactivate(Paging paging);

	// 요청파라미터로 현재페이지 받기-판매자 빅이슈 관리_활성화구역
	public int getSellerLocInfoActivateCurPage(HttpServletRequest req);

	// 해당게시글 수 불러오기-판매자 빅이슈 관리_활성화구역	
	public int getSellerLocInfoActivateTotalCount();

	// sellerloc 활성화구역(sellerid가 null이 아님) 불러오기
	public List<SellerLoc> getSellerLocListActivate(Paging paging);

	// 해당 판매자의 판매자 정보 불러오기
	public SellerLoc getSellerLocInfo(SellerLoc sellerloc);

	// 해당 판매자의 보유 빅이슈 정보 조회
	public List<BookListInfo> getBookListInfoAtBookview(String sellerId);

	// 해당 판매자의 보유 빅이슈 정보 추가
	public void putBookListInfoAtadminBook(BookListInfo bli);

	// 해당 판매자의 보유 빅이슈 수정
	public void adminBookViewUpdate(BookListInfo booklistInfo);

	// 해당 판매자의 보유 빅이슈 삭제
	public void adminBookViewDelete(BookListInfo booklistInfo);
  
	// 신고내역 전체 불러오기
	public List<ChatReport> getChatReportList();

	// 요청파라미터로 현재페이지 받기-신고내역 리스트
	public int getReportInfoCurPage(HttpServletRequest req);

	// 해당게시글 수 불러오기-신고내역 리스트
	public int getReportInfoTotalCount();

	// reportNo로 해당하는 신고내역 조회
	public ChatReport getReportByReportNo(int reportNo);

	// reportByReportNo의 채팅방번호와 날짜가 일치하는 경우 조회
	public List<ChatReport> getReportByChatReport(ChatReport reportByReportNo);

	
	//배너 리스트 얻기
	public List<MainBanner> getBanner();
	
	//배너 번호 얻기
	public int getBannerNo();
	
	//배너 추가하기
	public void addBanner(MainBanner mainBanner);

	//배너 삭제
	public void deleteBanner(int bannerNo);
	
	
	
  public List<String> userIdList(String abc);

  public List<SellerInfo> nullUserInfo(List<String> idOfinfo);


  	public List<Message> getChatRoomNo(Paging paging);

	public List<Message> getChatMessage(int chatRoomNo);

  
	// sellerimg만 삭제하기
	public void sellerImgDelete(SellerBigdomInfo sbInfo);

	// 판매자 정보 이미지 제외하고 업데이트하기
	public void sellerUpdateWithoutImg(SellerBigdomInfo sbInfo);


  
	public int getChatListCurPage(HttpServletRequest req);



	public int getChatListTotalCount();
	
	
	//요청 파라미터에서 curPage 반환
	public int getReviewCurPage(HttpServletRequest req);
	
	//총 후기글 수 얻기
	public int getReviewTotalCount();
	
	//페이징 리스트 얻기
	public List<Review> getReviewPagingList(Paging paging);

	
	//후기 글 상세 조회
	public Review viewReview(int reviewno);

	//후기 댓글 리스트 얻기
	public List<ReviewReply> getReplyList(int reviewno);

	//후기 삭제
	public void deleteReview(int reviewno);

	//후기 댓글 쓰기
	public void replyWrite(ReviewReply reviewReply);

	//후기 댓글 삭제
	public void replyDelete(int replyNo);

	//후기 댓글 수정
	public void replyUpdate(ReviewReply reviewReply);
	
	//admin도 User DTO로 가져오기 위해서
	public User getAdminInfoUser(AdminInfo adminInfo);

	public int getRnum(Map map);

	public List<Message> getChatMessagePaging(Map map);

	public int getRnumMax(int chatRoomNo);
}

