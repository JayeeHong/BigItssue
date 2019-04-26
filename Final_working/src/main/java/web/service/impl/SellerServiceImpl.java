package web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.SellerDao;
import web.dto.BookListInfo;
import web.dto.Reservation;
import web.dto.SellerInfo;
import web.dto.SellerLoc;
import web.service.face.SellerService;

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

}
