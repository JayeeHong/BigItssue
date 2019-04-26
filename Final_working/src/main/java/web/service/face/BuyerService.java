package web.service.face;

import java.util.List;

import web.dto.BuyerInfo;
import web.dto.User;
import web.util.SellerLocPaging;

public interface BuyerService {
	public boolean haveId(BuyerInfo bi);

	public void buyerJoin(BuyerInfo buyerInfo);

	public boolean buyerLogin(BuyerInfo buyerInfo);

	public void mailSender(String email, String subject, String body);

	public BuyerInfo buyerFindId(BuyerInfo buyerInfo); //정보 2개로 조회 id찾기

	public int buyerCnt(BuyerInfo buyerInfo);//정보 2개로 조회 id찾기 있는지 없는지 COUNT(*)

	public BuyerInfo buyerFindInfo(BuyerInfo buyerInfo); //정보 3개로 조회 비밀번호 찾기

	public int buyerFindCnt(BuyerInfo buyerInfo);//정보 3개로 조회 비밀번호 찾기 있는지 없는지 COUNT(*)

	public void pwUpdate(BuyerInfo buyerInfo);

	public int eamilSerch(String email);
	
	//buyerId로 Buyer정보 검색(반환User)
	public User getBuyerInfo(BuyerInfo buyerInfo);
	
	//-----SellerLoc-----
	//판매처 총 게시글 수 얻기
	public int getTotalCountOfSellerLoc();
	
	//판매처 페이징 리스트 얻기
	public List getPagingListOfSellerLoc(SellerLocPaging paging);
	
}
