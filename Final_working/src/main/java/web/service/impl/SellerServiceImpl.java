package web.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.SellerDao;
import web.dto.BookListInfo;
import web.dto.Reservation;
import web.dto.Review;
import web.dto.ReviewReply;
import web.dto.SellerInfo;
import web.dto.SellerLoc;
import web.dto.User;
import web.service.face.SellerService;
import web.util.Paging;

@Service
public class SellerServiceImpl implements SellerService {
	
	@Autowired SellerDao sellerDao;

	@Override
	public boolean login(SellerInfo sellerInfo) {
		
		if(sellerDao.selectCntLogin(sellerInfo) > 0) {
			return true;
			
		} else {
			return false;
			
		}
		
	}

	@Override
	public SellerInfo getSellerInfo(String sellerId) {
		return sellerDao.selectSellerInfo(sellerId);
	}

	@Override
	public SellerLoc getSellerLoc(String sellerId) {
		return sellerDao.selectSellerLoc(sellerId);
	}

	@Override
	public List<BookListInfo> getBookList(String sellerId) {
		return sellerDao.selectBookList(sellerId);
	}

	@Override
	public void setMegazine(BookListInfo bookListInfo) {
		sellerDao.updateBookList(bookListInfo);
	}

	@Override
	public void deleteMegazine(int magazineNo) {
		sellerDao.deleteMegazine(magazineNo);
	}

	@Override
	public void putMegazine(BookListInfo bookListInfo) {
		sellerDao.insertMegazine(bookListInfo);
	}

	@Override
	public void setSellerTime(SellerLoc sellerLoc) {
		sellerDao.updateSellerTime(sellerLoc);
	}

	@Override
	public List<Reservation> getReserve(String sellerId) {
		return sellerDao.selectReserve(sellerId);
	}

	@Override
	public void cancelReserve(int reserveNo) {
		sellerDao.updateToCancelReserve(reserveNo);
	}

	@Override
	public void updateReserve(int reserveNo) {
		sellerDao.updateToCompleteReserve(reserveNo);
	}

	@Override
	public void setPickupDate(Reservation bookList) {
		sellerDao.updatePickupDate(bookList);
	}

	@Override
	public void setStartTime(SellerLoc sellerLoc) {
		sellerDao.updateStartTime(sellerLoc);
	}

	@Override
	public void setEndTime(SellerLoc sellerLoc) {
		sellerDao.updateEndTime(sellerLoc);
	}

	@Override
	public User getSellerInfoUser(SellerInfo sellerInfo) {
		return sellerDao.selectSellerInfoUser(sellerInfo);
	}
	
	
	@Override
	public int getCurPage(HttpServletRequest req) {
		
		//요청파라미터 curPage 받기
		String param = req.getParameter("curPage");
		
		//null이나 ""이 아니면 int로 리턴
		if( param != null && !"".equals(param) ) {
			int curPage = Integer.parseInt(param);
			return curPage;
		}
		
		//null이나 ""이면 0으로 반환
		return 0;
	}

	@Override
	public int getTotalCount() {
		return sellerDao.selectCntReview();
	}

	@Override
	public List<Review> getPagingList(Paging paging) {
		return sellerDao.selectPaginglist(paging);
	}

	@Override
	public void write(Review review) {
		sellerDao.insert(review);
	}

	@Override
	public Review view(int reviewno) {
		
		//조회수 증가
		
		sellerDao.updateHit(reviewno);
		
		//상세글 반환
		return sellerDao.selectReviewByReviewno(reviewno);
	}

	@Override
	public void update(Review review) {
		sellerDao.updateReview(review);
	}

	@Override
	public void delete(int reviewno) {
		sellerDao.deleteReview(reviewno);
	}

	@Override
	public int getMyTotalCount(Review review) {
		return sellerDao.selectCntMyReview(review);
	}

	@Override
	public List<Review> getPagingMyList(Paging paging) {
		return sellerDao.selectPagingMylist(paging);
	}

	@Override
	public List<ReviewReply> getReplyList(int reviewno) {
		return sellerDao.selectReplyListByReviewNo(reviewno);
	}

	@Override
	public void replyWrite(ReviewReply reviewReply) {
		sellerDao.insertReply(reviewReply);
	}

	@Override
	public void replyDelete(int replyNo) {
		sellerDao.deleteReply(replyNo);
	}

	@Override
	public void replyUpdate(int replyNo) {
		sellerDao.updateReply(replyNo);
	}

}
