﻿package web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.RequestParam;

import web.dto.BookListInfo;
import web.dto.BuyerInfo;
import web.dto.Chat;
import web.dto.MainBanner;
import web.dto.Message;
import web.dto.Notice;
import web.dto.MessageChk;
import web.dto.Reservation;
import web.dto.ReviewReply;
import web.dto.SellerLoc;
import web.dto.User;
import web.service.face.BuyerService;
import web.service.face.ChatService;
import web.util.MyBookingPaging;
import web.util.Paging;
import web.util.SellerLocPaging;

@Controller
public class BuyerController {
	
	private static final Logger logger = LoggerFactory.getLogger(BuyerController.class);
	
	@Autowired BuyerService buyerService;
	@Autowired ChatService chatService;

	@RequestMapping(value="/buyer/main", method=RequestMethod.GET)
	public void buyerMainGet(
			String zoneSelect, 
			String stationSelect,
			@RequestParam(defaultValue="0") String curPage,
			Model model) { 
		
		//현재 페이지 번호 얻기
		logger.info("curPage:"+curPage);
		if(stationSelect == null) {
			stationSelect="";
		}
		//총 게시글 수 얻기(map을 통해 파라미터 전달) 검색되고 다시 페이지번호 누르면 GET방식으로 오기때문에 map을통해서 zone,station조건으로 조회
		Map<String, Object> map = new HashMap<String, Object>(); // MAP을 이용해 담기
        map.put("zoneSelect", zoneSelect);
        map.put("stationSelect", stationSelect);
		int totalCount = buyerService.getTotalCountOfSellerLocByZoneAndStation(map);
		
		logger.info("totalCount:"+totalCount);
		
		//페이지 객체 생성
		SellerLocPaging paging = new SellerLocPaging(totalCount, Integer.parseInt(curPage));
		//paging에 zoneSelect,stationSelect추가
		paging.setZone(zoneSelect);
		paging.setStation(stationSelect);
		
		logger.info("paging:"+paging);
		
		List<SellerLoc> sellerLocList = buyerService.getPagingListOfSellerLocByZoneAndStation(paging);
		
		logger.info("sellerLocList:"+sellerLocList);
			
		//조회 결과를 VIEW에 전달하기
		model.addAttribute("sellerLocList", sellerLocList);

		//페이징 객체 MODEL로 추가
		model.addAttribute("paging", paging);
		
		//현재시간, int형으로 바꿔서 보내주기
		Date date = new Date();
		
		SimpleDateFormat transFormat = new SimpleDateFormat("HHmm");
				
		String stringNow = transFormat.format(date);
		
		int intNow = Integer.parseInt(stringNow);
				
		model.addAttribute("intNow", intNow);
		
		//중복뺸 zoneList얻기
		List<SellerLoc> zoneList = buyerService.getZoneList();
		
		model.addAttribute("zoneList", zoneList);
		
		//중복뺀 stationList얻기
		List<SellerLoc> stationList = buyerService.getStationList();
		
		model.addAttribute("stationList", stationList);
		
		//------------------------------------------------------
		//메인 배너
		// 배너목록 MODEL로 추가

		List<MainBanner> mainBannerList = buyerService.getBannerList();
		model.addAttribute("mainBannerList", mainBannerList);
		
	}
	
	@RequestMapping(value="/buyer/main", method=RequestMethod.POST)
	public void buyerMainPost(
			String zoneSelect, 
			String stationSelect,
			@RequestParam(defaultValue="0") String curPage,
			Model model) {
		
		logger.info("zoneSelect:"+zoneSelect);
		logger.info("stationSelect:"+stationSelect);
		
		//현재 페이지 번호 얻기
		logger.info("curPage:"+curPage);
		
		//총 게시글 수 얻기(map을 통해 파라미터 전달)
		Map<String, Object> map = new HashMap<String, Object>(); // MAP을 이용해 담기
        map.put("zoneSelect", zoneSelect);
        map.put("stationSelect", stationSelect);
		int totalCount = buyerService.getTotalCountOfSellerLocByZoneAndStation(map);
		
		logger.info("totalCount:"+totalCount);
		
		//페이지 객체 생성
		SellerLocPaging paging = new SellerLocPaging(totalCount, Integer.parseInt(curPage));
		
		//paging에 zoneSelect,stationSelect추가
		paging.setZone(zoneSelect);
		paging.setStation(stationSelect);
		
		logger.info("paging:"+paging);
			
		List<SellerLoc> sellerLocList = buyerService.getPagingListOfSellerLocByZoneAndStation(paging);
		
		logger.info("sellerLocList:"+sellerLocList);
			
		//조회 결과를 VIEW에 전달하기
		model.addAttribute("sellerLocList", sellerLocList);

		//페이징 객체 MODEL로 추가
		model.addAttribute("paging", paging);
		
		//현재시간, int형으로 바꿔서 보내주기
		Date date = new Date();
		
		SimpleDateFormat transFormat = new SimpleDateFormat("HHmm");
				
		String stringNow = transFormat.format(date);
		
		int intNow = Integer.parseInt(stringNow);
				
		model.addAttribute("intNow", intNow);
		
		//중복뺸 zoneList얻기
		List<SellerLoc> zoneList = buyerService.getZoneList();
		
		model.addAttribute("zoneList", zoneList);
		
		//중복뺀 stationList얻기
		List<SellerLoc> stationList = buyerService.getStationList();
		
		model.addAttribute("stationList", stationList);
		
		//main에선 방번호 -1을가지고 있게하자.
		
		//------------------------------------------------------
		//메인 배너
		// 배너목록 MODEL로 추가
		List<MainBanner> mainBannerList = buyerService.getBannerList();
		model.addAttribute("mainBannerList", mainBannerList);
				
		
	}
	
