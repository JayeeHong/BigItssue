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
	public List<SellerLoc> viewLoc(String zone) {
		return adminDao.viewLoc(zone);
	}

	@Override
	public List<SellerLoc> viewDetail(String station) {
		return adminDao.viewDetail(station);
	}
}
