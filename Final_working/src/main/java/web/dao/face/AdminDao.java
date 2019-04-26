package web.dao.face;

import java.util.List;

import web.dto.SellerLoc;

public interface AdminDao {

	public List<SellerLoc> viewLoc(String zone);

	public List<SellerLoc> viewDetail(String station);
}
