package web.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

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

@Controller
public class AdminController {
	@Autowired ServletContext context;
	@Autowired AdminService adminService;
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@RequestMapping(value="/admin/main", method=RequestMethod.GET)
	public void adminMain() {

	}
	
	@RequestMapping(value="/admin/login", method=RequestMethod.POST)
	public String adminLogin(AdminInfo adminInfo, HttpSession session) { // 로그인
		
//		logger.info("adminInfo::"+adminInfo.toString());
		
		// 관리자 로그인
		if(adminService.login(adminInfo)) { // 로그인 성공 시
			session.setAttribute("adminLogin", true);
			session.setAttribute("adminId", adminInfo.getAdminId());
			
		}
		
		return "redirect:/admin/main";
	}
	
	@RequestMapping(value="/admin/logout", method=RequestMethod.GET)
	public String adminLogout(HttpSession session) { // 로그아웃
		session.invalidate();
		
		return "redirect:/admin/main";
	}
	
	@RequestMapping(value="/admin/info/seller", method=RequestMethod.GET)
	public void infoSeller(Model model) { // 계정관리-판매자
		List<SellerBigdomInfo> sellerbigdomList = adminService.getSellerBigdomInfo();
		
		// sellerloc에 해당 판매자가 있는지 조회
		//	-> 비활성화 시킬때 null이 들어감
		List sellerStatusList = new ArrayList<>();
		for(int i=0; i<sellerbigdomList.size(); i++) {
			boolean sellerStatus = adminService.getSellerStatus(sellerbigdomList.get(i).getSellerId());
//			logger.info("bbbbbb:::::::::"+String.valueOf(sellerStatus));
			sellerStatusList.add(i, sellerStatus);
		}
		
		model.addAttribute("sellerStatusList", sellerStatusList);
		model.addAttribute("sellerbigdomList", sellerbigdomList);
	}
	
	@RequestMapping(value="/admin/info/seller/add", method=RequestMethod.GET)
	public String addSeller(SellerInfo sellerInfo, BigdomInfo bigdomInfo, Model model) { // 계정관리-판매자_추가
		
		// sellerinfo의 마지막행 조회
		String sellerId = adminService.getLastSeller();
//		logger.info("sellerID:::::::::::"+sellerFromDb);
		
		// 마지막행에서 숫자만 가져오기
		String newNo = "";
		newNo += sellerId.substring(6);
		int no = Integer.parseInt(newNo)+1;
//		logger.info(sellerId);
		
		// 가져온 숫자+1 -> 빅돔 아이디로 추가(빅돔아이디:fk-빅돔아이디 추가가 먼저)
		bigdomInfo.setBigdomId("bigdom"+no);
		bigdomInfo.setBigdomPw("pw"+no);
		bigdomInfo.setSort("빅돔");
		adminService.putNewBigdom(bigdomInfo);
		
		// 가져온 숫자+1 -> 판매자 아이디로 추가
		sellerInfo.setSellerId("seller"+no);
		sellerInfo.setSellerPw("pw"+no);
		sellerInfo.setSellerName("판매자"+no);
		sellerInfo.setSort("판매자");
		sellerInfo.setBigdomId("bigdom"+no);
		adminService.putNewSeller(sellerInfo);
		
		sellerInfo = adminService.getLastSellerInfo();
		
		model.addAttribute("sellerInfo", sellerInfo);
		
		return "redirect:/admin/info/seller/update?sellerId="+sellerInfo.getSellerId();
	}
	
	@RequestMapping(value="/admin/info/seller/update", method=RequestMethod.GET)
	public void infoSellerUpdate(SellerBigdomInfo sbInfo, Model model) { // 계정관리-판매자 수정페이지
//		logger.info(sbInfo.toString());
		
		// sellerid로 정보 조회
		SellerBigdomInfo sbList = adminService.getSellerBigdomInfo(sbInfo.getSellerId());
//		logger.info(sbList.toString());
		
		String sellerPhone = sbList.getSellerPhone();
		if(sellerPhone != null && !"".equals(sellerPhone)) {
			sbList.setSellerPhone1(sellerPhone.split("-")[0]);
			sbList.setSellerPhone2(sellerPhone.split("-")[1]);
			sbList.setSellerPhone3(sellerPhone.split("-")[2]);
		}
		
		// sellerloc에 해당 판매자가 있는지 조회
		//	-> 비활성화 시킬때 null이 들어감
		boolean sellerStatus = adminService.getSellerStatus(sbInfo.getSellerId());
//		logger.info(String.valueOf(sellerStatus));
		
		// sellerloc에 해당판매자의 빅돔이 있는지 조회
		boolean bigdomStatus = adminService.getBigdomStatus(sbList);
//		logger.info(String.valueOf(bigdomStatus));
		
		model.addAttribute("sbList", sbList);
		model.addAttribute("sellerStatus", sellerStatus);
		model.addAttribute("bigdomStatus", bigdomStatus);
	}
	
