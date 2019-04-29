package web.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.AdminDao;
import web.dto.SellerLoc;
import web.service.face.AdminService;

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
	public List<SellerLoc> viewDetail(String station) {
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
	
	
	
}
