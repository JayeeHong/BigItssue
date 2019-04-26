package web.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.BigdomDao;
import web.dto.BigdomInfo;
import web.service.face.BigdomService;

@Service
public class BigdomServiceImpl implements BigdomService {
	
	@Autowired BigdomDao bigdomDao;

	@Override
	public boolean login(BigdomInfo bigdomInfo) {
		
		if(bigdomDao.selectCntLogin(bigdomInfo) > 0) {
			return true;
		} else {
			return false;
		}
		
	}

	@Override
	public BigdomInfo getBigdomInfo(String bigdomId) {
		return bigdomDao.selectBigdomInfo(bigdomId);
	}

}