	@RequestMapping(value="/admin/info/sellerUp", method=RequestMethod.GET)
	public String infoSellerUp(SellerBigdomInfo sbInfo) { // 계정관리-판매자_정보수정
		
		sbInfo.setSellerPhone(sbInfo.getSellerPhone1()+"-"+sbInfo.getSellerPhone2()+"-"+sbInfo.getSellerPhone3());
//		logger.info("ssssss::::::"+sbInfo.toString());
		// sellerid로 해당 판매자 정보 업데이트
		adminService.sellerUpdate(sbInfo);
		
		return "redirect:/admin/info/seller/update?sellerId="+sbInfo.getSellerId();
	}
	
	@RequestMapping(value="/admin/info/deactivateSeller", method=RequestMethod.GET)
	public String deactivateSeller(SellerBigdomInfo sbInfo) { // 계정관리-판매자_비활성화
		
//		logger.info(sbInfo.toString());
		// sellerid로 해당 판매자 정보 삭제
//		adminService.sellerDelete(sbInfo.getSellerId());
		
		// sellerloc 테이블에 해당 판매자, 빅돔 null로 설정(비활성화)
		adminService.setSellerAndBigdomNull(sbInfo.getSellerId());
		
		return "redirect:/admin/info/seller/update?sellerId="+sbInfo.getSellerId();
	}
	
	@RequestMapping(value="/admin/info/deactivateBigdom", method=RequestMethod.GET)
	public String deactivateBigdom(SellerBigdomInfo sbInfo) { // 계정관리-판매자_빅돔비활성화
		
//		logger.info("빅돔비활성화:::::::::"+sbInfo.toString());
		// sellerid의 bigdomid null로 설정(비활성화)
		adminService.deactivateBigdom(sbInfo);
		
		return "redirect:/admin/info/seller/update?sellerId="+sbInfo.getSellerId();
	}
	
	@RequestMapping(value="/admin/info/activateBigdom", method=RequestMethod.GET)
	public String activateBigdom(SellerBigdomInfo sbInfo) { // 계정관리-판매자_빅돔비활성화
		
//		logger.info("빅돔활성화:::::::::"+sbInfo.toString());
		// sellerid에 맞는 bigdomid 활성화
		adminService.activateBigdom(sbInfo);
		
		return "redirect:/admin/info/seller/update?sellerId="+sbInfo.getSellerId();
	}
	
	@RequestMapping(value="/admin/info/buyer", method=RequestMethod.GET)
	public void infoBuyer(Model model) { // 계정관리-구매자
		List<BuyerInfo> buyerList = adminService.getBuyerInfoList();
		
		model.addAttribute("buyerList", buyerList);
	}
	
	@RequestMapping(value="/admin/info/buyer/update", method=RequestMethod.GET)
	public void updateBuyer(BuyerInfo buyerInfo, Model model) { // 계정관리-구매자_수정페이지
		buyerInfo = adminService.getBuyerInfo(buyerInfo.getBuyerId());
		
//		logger.info("구매자 정보:::::::"+buyerInfo.toString());
		String buyerPhone = buyerInfo.getBuyerPhone();
		if(buyerPhone != null && !"".equals(buyerPhone)) {
			buyerInfo.setBuyerPhone1(buyerPhone.split("-")[0]);
			buyerInfo.setBuyerPhone2(buyerPhone.split("-")[1]);
			buyerInfo.setBuyerPhone3(buyerPhone.split("-")[2]);
		}
		
		String buyerEmail = buyerInfo.getBuyerEmail();
		if(buyerEmail != null && !"".equals(buyerEmail)) {
			buyerInfo.setBuyerEmail1(buyerEmail.split("@")[0]);
			buyerInfo.setBuyerEmail2(buyerEmail.split("@")[1]);
		}
		
		model.addAttribute("buyerInfo", buyerInfo);
	}
	
	@RequestMapping(value="/admin/info/buyerUp", method=RequestMethod.GET)
	public String buyerInfoUpdate(BuyerInfo buyerInfo) { // 계정관리-구매자 정보 수정하기
		
		buyerInfo.setBuyerPhone(buyerInfo.getBuyerPhone1()+"-"+buyerInfo.getBuyerPhone2()+"-"+buyerInfo.getBuyerPhone3());
		buyerInfo.setBuyerEmail(buyerInfo.getBuyerEmail1()+"@"+buyerInfo.getBuyerEmail2());
//		logger.info("구매자 수정::::::"+buyerInfo.toString());
		
		// 수정한 구매자 정보 디비에 저장
		adminService.setBuyerInfo(buyerInfo);
		
		return "redirect:/admin/info/buyer/update?buyerId="+buyerInfo.getBuyerId();
	}
	