	@RequestMapping(value="/buyer/locview", method=RequestMethod.GET)
	public void buyerLocView(int locNo, Model model, HttpSession session) {
		
		logger.info("locNo:"+locNo);
		//locNo에 맞는 SellerLoc 조회
		SellerLoc sellerLoc = buyerService.getSellerLoc(locNo);
		
		logger.info("sellerLoc:"+sellerLoc);
		
		model.addAttribute("sellerLoc", sellerLoc);
				
		//sellerId으로 북리스트 조회
		List<BookListInfo> bookListInfo = buyerService.getBookListInfoBySellerId(sellerLoc.getSellerId());
		
		logger.info("bookListInfo:"+bookListInfo);
		
		model.addAttribute("bookListInfo", bookListInfo);
		
		//buyerId, sellerId얻기
		Reservation reservationInfo = new Reservation();
		
		reservationInfo.setBuyerId((String)session.getAttribute("buyerId"));
		reservationInfo.setSellerId(sellerLoc.getSellerId());
		
		//구매자,판매자로 Reservation 리스트 조회(확인용)
		List<Reservation> reservationList = buyerService.getResrvaionList(reservationInfo);
		logger.info("reservationList:"+reservationList);
		
		//buyerId,sellerId, status가"예약"인 cnt개수 가져오기.
		logger.info("reservationInfo:"+reservationInfo);
		int cntReservation = buyerService.getResrvaionCnt(reservationInfo);
		logger.info("cntReservation:"+cntReservation);
		
		model.addAttribute("cntReservation", cntReservation);
		
		//현재시간, int형으로 바꿔서 보내주기
		Date date = new Date();
		
		SimpleDateFormat transFormat = new SimpleDateFormat("HHmm");
				
		String stringNow = transFormat.format(date);
		
		int intNow = Integer.parseInt(stringNow);
				
		model.addAttribute("intNow", intNow);
		
		logger.info("[TEST]현재시간:"+intNow);
		
			
	}
	
	@RequestMapping("/sellerLocMap")
	public void buyerSellerLocMap(int locNo, Model model) {
	
		SellerLoc sellerLoc = buyerService.getSellerLoc(locNo);
		
		model.addAttribute("sellerLoc", sellerLoc);
	}


	
	
	
	@RequestMapping(value="/buyer/join", method=RequestMethod.GET)
	public void mailform() {
		
	}
	
	
	
	@RequestMapping(value="/buyer/mailsender", method=RequestMethod.POST)
	public String mailsender(HttpServletRequest request, Model model, String email, HttpSession sess) {
		
		String code = UUID.randomUUID().toString().split("-")[0];
		
		Map map = new HashMap();
		map.put("emailCode", code);
//		
		model.addAllAttributes(map);

		
		String subject = "[빅이슈] 인증 메일입니다."; //메일 제목 입력해주세요. 
		String frontBody = "이메일 인증을 완료하려면 인증코드란에 "; //앞단
		String middleBody = code;
		String endBody = "를 써주세요\n"; //뒷단
		endBody += "본 메일은 발신전용입니다.";
		String body = frontBody+middleBody+endBody;
		
		
		buyerService.mailSender(email, subject, body);
		
		return "jsonView";
		
	}
	
	
	@RequestMapping(value="/buyer/useeamil", method=RequestMethod.POST)
	public String useEamil(String email, Model model) {
		
		System.out.println("넘어온 이메일"+email);
		
		int emailCnt = buyerService.eamilSerch(email);
		
		model.addAttribute("emailCnt", emailCnt);
		return "jsonView";
	}
	
