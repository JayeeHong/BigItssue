package web.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
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
import web.dto.BookListInfo;
import web.dto.BuyerInfo;
import web.dto.MainBanner;
import web.dto.Message;
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
	@RequestMapping(value="/admin/info/seller")
	public void infoSeller(
			Model model, 
			HttpServletRequest req) { // 계정관리-판매자
		
		// 페이징처리
		// 현재 페이지 번호 얻기
		int curPage = adminService.getSellerInfoCurPage(req);
		// 총 게시글 수
		int totalCount = 0;

		// 총 게시글 수 얻기
		int cnt = adminService.getSellerInfoTotalCount();
		if(cnt==0) {
			totalCount = 1;
		} else {
			totalCount = cnt;
		}
		
		// 페이지 객체 생성
		Paging paging = new Paging(totalCount, curPage);
//		logger.info(paging.toString());
		
		List<SellerBigdomInfo> sellerbigdomList = adminService.getSellerBigdomInfo(paging);
		
		// sellerloc에 해당 판매자가 있는지 조회
		//	-> 비활성화 시킬때 null이 들어감
		List sellerStatusList = new ArrayList<>();
		for(int i=0; i<sellerbigdomList.size(); i++) {
			boolean sellerStatus = adminService.getSellerStatus(sellerbigdomList.get(i).getSellerId());
//			logger.info("bbbbbb:::::::::"+String.valueOf(sellerStatus));
			sellerStatusList.add(i, sellerStatus);
		}
		
		// --- 페이징 관련 ---
		model.addAttribute("paging", paging);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("curPage", curPage);
		// -------------------
		
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
		
		logger.info(sbInfo.toString());
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
	
	@RequestMapping(value="/admin/info/buyer")
	public void infoBuyer(
			Model model, 
			HttpServletRequest req) { // 계정관리-구매자
		
		// 페이징처리
		// 현재 페이지 번호 얻기
		int curPage = adminService.getBuyerInfoCurPage(req);
		// 총 게시글 수
		int totalCount = 0;

		// 총 게시글 수 얻기
		int cnt = adminService.getBuyerInfoTotalCount();
		if(cnt==0) {
			totalCount = 1;
		} else {
			totalCount = cnt;
		}
		
		// 페이지 객체 생성
		Paging paging = new Paging(totalCount, curPage);
//		logger.info(paging.toString());
		
		List<BuyerInfo> buyerList = adminService.getBuyerInfoList(paging);
		
		// --- 페이징 관련 ---
		model.addAttribute("paging", paging);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("curPage", curPage);
		
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
	
	@RequestMapping(value="/admin/info/bigdom")
	public void infoBigdom(
			Model model, 
			HttpServletRequest req) { // 계정관리-빅돔
		
		// 페이징처리
		// 현재 페이지 번호 얻기
		int curPage = adminService.getBigdomInfoCurPage(req);
		// 총 게시글 수
		int totalCount = 0;

		// 총 게시글 수 얻기
		int cnt = adminService.getBigdomInfoTotalCount();
		if(cnt==0) {
			totalCount = 1;
		} else {
			totalCount = cnt;
		}
		
		// 페이지 객체 생성
		Paging paging = new Paging(totalCount, curPage);
//		logger.info(paging.toString());
		
		List<BigdomSellerInfo> bigdomsellerList = adminService.getBigdomSellerInfo(paging);
		
		// --- 페이징 관련 ---
		model.addAttribute("paging", paging);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("curPage", curPage);
		// -------------------
		
		model.addAttribute("bigdomsellerList", bigdomsellerList);
	}
	
	@RequestMapping(value="/admin/info/bigdom/update", method=RequestMethod.GET)
	public void updateBigdom(BigdomSellerInfo bigdomInfo, Model model) {
		
//		logger.info(bsl.toString());
		
		bigdomInfo = adminService.getBigdomInfo(bigdomInfo);
		
		model.addAttribute("bigdomInfo", bigdomInfo);
	}
	
	@RequestMapping(value="/admin/info/bigdomUp", method=RequestMethod.GET)
	public String bigdomInfoUpdate(BigdomInfo bigdomInfo) {
		
		adminService.setBigdomInfo(bigdomInfo);
		
		return "redirect:/admin/info/bigdom/update?bigdomId="+bigdomInfo.getBigdomId();
	}
	
	@RequestMapping(value="/admin/seller/list", method=RequestMethod.GET)
	public void adminSellseView() { // 판매자 판매정보 관리

	}
	
	@RequestMapping(value="/admin/book/list", method=RequestMethod.GET)
	public void adminBooklist(
			Model model, 
			HttpServletRequest req) { // 판매자 빅이슈 관리
		
		// 페이징처리
		// 현재 페이지 번호 얻기
		int curPage = adminService.getSellerLocInfoCurPage(req);
		// 총 게시글 수
		int totalCount = 0;

		// 총 게시글 수 얻기
		int cnt = adminService.getSellerLocInfoTotalCount();
		if(cnt==0) {
			totalCount = 1;
		} else {
			totalCount = cnt;
		}
		
		// 페이지 객체 생성
		Paging paging = new Paging(totalCount, curPage);
//		logger.info(paging.toString());
		
		List<SellerLoc> sellerlocList = adminService.getSellerLocList(paging);

		// --- 페이징 관련 ---
		model.addAttribute("paging", paging);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("curPage", curPage);
		// -------------------
		
		model.addAttribute("sellerlocList", sellerlocList);
		
	}
	
	@RequestMapping(value="/admin/book/list/deactivate", method=RequestMethod.GET)
	public void adminBooklistDeactivate(
			Model model, 
			HttpServletRequest req) { // 판매자 빅이슈 관리-비활성화구역
		
		// 페이징처리
		// 현재 페이지 번호 얻기
		int curPage = adminService.getSellerLocInfoDeactivateCurPage(req);
		// 총 게시글 수
		int totalCount = 0;

		// 총 게시글 수 얻기
		int cnt = adminService.getSellerLocInfoDeactivateTotalCount();
		if(cnt==0) {
			totalCount = 1;
		} else {
			totalCount = cnt;
		}
		
		// 페이지 객체 생성
		Paging paging = new Paging(totalCount, curPage);
//		logger.info(paging.toString());
		
		List<SellerLoc> sellerlocListDeactivate = adminService.getSellerLocListDeactivate(paging);

		// --- 페이징 관련 ---
		model.addAttribute("paging", paging);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("curPage", curPage);
		// -------------------
		
		model.addAttribute("sellerlocListDeactivate", sellerlocListDeactivate);
		
	}
	
	@RequestMapping(value="/admin/book/list/activate", method=RequestMethod.GET)
	public void adminBooklistActivate(
			Model model, 
			HttpServletRequest req) { // 판매자 빅이슈 관리-활성화구역
		
		// 페이징처리
		// 현재 페이지 번호 얻기
		int curPage = adminService.getSellerLocInfoActivateCurPage(req);
		// 총 게시글 수
		int totalCount = 0;

		// 총 게시글 수 얻기
		int cnt = adminService.getSellerLocInfoActivateTotalCount();
		if(cnt==0) {
			totalCount = 1;
		} else {
			totalCount = cnt;
		}
		
		// 페이지 객체 생성
		Paging paging = new Paging(totalCount, curPage);
		logger.info(paging.toString());
		
		List<SellerLoc> sellerlocListActivate = adminService.getSellerLocListActivate(paging);

		// --- 페이징 관련 ---
		model.addAttribute("paging", paging);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("curPage", curPage);
		// -------------------
		
		model.addAttribute("sellerlocListActivate", sellerlocListActivate);
		
	}
	
	@RequestMapping(value="/admin/book/view", method=RequestMethod.GET)
	public void adminBookView(SellerLoc sellerloc, Model model) {
		
		// 해당 판매자의 정보 조회
		sellerloc = adminService.getSellerLocInfo(sellerloc);
		
		// 해당 판매자의 보유 빅이슈 정보 조회
		List<BookListInfo> bookList = adminService.getBookListInfoAtBookview(sellerloc.getSellerId());
		
		model.addAttribute("sellerloc", sellerloc);
		model.addAttribute("bookList", bookList);
		
	}
	
	@RequestMapping(value="/admin/book/addBook", method=RequestMethod.POST)
	public String adminBookAdd(BookListInfo bli) {
		
//		logger.info("bli:::::::::::::::"+bli);
		// 빅이슈 정보 넣기
		adminService.putBookListInfoAtadminBook(bli);
		
		return "redirect:/admin/book/view?sellerId="+bli.getSellerId();
	}
	
	@RequestMapping(value="/admin/chat/list", method=RequestMethod.GET)
	public void adminChatlist(
			Message message,
			Model model,
			HttpServletRequest req) { // 채팅 내역 관리
		// 페이징처리
		// 현재 페이지 번호 얻기
		int curPage = adminService.getChatListCurPage(req);
		// 총 게시글 수
		int totalCount = 0;

		// 총 게시글 수 얻기
		int cnt = adminService.getChatListTotalCount();
		if(cnt==0) {
			totalCount = 1;
		} else {
			totalCount = cnt;
		}
		
		// 페이지 객체 생성
		Paging paging = new Paging(totalCount, curPage);
		//Chat 전체 조회
		List<Message> list = adminService.getChatRoomNo(paging);
		logger.info("Test : " + list.toString());
		logger.info("Test2 : "+list.size());
			
		logger.info(paging.toString());
		model.addAttribute("message", list);
		
		model.addAttribute("paging", paging);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("curPage", curPage);
	}
	
	@RequestMapping(value="/admin/chat/view", method=RequestMethod.GET)
	public void adminChatDetail(
			int chatRoomNo,
			Message message,
			Model model) {
		
		List<Message> list = adminService.getChatMessage(chatRoomNo);
		logger.info(String.valueOf(list));
		model.addAttribute("message", list);
		
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
			condition = null;
		}
//		if(condition == null) {
//			condition = "zone";
//		}
		
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
		
		SellerLoc locInfo = adminService.getSellerInfo(sellerloc);
		model.addAttribute("sellerInfo", locInfo);

		if(locInfo.getSellerId() != null) {
		String sellerName = adminService.getSellerName(locInfo);
		
		model.addAttribute("sellerName", sellerName);
		}
	}
	
	@RequestMapping(value="/admin/seller/view", method=RequestMethod.POST)
	public String adminSellserUpdate(SellerLoc sellerLoc,
									String arrZone,
									String sellerName) {
		
		logger.info(sellerLoc.toString());
		logger.info(arrZone);
		
		String[] a = arrZone.split(","); //arrZone의 값을 a라는 배열에 ','로 나누어 저장한다.
		String zoneString = "";
		
		for(String b : a) { //배열 a를 String b로 하나씩 나눈다.
			String c = b.replace("호선", ""); //나눈 b에 "호선"이라는 단어가 붙는다면 없애고 c라는 변수에담는다.
			zoneString += c; //c를 zoneString에 담는다.
			zoneString += "/";//   '/'를 붙인다.
		}
		
//		logger.info(zoneString);//확인용
		String zone = zoneString.substring(0, zoneString.length()-1);// 맨마지막에 붙는 '/'를 지운다.
		sellerLoc.setZone(zone);//완성된 zone을 sellerLoc객체에 담는다.
		
		String sellerTimeS = sellerLoc.getStartTime1();//sellerTimeS에 값을 저장한다.
				sellerTimeS += sellerLoc.getStartTime2();	
		sellerLoc.setSellerTimeS(sellerTimeS);
				
		
		String sellerTimeE = sellerLoc.getEndTime1(); //sellerTimesE에 값을 저장한다.
				sellerTimeE += sellerLoc.getEndTime2();	
		sellerLoc.setSellerTimeE(sellerTimeE);
				
//		logger.info("완성된 sellerLoc확인용"+sellerLoc.toString());
		
		//sellerLoc DB변경
		adminService.adminSellserUpdate(sellerLoc);
		
		
		return "redirect:/admin/seller/view?locNo="+sellerLoc.getLocNo();
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
			model.addAttribute("zone", zone);
		}
		
	}
	

	//판매지역 상세보기
	@RequestMapping(value="/admin/loc/detail", method=RequestMethod.GET)
	public void locDetail(String zone, String station, Model model) {
		logger.info("station : "+station);
		
		if(station != null) {
			List<HashMap> list = adminService.viewDetail(station);
			logger.info((String)list.get(0).get("SELLERID"));
//				logger.info(String.valueOf(list));
			logger.info(""+list);
			logger.info(String.valueOf(list.isEmpty()));
			logger.info("TEST");
			model.addAttribute("detailList", list);
			model.addAttribute("zone", zone);
			model.addAttribute("station", station);
		}
	}
	
	@RequestMapping(value="/admin/review/list", method=RequestMethod.GET)
	public void adminReviewlist() { // 후기게시판 관리
		
	}
	
	@RequestMapping(value="/admin/report/list", method=RequestMethod.GET)
	public void adminReportlist() { // 신고내역 관리
		
	}
	
	
	//메인배너관리
	@RequestMapping(value="/admin/banner/list", method=RequestMethod.GET)
	public void adminBannerList(MainBanner mainBanner, Model model) {
		
		logger.info("배너관리");
		
		List<MainBanner> bannerList = adminService.getBanner();
		model.addAttribute("bannerList", bannerList);
		
	}
	
	@RequestMapping(value="/admin/banner/write", method=RequestMethod.GET)
	public String bannerWrite() {
		return "admin/banner/write";
	}
	
	@RequestMapping(value="/admin/banner/write", method=RequestMethod.POST)
	public String bannerWriteProc(MainBanner mainBanner) {
		
		adminService.writeBanner(mainBanner);
		
		return "redirect:/admin/banner/list";
	}
	
	@RequestMapping(value="/admin/banner/delete", method=RequestMethod.GET)
	public void bannerDelete(MainBanner mainBanner, HttpServletRequest req) {
		
		int bannerNo = Integer.parseInt(req.getParameter("bannerNo"));
//		adminService.deleteBanner(bannerNo);
	}
	
	
	//판매장소 추가할 때 필요한 지도
	@RequestMapping(value="/insertList", method=RequestMethod.GET)
	public void showInsertMap(
			String keyword, //검색 이후의 값 전달
			Model model) {
		
		model.addAttribute("keyword", keyword);
	}
	
	//판매장소 추가될 Mapping
	@RequestMapping(value="/insertList", method=RequestMethod.POST)
	public String insertList(
			String keyword,
			String station,
			String zone,
			String spot,
			String lat,
			String lng,
			SellerLoc sellerLoc
			) {
		logger.info("TEST : "+station+", "+zone+", "+spot+", "+lat+", "+lng);
		sellerLoc.setStation(station);
		sellerLoc.setZone(zone);
		sellerLoc.setSpot(spot);
		sellerLoc.setLat(Double.valueOf(lat));
		sellerLoc.setLng(Double.valueOf(lng));
		logger.info(String.valueOf(sellerLoc));
		
		adminService.insertList(sellerLoc);
		logger.info("[CHK] : 입력 성공");
		return "redirect:/admin/loc/list";
	}
	
	
	@RequestMapping("/deleteList")
	public String deleteList(
			String station,
			String spot,
			SellerLoc sellerLoc
			) {
		sellerLoc.setStation(station);
		sellerLoc.setSpot(spot);
		
		adminService.deleteList(sellerLoc);
		
		return "admin/loc/list";
	}


	
	
	@RequestMapping(value="/admin/seller/select", method=RequestMethod.GET)
	public void selectUserForm(Model model) {
		
		List<String> idOfinfo = adminService.userIdList("sellerInfo"); 
		List<String> idOfLocList = adminService.userIdList("sellerLoc");
		
		for(String i : idOfLocList) {
			idOfinfo.remove(i);
		}
		List<SellerInfo> infoList = adminService.nullUserInfo(idOfinfo);
		
		
		System.out.println(infoList);
		model.addAttribute("sellerInfo", infoList);
		
		
	}
	
	
	
	@RequestMapping("revSpot")
	public void revisionSpot(
			SellerLoc sellerLoc,
			String station,
			String spot,
			Model model) {
		
		sellerLoc.setStation(station);
		sellerLoc.setSpot(spot);
		
		SellerLoc selLoc = adminService.getSellerInfo(sellerLoc);
		logger.info("TEST : "+String.valueOf(selLoc));
		model.addAttribute("sellerLoc", selLoc);
	}
	
}
