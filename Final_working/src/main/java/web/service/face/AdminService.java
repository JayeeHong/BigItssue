package web.service.face;

import java.util.List;

import web.dto.SellerLoc;

public interface AdminService {

	public List<SellerLoc> viewLoc(String zone);

	public List<SellerLoc> viewDetail(String station);
}
