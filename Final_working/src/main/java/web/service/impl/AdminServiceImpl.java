package web.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.AdminDao;
import web.dto.AdminInfo;
import web.dto.BigdomInfo;
import web.dto.BigdomSellerInfo;
import web.dto.BookListInfo;
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

	// --------------- 계정관리 ---------------
	@Override
	public List<SellerBigdomInfo> getSellerBigdomInfo(Paging paging) {
		return adminDao.selectSellerBigdomInfo(paging);
	}

	@Override
	public List<BuyerInfo> getBuyerInfoList(Paging paging) {
		return adminDao.selectBuyerInfoList(paging);
	}

	@Override
	public List<BigdomSellerInfo> getBigdomSellerInfo(Paging paging) {
		return adminDao.selectBigdomSellerInfo(paging);
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

	@Override
	public BigdomSellerInfo getBigdomInfo(BigdomSellerInfo bsl) {
		return adminDao.selectBigdomInfo(bsl);
	}

	@Override
	public void setBigdomInfo(BigdomInfo bigdomInfo) {
		adminDao.updateBigdomInfo(bigdomInfo);
	}
	// ------------------------------------ 계정관리 끝

	// ------ 계정관리 페이징 ------
	@Override
	public int getSellerInfoCurPage(HttpServletRequest req) {
		//요청파라미터 curPage 받기
		String param = req.getParameter("curPage");
	
		//null이나 ""이 아니면 int로 리턴
		if( param != null && !"".equals(param) ) {
			int curPage = Integer.parseInt(param);
			return curPage;
		}
		
		//null이나 ""면 0으로 반환하기
		return 0;
	}

	@Override
	public int getSellerInfoTotalCount() {
		return adminDao.selectSellerInfoCnt();
	}

	@Override
	public int getBuyerInfoCurPage(HttpServletRequest req) {
		//요청파라미터 curPage 받기
		String param = req.getParameter("curPage");
	
		//null이나 ""이 아니면 int로 리턴
		if( param != null && !"".equals(param) ) {
			int curPage = Integer.parseInt(param);
			return curPage;
		}
		
		//null이나 ""면 0으로 반환하기
		return 0;
	}

	@Override
	public int getBuyerInfoTotalCount() {
		return adminDao.selectBuyerInfoCnt();
	}

	@Override
	public int getBigdomInfoCurPage(HttpServletRequest req) {
		//요청파라미터 curPage 받기
		String param = req.getParameter("curPage");
	
		//null이나 ""이 아니면 int로 리턴
		if( param != null && !"".equals(param) ) {
			int curPage = Integer.parseInt(param);
			return curPage;
		}
		
		//null이나 ""면 0으로 반환하기
		return 0;
	}

	@Override
	public int getBigdomInfoTotalCount() {
		return adminDao.selectBigdomInfoCnt();
	}
	// ----------------------------- 계정관리 페이징 끝

	// ------------------ 판매자 빅이슈 관리 ------------------
	@Override
	public int getSellerLocInfoCurPage(HttpServletRequest req) {
		//요청파라미터 curPage 받기
		String param = req.getParameter("curPage");
	
		//null이나 ""이 아니면 int로 리턴
		if( param != null && !"".equals(param) ) {
			int curPage = Integer.parseInt(param);
			return curPage;
		}
		
		//null이나 ""면 0으로 반환하기
		return 0;
	}

	@Override
	public int getSellerLocInfoTotalCount() {
		return adminDao.selectSellerLocInfoCnt();
	}

	@Override
	public List<SellerLoc> getSellerLocList(Paging paging) {
		return adminDao.selectSellerLocInfoList(paging);
	}

	@Override
	public int getSellerLocInfoDeactivateCurPage(HttpServletRequest req) {
		//요청파라미터 curPage 받기
		String param = req.getParameter("curPage");
	
		//null이나 ""이 아니면 int로 리턴
		if( param != null && !"".equals(param) ) {
			int curPage = Integer.parseInt(param);
			return curPage;
		}
		
		//null이나 ""면 0으로 반환하기
		return 0;
	}

	@Override
	public int getSellerLocInfoDeactivateTotalCount() {
		return adminDao.selectSellerLocInfoDeactivateCnt();
	}

	@Override
	public List<SellerLoc> getSellerLocListDeactivate(Paging paging) {
		return adminDao.selectSellerLocInfoDeactivateList(paging);
	}

	@Override
	public int getSellerLocInfoActivateCurPage(HttpServletRequest req) {
		//요청파라미터 curPage 받기
		String param = req.getParameter("curPage");
	
		//null이나 ""이 아니면 int로 리턴
		if( param != null && !"".equals(param) ) {
			int curPage = Integer.parseInt(param);
			return curPage;
		}
		
		//null이나 ""면 0으로 반환하기
		return 0;
	}

	@Override
	public int getSellerLocInfoActivateTotalCount() {
		return adminDao.selectSellerLocInfoActivateCnt();
	}

	@Override
	public List<SellerLoc> getSellerLocListActivate(Paging paging) {
		return adminDao.selectSellerLocInfoActivateList(paging);
	}

	@Override
	public SellerLoc getSellerLocInfo(SellerLoc sellerloc) {
		return adminDao.selectSellerLocInfo(sellerloc);
	}

	@Override
	public List<BookListInfo> getBookListInfoAtBookview(String sellerId) {
		return adminDao.selectBookListInfoAtBookview(sellerId);
	}

	@Override
	public void putBookListInfoAtadminBook(BookListInfo bli) {
		adminDao.insertBookListInfoAtadminBook(bli);
	}

	@Override
	public void adminSellserUpdate(SellerLoc sellerLoc) {
		adminDao.adminSellserUpdate(sellerLoc);
	}

	@Override
	public String getSellerName(SellerLoc locInfo) {
		
		return adminDao.getSellerName(locInfo);
	}


  @Override
	public void insertList(SellerLoc sellerLoc) {
		adminDao.insertList(sellerLoc);
	}
  
	@Override
	public void deleteList(SellerLoc sellerLoc) {
		adminDao.deleteList(sellerLoc);
	}

	@Override
	public List<String> userIdList(String abc) {
		return adminDao.userIdList(abc);
	}

	@Override
	public List<SellerInfo> nullUserInfo(List<String> idOfinfo) {
		
		List<SellerInfo> list = new ArrayList<SellerInfo>();
				
			for(String i : idOfinfo) {
				list.addAll((adminDao.nullUserInfo(i)));
			}
		return list;
	}
	
}

