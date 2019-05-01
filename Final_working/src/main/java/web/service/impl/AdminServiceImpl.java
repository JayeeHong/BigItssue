package web.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.AdminDao;
import web.dto.AdminInfo;
import web.dto.BigdomInfo;
import web.dto.BigdomSellerInfo;
import web.dto.BuyerInfo;
import web.dto.Notice;
import web.dto.SellerBigdomInfo;
import web.dto.SellerInfo;
import web.dto.SellerLoc;
import web.service.face.AdminService;
import web.util.Paging;

@Service
public class AdminServiceImpl implements AdminService{

	@Autowired AdminDao adminDao;
	
	@Override
	public int getTotalCount(HashMap doubleString) {
		
		return adminDao.getTotalCount(doubleString);
	}

	@Override
	public List<SellerLoc> getPagingList(HashMap map) {
		// TODO Auto-generated method stub
		return adminDao.getPagingList(map);
	}

	@Override
	public void adminSellerListDelete(SellerLoc sellerLoc) {
		adminDao.adminSellerListDelete(sellerLoc);
		
	}

	@Override
	public SellerLoc getSellerInfo(SellerLoc sellerloc) {
		return adminDao.getSellerInfo(sellerloc);
		
	}
	
	
	@Override
	public List<SellerLoc> viewLoc(String zone) {
		return adminDao.viewLoc(zone);
	}

	@Override
	public List viewDetail(String station) {
		return adminDao.viewDetail(station);
	}
	//
	@Override
	public int getNoticeCount() {
		return adminDao.getNoticeCount();
	}

	@Override
	public List<Notice> getNoticeList(Paging p) {
		return adminDao.getNoticeList(p);
	}

	@Override
	public Notice noticeView(Notice notice) {
		
		return adminDao.noticeView(notice);
	}

	@Override
	public void adminNoticeDelete(Notice notice) {
		adminDao.adminNoticeDelete(notice);
		
	}
  
	@Override
	public void noticeInsert(Notice notice) {
		adminDao.noticeInsert(notice);
		
	}

	@Override
	public void addHit(Notice notice) {
		adminDao.addHit(notice);
		
	}

	@Override
	public void noticeUpdate(Notice notice) {
		adminDao.noticeUpdate(notice);
		
	}

	@Override
	public boolean login(AdminInfo adminInfo) {
		if(adminDao.selectCntLogin(adminInfo) > 0) {
			return true;
			
		} else {
			return false;
			
		}
	}

	@Override
	public List<SellerBigdomInfo> getSellerBigdomInfo() {
		return adminDao.selectSellerBigdomInfo();
	}

	@Override
	public List<BuyerInfo> getBuyerInfoList() {
		return adminDao.selectBuyerInfoList();
	}

	@Override
	public List<BigdomSellerInfo> getBigdomSellerInfo() {
		return adminDao.selectBigdomSellerInfo();
	}

	@Override
	public SellerBigdomInfo getSellerBigdomInfo(String sellerId) {
		return adminDao.selectSBInfo(sellerId);
	}

	@Override
	public void sellerUpdate(SellerBigdomInfo sbInfo) {
		adminDao.updateSellerInfo(sbInfo);
	}

//	@Override
//	public void sellerDelete(String sellerId) {
//		adminDao.deleteSellerInfo(sellerId);
//	}

	@Override
	public void setSellerAndBigdomNull(String sellerId) {
		adminDao.updateSellerAndBigdomNull(sellerId);
	}

	@Override
	public boolean getSellerStatus(String sellerId) {
		if(adminDao.selectSellerStatus(sellerId)>0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public boolean getBigdomStatus(SellerBigdomInfo sbList) {
		if(adminDao.selectBigdomStatus(sbList)>0) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public void deactivateBigdom(SellerBigdomInfo sbInfo) {
		adminDao.updateBigdomDeactivate(sbInfo);
	}

	@Override
	public void activateBigdom(SellerBigdomInfo sbInfo) {
		adminDao.updateBigdomActivate(sbInfo);
	}

	@Override
	public String getLastSeller() {
		return adminDao.selectLastSeller();
	}

	@Override
	public void putNewBigdom(BigdomInfo bigdomInfo) {
		adminDao.insertNewBigdom(bigdomInfo);
	}

	@Override
	public void putNewSeller(SellerInfo sellerInfo) {
		adminDao.insertNewSeller(sellerInfo);
	}

	@Override
	public SellerInfo getLastSellerInfo() {
		return adminDao.selectLastSellerInfo();
	}

	@Override
	public BuyerInfo getBuyerInfo(String buyerId) {
		return adminDao.selectBuyerInfo(buyerId);
	}

	@Override
	public void setBuyerInfo(BuyerInfo buyerInfo) {
		adminDao.updateBuyerInfo(buyerInfo);
	}

	@Override
	public void delBuyerInfo(BuyerInfo buyerInfo) {
		adminDao.deleteBuyerInfo(buyerInfo);
	}

}