	@RequestMapping(value="/admin/info/buyerDel", method=RequestMethod.GET)
	public String buyerInfoDelete(BuyerInfo buyerInfo) {
		
//		logger.info("구매자 삭제:::::::::"+buyerInfo.toString());
		
		// 구매자 정보 삭제
		adminService.delBuyerInfo(buyerInfo);
		
		return "redirect:/admin/info/buyer";
	}
	
	@RequestMapping(value="/admin/info/bigdom", method=RequestMethod.GET)
	public void infoBigdom(Model model) { // 계정관리-빅돔
		List<BigdomSellerInfo> bigdomsellerList = adminService.getBigdomSellerInfo();
		
		model.addAttribute("bigdomsellerList", bigdomsellerList);
	}
	
	@RequestMapping(value="/admin/seller/list", method=RequestMethod.GET)
	public void adminSellseView() { // 판매자 판매정보 관리

	}
	
	@RequestMapping(value="/admin/book/list", method=RequestMethod.GET)
	public void adminBooklist() { // 판매자 빅이슈 관리
		
	}
	
	@RequestMapping(value="/admin/chat/list", method=RequestMethod.GET)
	public void adminChatlist() { // 채팅 내역 관리
		
	}
	
	@RequestMapping(value="/admin/seller/getSellerInfolist", method=RequestMethod.GET)
	public String getlist(
			Model model,
			Paging paging,
			String condition,
			String searchWord) {
		
		System.out.println("현재페이지"+paging.getCurPage());
		System.out.println("조건"+condition);
		System.out.println("단어"+searchWord);
		
		if(searchWord ==null) {
			searchWord = "";
		}
		if(condition == null) {
			condition = "zone";
		}
		
		//현재 페이지 번호 얻기
		int curPage = 0; 
		
		if(paging.getCurPage()!=0) {
		curPage = paging.getCurPage();
		}
		
		HashMap doubleString = new HashMap<String, String>();
		
		doubleString.put("condition", condition);
		doubleString.put("searchWord", searchWord);
		
		//총 게시글 수 얻기
		int totalCount = adminService.getTotalCount(doubleString);
		
		//페이지 객체 생성
		Paging p = new Paging(totalCount, curPage);
		
		HashMap map = new HashMap<String, Paging>();
		
		map.put("condition", condition);
		map.put("searchWord", searchWord);
		map.put("p", p);
		
		
		//게시글목록 MODEL로 추가
		List<SellerLoc> list = adminService.getPagingList(map);
		model.addAttribute("sellerLocList", list);
		model.addAttribute("paging", p);
		model.addAttribute("condition", condition);
		model.addAttribute("searchWord", searchWord);
		
		 
		return "jsonView";

		
	}
	
	@RequestMapping(value="/admin/seller/sellerInfoDelete", method=RequestMethod.GET)
	public String adminSellerListDelete(SellerLoc sellerLoc) {
		
		//삭제
		adminService.adminSellerListDelete(sellerLoc);
		
		return "jsonView";
	}
	
	@RequestMapping(value="/admin/seller/view", method=RequestMethod.GET)
	public void adminSellserView(
			Model model
			,SellerLoc sellerloc
			) {
		
		SellerLoc info = adminService.getSellerInfo(sellerloc);
		
		model.addAttribute("sellerInfo", info);
	}
	
	@RequestMapping(value="/admin/seller/view", method=RequestMethod.POST)
	public String adminSellserUpdate() {
		
		return "redirect:/admin/seller/view";
	}
	
	
	@RequestMapping(value="/admin/notice/list", method=RequestMethod.GET)
	public void adminNoticeList( // 공지사항 게시판 관리
			Model model) {
//		List<Notice> list = adminService.getNoticeList();
//		model.addAttribute("notice", list);
	}
	
	@RequestMapping(value="/admin/notice/getNoticeList", method=RequestMethod.GET)
	public String getNoticeList(Paging paging, Model model) {
		
		//현재 페이지 번호 얻기
				int curPage = 0; 
				
				if(paging.getCurPage()!=0) {
				curPage = paging.getCurPage();
				}
				
				
				
				//총 게시글 수 얻기
				int totalCount = adminService.getNoticeCount();
				
				//페이지 객체 생성
				Paging p = new Paging(totalCount, curPage);
				
				List<Notice> list = adminService.getNoticeList(p);
				
				
				System.out.println(list);
				
				model.addAttribute("notice", list);
				model.addAttribute("paging", p);
				
			return "jsonView";
	}
	