	@RequestMapping(value="/mail/code", method=RequestMethod.GET)
	public void emailcode() {
		
	}
	
	
	@RequestMapping("/buyer/useid")
	public String useid(Model model, BuyerInfo bi) {
		
		boolean id = buyerService.haveId(bi);

		Map map = new HashMap();
		
		if(id) {
			map.put("haveId", true);
			
		} else {
			map.put("haveId", false);	
		}
		
		model.addAllAttributes(map);
		
		return "jsonView";
	}
	
	
	
	//회원가입
	@RequestMapping(value="/buyer/join", method=RequestMethod.POST)
	public String buyerJoin(BuyerInfo buyerInfo) {
		
//		System.out.println(buyerInfo.toString());
		buyerInfo.setBuyerPhone(buyerInfo.getBuyerPhone1()+"-"+buyerInfo.getBuyerPhone2()+"-"+buyerInfo.getBuyerPhone3());
		
		//비밀번호를 암호화하여여 buyerInfo에 다시 세팅하기
		buyerInfo.setBuyerPw(buyerService.shaPw(buyerInfo.getBuyerPw()));
		
		buyerService.buyerJoin(buyerInfo);
		
		return "redirect:/buyer/login";
	}
	
	
	@RequestMapping(value="/buyer/login", method=RequestMethod.GET)
	public void buyerLoginForm() {
		
	}
	
	@RequestMapping(value="/buyer/login", method=RequestMethod.POST)
	public String buyerLogin(BuyerInfo buyerInfo, HttpSession session) {
		
		//로그아웃 안하고 로그인 했을때 전에있던 정보 초기화
		session.removeAttribute("LoginInfo");
		session.removeAttribute("buyerId");
		session.removeAttribute("sellerId");
		session.removeAttribute("bigdomId");
		session.removeAttribute("adminId");
		session.removeAttribute("buyerLogin");
		session.removeAttribute("sellerLogin");
		session.removeAttribute("bigdomLogin");
		session.removeAttribute("adminLogin");
		
		//비밀번호를 암호화하여여 buyerInfo에 다시 세팅하기
		buyerInfo.setBuyerPw(buyerService.shaPw(buyerInfo.getBuyerPw()));
		
		boolean user = buyerService.buyerLogin(buyerInfo);
		
//		System.out.println(buyerInfo.getBuyerId());
		
		//chat에서 session정보를 가져올때
		//User라는(판매자,빅돔,구매자)정보 모두를 포함하는 dto의 정보를  불러와야해서 만듦.
		User LoginInfo = null;
		
		if(user) {
			session.setAttribute("buyerLogin", true);
			session.setAttribute("buyerId", buyerInfo.getBuyerId());
			
			//chat에서 session정보를 가져올때
			//User라는(판매자,빅돔,구매자)정보 모두를 포함하는 dto의 정보를  불러와야해서 만듦.
			//buyerId로 Buyer정보 검색(반환User)
			LoginInfo = buyerService.getBuyerInfo(buyerInfo);
			session.setAttribute("LoginInfo", LoginInfo);
			
			return "redirect:/buyer/main";
		}
		session.setAttribute("buyerLogin", false);
		return "redirect:/buyer/login";
		
		
	}
	
	@RequestMapping(value="/buyer/logout", method=RequestMethod.GET)
	public String buyerLogout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/buyer/login";
	}
	
	
	
	//아이디찾기
	@RequestMapping(value="/buyer/findid", method=RequestMethod.GET)
	public void buyerFindIdForm() {
		
	}
	
	@RequestMapping(value="/buyer/findid", method=RequestMethod.POST)
	public void buyerFindId(BuyerInfo buyerInfo, Model model, HttpServletResponse res) throws IOException {
		
		
		PrintWriter out = null;
		res.setContentType("text/html; charset=UTF-8");
		out = res.getWriter();

		
		//들어온 정보로 값 비교하기
		BuyerInfo bi = buyerService.buyerFindId(buyerInfo);
		
		int cnt = buyerService.buyerCnt(buyerInfo);
		
		System.out.println("받아온값"+buyerInfo.getBuyerName());
//		System.out.println(bi.toString());
//		System.out.println("조회한값"+bi.getBuyerName());
		
		if(cnt == 1) {
			//있으면 메일 발송 메시지 반환
			String subject = "아이디 찾기 결과입니다."; //메일 제목 입력해주세요. 
			String frontBody = "회원님의 아이디는"; //앞단
			String middleBody = bi.getBuyerId();
			String endBody = "입니다."; //뒷단
			String email = bi.getBuyerEmail();
			
			String body = frontBody+middleBody+endBody;
			
			buyerService.mailSender(email, subject, body);
//			model.addAttribute("msg","메일을 발송하였습니다");
//			model.addAttribute("url","/buyer/findid");
			out.println("<script>alert('회원님의 아이디를 메일로 발송하였습니다'); location.href='/buyer/login'</script>" );
					
			out.flush();
			
		} else {
			
			out.println("<script>alert('다시 확인해주세요'); location.href='/buyer/findid'</script>" );
			
			out.flush();
		}
	}
	
	
	
	//비밀번호찾기
	@RequestMapping(value="/buyer/findpw", method=RequestMethod.GET)
	public void buyerFindPwForm() {
		
	}
	
	@RequestMapping(value="/buyer/findpw", method=RequestMethod.POST)
	public void buyerFindPw(BuyerInfo buyerInfo, HttpServletResponse res) throws IOException {
		
		PrintWriter out = null;
		res.setContentType("text/html; charset=UTF-8");
		out = res.getWriter();

		
		//들어온 정보로 값 비교하기
		BuyerInfo bi = buyerService.buyerFindInfo(buyerInfo);
		
		//정보 3개로 조회
		int cnt = buyerService.buyerFindCnt(buyerInfo);
		
		System.out.println("받아온값"+buyerInfo.getBuyerName());
//		System.out.println(bi.toString());
//		System.out.println("조회한값"+bi.getBuyerName());
		
		if(cnt == 1) {
			//1. 있다면 비밀번호 변경	
			String newPw = UUID.randomUUID().toString().split("-")[0];
			
			//비밀번호를 암호화하여여 buyerInfo에 다시 세팅하기
			buyerInfo.setBuyerPw(buyerService.shaPw(newPw));
			
			buyerService.pwUpdate(buyerInfo);
			
			//2. 메일 변경된 비밀번호를 메일로 발송 후메시지 반환
			String subject = "회원님의 비밀번호가 변경되었습니다."; //메일 제목 입력해주세요. 
			String frontBody = "회원님의 비밀번호는"; //앞단
			String middleBody = newPw;
			String endBody = "입니다. 로그인 후 비밀번호를 변경해주세요."; //뒷단
			String email = bi.getBuyerEmail();
			
			String body = frontBody+middleBody+endBody;
			
			buyerService.mailSender(email, subject, body);
//			model.addAttribute("msg","메일을 발송하였습니다");
//			model.addAttribute("url","/buyer/findid");
			out.println("<script>alert('변경된 회원님의 비밀번호를 메일로 발송하였습니다'); location.href='/buyer/login'</script>" );
					
			out.flush();
			
		} else {
			
			out.println("<script>alert('다시 확인해주세요'); location.href='/buyer/findpw'</script>" );
			
			out.flush();
		}	
	}
	
	@RequestMapping(value="/buyer/booking", method=RequestMethod.POST)
	public String Booking(
			Model model,
			int selectBookingNum[],
			String bookingTimeHour,
			String bookingTimeMin,
			String AmPm,
			int locNo,
			String month[],
			int magazineNo[],
			HttpSession session) { // 마이페이지-예약내역
		
		//예약DTO
		Reservation reservationInfo = new Reservation();
		
		//locNo에 대한 SellerLoc정보 조회
		SellerLoc SellerLocInfo = buyerService.getSellerLoc(locNo);
		
		//sellerId으로 북리스트 조회
//		List<BookListInfo> bookListInfo = buyerService.getBookListInfo(SellerLocInfo.getSellerId());
		
		//현재시간
		Date date = new Date();
		
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		//예약호수 개수만큼 반복(selectBookingNum는 예약부수정보를 담은 int형 배열)
		//				(month는 예약호수정보를 담은 String형 배열)
		for(int i=0; i<selectBookingNum.length; i++) {
			
			
			//예약부수가 0보다 작다면 아래 코드들 실행못하게 continue
			if(selectBookingNum[i]<=0) continue;
			reservationInfo.setSellerId(SellerLocInfo.getSellerId());
			reservationInfo.setBuyerId((String)session.getAttribute("buyerId"));
			reservationInfo.setZone(SellerLocInfo.getZone());
			reservationInfo.setStation(SellerLocInfo.getStation());
			reservationInfo.setSpot(SellerLocInfo.getSpot());
			reservationInfo.setBookMonth(month[i]);
			reservationInfo.setBookNumber(selectBookingNum[i]);
			reservationInfo.setStatus("예약");
			reservationInfo.setTotal(5000*selectBookingNum[i]);
			reservationInfo.setBookDate(date);
			reservationInfo.setMagazineNo(magazineNo[i]);
			
			//-----현재시간(년,월,일)+예약한시간(시,분)+오전/오후-----
			String bookingTime = bookingTimeHour+":"+bookingTimeMin+" "+AmPm;
			//현재시간(년,월,일) Date=>String 타입변환
			String now = transFormat.format(date);
			String StringTime = now+" "+bookingTime;
			logger.info("StringTime:"+StringTime);
			//--------------------------------------------
			try {
				//Reservation DTO에 저장하기 위해 String=>Date로 타입변환
				Date DateTime = new SimpleDateFormat("yyyy-MM-dd hh:mm a").parse(StringTime);
				//현재시간을 날짜형식으로 DTO에 저장
				logger.info("DateTime:"+DateTime);
				reservationInfo.setPickupDate(DateTime);
				//예약하기
				buyerService.booking(reservationInfo);
							
			} catch (ParseException e) {
				e.printStackTrace();
			}
			logger.info("reservationInfo:"+reservationInfo);
		}
				
		return "redirect:/buyer/locview?locNo="+locNo;
	}
	
	@RequestMapping(value="/buyer/my/booking", method=RequestMethod.GET)
	public void myBooking(HttpSession session, 
			Model model,
			@RequestParam(defaultValue="0") String curPage) {
		//페이징처리
		//현재 페이지 번호 얻기
		logger.info("curPage:"+curPage);
		
		// 세션값 가져오기
		String buyerId = (String) session.getAttribute("buyerId");	
		logger.info("buyerId:"+buyerId); 
				
		//총 예약내역 수 얻기(buyerId를 이용해서)
		int totalCount = buyerService.getTotalCountOfMyBooking(buyerId);
		
		logger.info("totalCount:"+totalCount);
		
		//페이징 객체 생성
		MyBookingPaging paging = new MyBookingPaging(totalCount, Integer.parseInt(curPage));
		paging.setBuyerId(buyerId);
		logger.info("paging:"+paging);
		
		//구매자의 예약내역 페이징리스트 조회
		List<Reservation> reservationList = buyerService.getPagingListOfMyReservation(paging);
		
		logger.info("reservationList:"+reservationList);
					
		// --- 수령시간이 지났을 경우 취소상태로 변경하기 ---
		// 1. 현재시간과 수령시간 비교		
		Date now = new Date(); // 현재시간
		for(int i=0; i<reservationList.size(); i++) {
			if(now.before(reservationList.get(i).getPickupDate())) {
//				logger.info("현재시간이 더 작음");

			} else { 
//				logger.info("현재시간이 더 큼");	
				//status가 예약이고, DB에 저장된 시간이 현재시간보다 클때 취소상태로 변경
				//예약부수도 반환
				if("예약".contentEquals(reservationList.get(i).getStatus())) {
					//예약 => 예약취소(시간초과)로 변경
					buyerService.setPickupDate(reservationList.get(i));
					//예약했던 수 만큼 다시 증가시키기 
					buyerService.increaseCirculation(reservationList.get(i));
				}
			}
		}
		
		// 4. 예약내역 재조회
		reservationList = buyerService.getPagingListOfMyReservation(paging);
		// ------------------------------------------ 상태변경 끝
		
		model.addAttribute("reservationList", reservationList);
		
		model.addAttribute("paging", paging);

	}
	
	@RequestMapping(value="/buyer/my/chat", method=RequestMethod.GET)
	public String myChat(
			@RequestParam(defaultValue="-1") int chatRoomNo, HttpSession session, Model model) { // 마이페이지-문의내역
		
		logger.info("chatRoomNo:"+chatRoomNo);

		session.setAttribute("chatRoomNo", chatRoomNo);
		
		//-------------------채팅내역 방들(사이드에 보이는 채팅방들)을 보여지기 위한 model설정--------------------
		User LoginInfo = (User)session.getAttribute("LoginInfo");
		logger.info("LoginInfo:"+LoginInfo);
		if(LoginInfo==null) {
			return "buyer/my/chat";
		}
			
		List<Chat> chatRoomList = chatService.selectRooms(LoginInfo);
		
		//채팅내역의 상대방 이름을 띄워 주기 위해서 추가
		//Chat의 TheOtherParty에
		//chatRoomList속에 있는 Chat를 하나하나 조사해서 로그인된 아이디와 같지않고 null이 아닌 아이디를 넣어주자.
		for(int i=0; i<chatRoomList.size(); i++) {
			if(chatRoomList.get(i).getBuyerId() != null && !chatRoomList.get(i).getBuyerId().equals(LoginInfo.getId())) {
				chatRoomList.get(i).setTheOtherParty(chatRoomList.get(i).getBuyerId());
			}else if(chatRoomList.get(i).getSellerId() != null && !chatRoomList.get(i).getSellerId().equals(LoginInfo.getId())) {
				chatRoomList.get(i).setTheOtherParty(chatRoomList.get(i).getSellerId());
			}else if(chatRoomList.get(i).getBigdomId() != null && !chatRoomList.get(i).getBigdomId().equals(LoginInfo.getId())) {
				chatRoomList.get(i).setTheOtherParty(chatRoomList.get(i).getBigdomId());
			}
		}
		
		logger.info("chatRoomList:"+chatRoomList);
		
		model.addAttribute("chatRoomList", chatRoomList);
		//--------------------------------------------------------------------------------
		
		//--------------------채팅메시지 -----------------------------------------------------
		List<Message> primaryMsgList = new ArrayList();
		List<Message> subMsgList = new ArrayList();
		//DB에 저장되어 있는 Message불러오기.	
		
		//메인 채팅방(가운데에 있는 채팅방)에서의 메시지
		primaryMsgList = chatService.selectMessage(chatRoomNo);
		
		//메인 채팅 리스트 Date이쁘게 바꾸기
		//Date보기 좋게 변경
		SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat time = new SimpleDateFormat("hh:mm a");
		
		Date tempTime = null;
		String stringTime = null;

		for(int i=0; i<primaryMsgList.size(); i++) {
			//현재 date받아오기
			tempTime = primaryMsgList.get(i).getChatDate();		
			//date를 이쁜String으로 바꾸기
			stringTime = time.format(tempTime);		
			//primaryMsgList에 stringChatDate설정
			primaryMsgList.get(i).setStringChatDate(stringTime);
		}
			
		//채팅내역 방들(사이드에 보이는 채팅방들)에서의 메시지
		for(int i=0; i<chatRoomList.size(); i++) {
			//보조 메시지(가장 마지막의 메시지 하나만 가져와야함)
			Message subMsg = chatService.selectSubMessage(chatRoomList.get(i).getChatRoomNo());

			if(subMsg != null) {
				//현재 date받아오기
				tempTime = subMsg.getChatDate();
				//date를 이쁜String으로 바꾸기
				stringTime = time.format(tempTime);		
				//subMsgList에 stringChatDate설정
				subMsg.setStringChatDate(stringTime);
				
				subMsgList.add(subMsg);
			}
			
		}
		
		//주채팅창 message list
		logger.info("primaryMsgList:"+primaryMsgList);
		model.addAttribute("primaryMsgList", primaryMsgList);
		
		//보조채팅창 message list
		logger.info("subMsgList:"+subMsgList);
		model.addAttribute("subMsgList", subMsgList);
		
		//----- 안읽은 메시지표시 -----
		//방에 들어가면 현재id,방no,들어간date를 MessageChk에 넣어주자. - 나중에 안읽은 메시지 표시하기 위해서
		//dto는 MessageChk사용.
		MessageChk messageChk = new MessageChk();
		Date sysdate = new Date();//현재 방에 들어온 시간
		messageChk = chatService.setDtoMessageChk(LoginInfo.getId(),chatRoomNo,sysdate);
		logger.info("messageChk확인:"+messageChk);
		
		//MessageChk테이블에 이미 id가 들어가 있는지 없는지 확인
		boolean existenceStatusOfChatId = chatService.getExistenceStatusOfChatId(messageChk);
		
		if(existenceStatusOfChatId) {//Id없으면
			logger.info("MessageChk에 이미 Id가 존재하지 않음");
			chatService.insertMessageChk(messageChk);
		}else {//Id있으면
			logger.info("MessageChk에 이미 Id가 존재함");
			chatService.updateMessageChk(messageChk);
		}
		
		//로그인한 id를 포함하는 방에서 내가 방에 접속한 시간보다 작은 메시지 개수 세기 (List리턴)
		List<MessageChk> finalDateListById = chatService.getFinalDateListById(LoginInfo.getId());
		logger.info("finalDateListById:"+finalDateListById);
		//finalDateListById크기만큼 반복해서 읽지 않은 메시직 개수 가져오기
		List<MessageChk> messageChkResult = new ArrayList<>();
		for(int i=0; i<finalDateListById.size(); i++) {
			MessageChk tempMessageChk = chatService.getMessageNoReadNum(finalDateListById.get(i));
			messageChkResult.add(tempMessageChk);
		}
		logger.info("messageChkResult:"+messageChkResult);
		model.addAttribute("messageChkResult", messageChkResult);
		
		return "buyer/my/chat";
	}
	
	@RequestMapping(value="/buyer/my/info", method=RequestMethod.GET)
	public void myInfo(
			BuyerInfo buyerInfo, 
			HttpSession session, Model model) { // 마이페이지-정보수정
		
		String buyerId = (String) session.getAttribute("buyerId");
//		logger.info("::::::buyerID::::::"+buyerId);
		
		buyerInfo.setBuyerId(buyerId);
		
		//buyerId로 회원정보 조회
		buyerInfo = buyerService.getBuyerInfoAtBuyermyinfo(buyerInfo);
//		logger.info(":::::buyerInfo:::::"+buyerInfo.toString());
		
		// 연락처 정보
		buyerInfo.setBuyerPhone1(buyerInfo.getBuyerPhone().split("-")[0]);
		buyerInfo.setBuyerPhone2(buyerInfo.getBuyerPhone().split("-")[1]);
		buyerInfo.setBuyerPhone3(buyerInfo.getBuyerPhone().split("-")[2]);
		
		// 이메일 정보
		buyerInfo.setBuyerEmail1(buyerInfo.getBuyerEmail().split("@")[0]);;
		buyerInfo.setBuyerEmail2(buyerInfo.getBuyerEmail().split("@")[1]);;
		
//		logger.info(":::split 정보 확인:::"+buyerInfo.toString());
		
		model.addAttribute("buyerInfo", buyerInfo);
		
	}
	
	@RequestMapping(value="/buyer/my/info/changePhone", method=RequestMethod.POST)
	public String myInfoChangePhone(BuyerInfo buyerInfo, HttpSession session) {
		
//		logger.info(buyerInfo.toString());
		
		// 세션 정보 가져오기
		String buyerId = (String)session.getAttribute("buyerId");
		buyerInfo.setBuyerId(buyerId);
		
		if(buyerInfo != null && !"".equals(buyerInfo)) {
			buyerInfo.setBuyerPhone(buyerInfo.getBuyerPhone1()+"-"+buyerInfo.getBuyerPhone2()+"-"+buyerInfo.getBuyerPhone3());

			buyerService.setBuyerPhone(buyerInfo);
		}
		
		return "jsonView";
		
	}
	
	@RequestMapping(value="/buyer/my/info/changeEmail", method=RequestMethod.POST)
	public String myInfoChangeEmail(BuyerInfo buyerInfo, HttpSession session) {
		
		// 세션 정보 가져오기
		String buyerId = (String)session.getAttribute("buyerId");
		buyerInfo.setBuyerId(buyerId);
		
		if(buyerInfo != null && !"".equals(buyerInfo)) {
			buyerInfo.setBuyerEmail(buyerInfo.getBuyerEmail1()+"@"+buyerInfo.getBuyerEmail2());

			buyerService.setBuyerEmail(buyerInfo);
		}
		
		return "jsonView";
	}
	
	@RequestMapping(value="/buyer/my/info/changePw", method=RequestMethod.POST)
	public String myInfoChangePw(BuyerInfo buyerInfo, HttpSession session) {
		
		// 세션 정보 가져오기
		buyerInfo.setBuyerId((String) session.getAttribute("buyerId"));

//		logger.info(":::비밀번호 변경::::"+buyerInfo.toString());
		// 비밀번호 암호화
		String codedPw = buyerService.shaPw(buyerInfo.getBuyerPw());
		buyerInfo.setBuyerPw(codedPw);
		
		// 비밀번호 변경
		buyerService.setBuyerInfoAtMypage(buyerInfo);
		
		// 비밀번호 변경 후 세션 만료
		session.invalidate();
		
		return "jsonView";
	}
	
	@RequestMapping(value="/buyer/my/confirmpw", method=RequestMethod.POST)
	public void myPwConfirm(BuyerInfo buyerInfo, HttpSession session, HttpServletResponse res) throws IOException { // 마이페이지-정보수정 -> 비밀번호확인
		
		PrintWriter out = null;
		res.setContentType("text/html; charset=UTF-8");
		out = res.getWriter();
		
		// 입력한 비밀번호 암호화
		String codedpw = buyerService.shaPw(buyerInfo.getBuyerPw());
		buyerInfo.setBuyerPw(codedpw);
		
//		logger.info(buyerInfo.toString());
		buyerInfo.setBuyerId((String) session.getAttribute("buyerId"));
		
		// 입력한 비밀번호 맞는지 확인
		if(buyerService.confirmpw(buyerInfo)) { // 비밀번호가 맞을 경우
//			logger.info("비밀번호 맞음");
			session.setAttribute("confirmpw", true);
			
			out.println("<script>alert('비밀번호를 확인하였습니다.'); location.href='/buyer/my/info'</script>" );
			out.flush();
			
		} else {
//			logger.info("비밀번호 틀림");
			session.setAttribute("confirmpw", false);
			
			out.println("<script>alert('비밀번호를 다시 확인해주세요.'); location.href='/buyer/my/info'</script>" );
			out.flush();

			
		}
		
//		return "redirect:/buyer/my/info";
	}
	
	//공지사항리스트띄우기
		@RequestMapping(value="/buyer/notice/list", method=RequestMethod.GET)
		public void noticeList() {
			
		}
		
		//공지사항리스트ajax메소드
		@RequestMapping(value="/buyer/notice/getNoticeList", method=RequestMethod.GET)
		public String getNoticeList(Model model, Paging p) {
			
			
			int noticeCnt = buyerService.getNoticeCnt();
			
			Paging paging = new Paging(noticeCnt, p.getCurPage());
			
			List<Notice> noticeList = buyerService.getNoticeList(paging);
			
			Map map = new HashMap();
			
			map.put("paging", paging);
			map.putIfAbsent("noticeList", noticeList);
			
			model.addAttribute("map", map);
			return "jsonView";
		}
		
		
		
		@RequestMapping(value="/buyer/notice/view", method=RequestMethod.GET)
		public void buyerNoticeView(Model model, Notice n) {
			
							//공지사항 상세보기 + 조회수추가
			Notice notice = buyerService.getNoticeView(n.getNoticeNo());
			
			model.addAttribute("notice", notice);
			
			
		}

	
	@RequestMapping(value="/buyer/bookingCancel", method=RequestMethod.GET)
	public String buyerBookingCancel(int magazineNo, Model model) { 
		
		logger.info("magazineNo:"+magazineNo);
			
		//magazineNo으로 reservation테이블 조회
		Reservation reservationInfo = buyerService.getReservaionByMagazineNo(magazineNo);
		
		logger.info("reservationInfo:"+reservationInfo);
		
		//bookListInfo 빅이슈테이블 circulation(보유부수) 예약취소한 수 만큼 증가시키기
		buyerService.increaseCirculation(reservationInfo);
		
		//reservation 예약테이블 status "예약"=>"취소"로 변경하기
		buyerService.setStatusOfReservation(magazineNo);
		
		return "redirect:/buyer/my/booking";
	}
	

	@RequestMapping(value="/buyer/practice", method=RequestMethod.GET)
	public void pratice() {}
	
	@RequestMapping(value="/buyer/pagingAjax", method=RequestMethod.POST)
	public String pagingAjax(int curPage,String zone,String station, Model model) {
		
		//-------------curpage,zone,station 받기 ----------------
		logger.info("curPage:"+curPage);
		
		if(zone.split("#").length>0) {
			zone=zone.split("#")[0].split("호선")[0];
		}else {
			zone="";
		}
		logger.info("zone:"+zone);
		
		if(station.split("#").length>0) {
			station=station.split("#")[0];
		}else {
			station="";
		}
		logger.info("station:"+station);
		//-------------------------------------------------------
		//총 게시글 수 얻기(map을 통해 파라미터 전달) 검색되고 다시 페이지번호 누르면 GET방식으로 오기때문에 map을통해서 zone,station조건으로 조회
		Map<String, Object> map = new HashMap<String, Object>(); // MAP을 이용해 담기
        map.put("zoneSelect", zone);
        map.put("stationSelect", station);
		int totalCount = buyerService.getTotalCountOfSellerLocByZoneAndStation(map);
		
		logger.info("totalCount:"+totalCount);
		
		//페이지 객체 생성
		SellerLocPaging paging = new SellerLocPaging(totalCount, curPage);
		//paging에 zoneSelect,stationSelect추가
		paging.setZone(zone);
		paging.setStation(station);
		
		logger.info("paging:"+paging);
		
		List<SellerLoc> sellerLocList = buyerService.getPagingListOfSellerLocByZoneAndStation(paging);
		
		logger.info("sellerLocList:"+sellerLocList);
			
		//조회 결과를 VIEW에 전달하기
		model.addAttribute("sellerLocList", sellerLocList);

		//페이징 객체 MODEL로 추가
		model.addAttribute("paging", paging);
		
		//현재시간, int형으로 바꿔서 보내주기
		Date date = new Date();
		
		SimpleDateFormat transFormat = new SimpleDateFormat("HHmm");
				
		String stringNow = transFormat.format(date);
		
		int intNow = Integer.parseInt(stringNow);
				
		//현재시간 MODEL로 추가
		model.addAttribute("intNow", intNow);
		
		
		return "buyer/sellerLocPagingResult";
	}
	
	@RequestMapping(value="/buyer/locInfo", method=RequestMethod.POST)
	public String locInfo(String zone, Model model) {
		
		logger.info("zone : " + zone);
		
		//현재 DB에 입력된 판매지역
		if(zone != null) {
			//검색어 split
			String[] zon = zone.split("호선");
			
			//zon[0]을 통한 역 조회
			List<SellerLoc> list = buyerService.viewLoc(zon[0]);
			
			logger.info(String.valueOf(list));
			model.addAttribute("locList", list);

		}
		
		return "buyer/locInfoResult";
	}
}