	//
	@RequestMapping(value="/admin/notice/view", method=RequestMethod.GET)
	public void adminNoticeView(Notice notice, Model model) {
		
			
		Notice no = adminService.noticeView(notice);//조회
		
		adminService.addHit(notice);//조회수1증가
		model.addAttribute("notice", no);
		
	}
	@RequestMapping(value="/admin/notice/write", method=RequestMethod.GET)
	public void noticeWriteForm() {
		
	}
	
	@RequestMapping(value="/admin/notice/write", method=RequestMethod.POST)
	public String noticeWriteInsert(
			String title,
			Notice notice,
			MultipartFile file
			) {

//				//고유 식별자
//				String uId = UUID.randomUUID().toString().split("-")[0];
//				//저장될 파일 이름
//				String stored_name = null;
//				stored_name = file.getOriginalFilename()+"_"+uId;
//				
//				upFile.setOrigin_name(file.getOriginalFilename());
//				upFile.setFile_size(file.getSize());
//				upFile.setStored_name(stored_name);
				
				logger.info(file.toString());
			
				System.out.println(file.getOriginalFilename());
				
				//파일 저장 경로
				String path = context.getRealPath("resources/image");
				
				//저장될 파일
				File dest = new File(path, file.getOriginalFilename());
				
				//이미지 이름 설정
				notice.setNoticeImg(file.getOriginalFilename());
				
				System.out.println(notice.toString());
				System.out.println("저장위치"+path);
				
					try {
						file.transferTo(dest);
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				
				
				adminService.noticeInsert(notice);
	
				return "redirect:/admin/notice/list";
				
	}
	
	
	@RequestMapping(value="/admin/notice/delete", method=RequestMethod.GET)
	public void adminNoticeDelete(Notice notice, HttpServletResponse res) throws IOException {
		
		PrintWriter out = null;
		res.setContentType("text/html; charset=UTF-8");
		out = res.getWriter();
		
		adminService.adminNoticeDelete(notice);
		
		out.println("<script>alert('삭제되었습니다.'); location.href='/admin/notice/list'</script>" );
		out.flush();
		
		
	}
	
	@RequestMapping(value="/admin/notice/update", method=RequestMethod.GET)
	public void noticeUpdateForm(Notice notice, Model model) {
		
		Notice no = adminService.noticeView(notice);//조회
		
		
		model.addAttribute("notice", no);
		
	}

	@RequestMapping(value="/admin/notice/update", method=RequestMethod.POST)
	public String noticeUpdate(Notice notice, Model model, MultipartFile file) {
		
		
		logger.info(notice.toString());
		
		
		//이미지를 삭제했을경우
		if(notice.getNoticeImg()=="") {
			notice.setNoticeImg(null);
		}
		
		//이미지를 수정했을 경우
		else if(!file.getOriginalFilename().equals(notice.getNoticeImg())) {
			
			notice.setNoticeImg(file.getOriginalFilename());
		
		String path = context.getRealPath("resources/image");
		
		//저장될 파일
		File dest = new File(path, file.getOriginalFilename());
		
		//이미지 이름 설정
		notice.setNoticeImg(file.getOriginalFilename());
		
		
			try {
				file.transferTo(dest);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		adminService.noticeUpdate(notice);

		
		return "redirect:/admin/notice/view?noticeNo="+notice.getNoticeNo();
		
	}
	
	//판매지역
	@RequestMapping(value="/admin/loc/list", method=RequestMethod.GET)
	public void locList(String zone, Model model) { // 판매장소 관리
		logger.info("zone : " + zone);
		
		//현재 DB에 입력된 판매지역
		if(zone != null) {
			//검색어 split
			String[] zon = zone.split("호선");
			
			//zon[0]을 통한 역 조회
			List<SellerLoc> list = adminService.viewLoc(zon[0]);
			
			logger.info(String.valueOf(list));
			model.addAttribute("locList", list);
		}
		
	}
	

	//판매지역 상세보기
	@RequestMapping(value="/admin/loc/detail", method=RequestMethod.GET)
	public void locDetail(String station, Model model) {
		logger.info("station : "+station);
		
		if(station != null) {
			List<HashMap> list = adminService.viewDetail(station);
			logger.info((String)list.get(0).get("SELLERID"));
//				logger.info(String.valueOf(list));
			logger.info(""+list);
			logger.info("TEST");
			model.addAttribute("detailList", list);
			model.addAttribute("station", station);
		}
	}
	
	@RequestMapping(value="/admin/review/list", method=RequestMethod.GET)
	public void adminReviewlist() { // 후기게시판 관리
		
	}
	
	@RequestMapping(value="/admin/report/list", method=RequestMethod.GET)
	public void adminReportlist() { // 신고내역 관리
		
	}
	
	@RequestMapping(value="/admin/banner/list", method=RequestMethod.GET)
	public void adminBannerlist() { // 배너관리
		
	}
}
