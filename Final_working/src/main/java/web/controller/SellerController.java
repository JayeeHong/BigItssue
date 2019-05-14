package web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import web.dto.Chat;
import web.dto.Message;
import web.dto.MessageChk;
import web.dto.Reservation;
import web.dto.Review;
import web.dto.ReviewReply;
import web.dto.SellerInfo;
import web.dto.SellerLoc;
import web.dto.User;
import web.service.face.ChatService;
import web.service.face.SellerService;
import web.util.Paging;

@Controller
public class SellerController {
	
	private static final Logger logger
	= LoggerFactory.getLogger(SellerController.class);
	
	@Autowired SellerService sellerService;
	@Autowired ChatService chatService;
	
	@RequestMapping(value="/seller/main", method=RequestMethod.GET)
	public String sellerMain(
			@RequestParam(defaultValue="-1") int chatRoomNo, HttpSession session, Model model) { 
		logger.info("chatRoomNo:"+chatRoomNo);

		session.setAttribute("chatRoomNo", chatRoomNo);
		
		//-------------------채팅내역 방들(사이드에 보이는 채팅방들)을 보여지기 위한 model설정--------------------
		User LoginInfo = (User)session.getAttribute("LoginInfo");
		logger.info("LoginInfo:"+LoginInfo);
		if(LoginInfo==null) {
			return "seller/main";
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
			if(finalDateListById.get(i)!=null) {
				MessageChk tempMessageChk = chatService.getMessageNoReadNum(finalDateListById.get(i));
				messageChkResult.add(tempMessageChk);
			}
		}
		logger.info("messageChkResult:"+messageChkResult);
		model.addAttribute("messageChkResult", messageChkResult);
		
		return "seller/main";
	}
	
	@RequestMapping(value="/seller/login", method=RequestMethod.POST)
	public String sellerLogin(
			SellerInfo sellerInfo,
			HttpSession session, Model model) {
		
		//chat에서 session정보를 가져올때
		//User라는(판매자,빅돔,구매자)정보 모두를 포함하는 dto의 정보를  불러와야해서 만듦.
		User LoginInfo = null;
		
		// 로그인
		if(sellerService.login(sellerInfo)) { // 로그인 성공 시
			session.setAttribute("sellerLogin", true);
			session.setAttribute("sellerId", sellerInfo.getSellerId());
//			logger.info(sellerInfo.toString());
			
			// 판매자 전체 정보 가져오기
			sellerInfo = sellerService.getSellerInfo(sellerInfo.getSellerId());
//			logger.info(":::::sellerinfo::::::"+sellerInfo.toString());
			session.setAttribute("sellerInfo", sellerInfo);
			
			//User으로 정보가 필요해서 추가
			LoginInfo = sellerService.getSellerInfoUser(sellerInfo);
			session.setAttribute("LoginInfo", LoginInfo);
			
		}
		
		
		return "redirect:/seller/main";
	}
	
	@RequestMapping(value="/seller/logout", method=RequestMethod.GET)
	public String sellerLogout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/seller/main";
	}
	
	@RequestMapping(value="/seller/time", method=RequestMethod.GET)
	public void sellerTime(
			SellerLoc sellerLoc, Model model,
			HttpSession session) {
		
		String sellerId = (String) session.getAttribute("sellerId");
		
		// 판매시간 조회
		sellerLoc = sellerService.getSellerLoc(sellerId);
		
//		logger.info(":::::판매시간 조회:::::"+sellerLoc.toString());
		
		String startTime="";
		String startTime1="";
		String startTime2="";
		String endTime="";
		String endTime1="";
		String endTime2="";
		
		if(sellerLoc != null && !"".equals(sellerLoc)) {
			startTime = sellerLoc.getSellerTimeS();
			startTime1 = startTime.substring(0, 2);
			startTime2 = startTime.substring(2, 4);
			
			endTime = sellerLoc.getSellerTimeE();
			endTime1 = endTime.substring(0, 2);
			endTime2 = endTime.substring(2, 4);
		}
		
//		logger.info(startTime1 + ":" + startTime2);
		//--------------- 판매시간 조회 끝

		// 활성화 상태인지 조회
		List<BookListInfo> bookListInfo = sellerService.getBookList(sellerId);
		
//		logger.info(bookListInfo.toString());
		
		// 시작시간
		model.addAttribute("startTime1", startTime1); //시
		model.addAttribute("startTime2", startTime2); //분
		// 종료시간
		model.addAttribute("endTime1", endTime1); //시
		model.addAttribute("endTime2", endTime2); //분
		if(sellerLoc != null && !"".equals(sellerLoc)) { // 시작, 종료시간 null 처리
			model.addAttribute("sellerTimeS", sellerLoc.getSellerTimeS());
			model.addAttribute("sellerTimeE", sellerLoc.getSellerTimeE());
		}
		model.addAttribute("sellerLoc", sellerLoc); // 카드 가능/불가능
		model.addAttribute("bookListInfo", bookListInfo); // 활성화 상태인지
		
	}
	
	@RequestMapping(value="/seller/updateTime", method=RequestMethod.POST)
	public String updateTime(SellerLoc sellerLoc, HttpSession session) {
		
		logger.info("변경할 시간:"+sellerLoc);
		
		// 세션값 가져오기
		String sellerId = (String) session.getAttribute("sellerId");
		sellerLoc.setSellerId(sellerId);
		
		// 변경할 시간 세팅
		String startTime1 = sellerLoc.getStartTime1();
		String startTime2 = sellerLoc.getStartTime2();
		String sellerTimeS = "";
		String endTime1 = sellerLoc.getEndTime1();
		String endTime2 = sellerLoc.getEndTime2();
		String sellerTimeE = "";
		
		if(Integer.parseInt(startTime2)>0 && Integer.parseInt(startTime2)<10) {
			sellerTimeS = startTime1 + "0" + startTime2;
		} else {
			sellerTimeS = startTime1 + startTime2;
		}
//		logger.info("sellerTimeS:"+sellerTimeS);
		
		if(Integer.parseInt(endTime2)>0 && Integer.parseInt(endTime2)<10) {
			sellerTimeE = endTime1 + "0" + endTime2;
		} else {
			sellerTimeE = endTime1 + endTime2;
		}
//		logger.info("sellerTimeE:"+sellerTimeE);
		
		sellerLoc.setSellerTimeS(sellerTimeS);
		sellerLoc.setSellerTimeE(sellerTimeE);
		
		// 시간 변경
		sellerService.setSellerTime(sellerLoc);
		
		return "redirect:/seller/time";
	}
	
	@RequestMapping(value="/seller/time/cardUpdate", method=RequestMethod.POST)
	public String cardUpdateAtTime(SellerLoc sellerloc) {
		
//		logger.info("::::카드 결제 여부 변경::::"+sellerloc);
		// 카드 결제 여부 변경
		sellerService.setSellerCard(sellerloc);
		
		return "redirect:/seller/time";
	}
	
	@RequestMapping(value="/seller/mUpdate", method=RequestMethod.POST)
	public String mUpdate(BookListInfo bookListInfo, HttpSession session) {
		
//		logger.info("::::::수정할 내용::::::"+bookListInfo.toString());
		
		// 세션값 가져오기
		String sellerId = (String) session.getAttribute("sellerId");
		bookListInfo.setSellerId(sellerId);
		
		// 판매 호수, 판매 부수 수정
		sellerService.setMegazine(bookListInfo);
		
		return "redirect:/seller/time";
	}
	
	@RequestMapping(value="/seller/mDelete", method=RequestMethod.GET)
	public String mDelete(BookListInfo bookListInfo) {
		
//		logger.info("삭제할 내용:"+bookListInfo.toString());
		
		// 판매 호수, 판매 부수 삭제
		sellerService.deleteMegazine(bookListInfo.getMagazineNo());
		
		return "redirect:/seller/time";
	}
	
	@RequestMapping(value="/seller/mPlus", method=RequestMethod.POST)
	public String mPlus(BookListInfo bookListInfo, HttpSession session) {
		
		// 세션값 가져오기
		String sellerId = (String) session.getAttribute("sellerId");
		bookListInfo.setSellerId(sellerId);
		
//		logger.info("추가할 내용:"+bookListInfo.toString()+sellerId);
		
		// 판매할 빅이슈 추가하기
		sellerService.putMegazine(bookListInfo);
		
		return "redirect:/seller/time";
	}
	
	@RequestMapping(value="/seller/bookinglist", method=RequestMethod.GET)
	public void bookingList(HttpSession session, Model model) {
		
		// 세션값 가져오기
		String sellerId = (String) session.getAttribute("sellerId");
		
		// 판매시간 조회
		SellerLoc sellerLoc = sellerService.getSellerLoc(sellerId);
//		logger.info("::::::예약내역조회에서 sellerloc::::::"+sellerLoc.toString());
		if(sellerLoc != null && !"".equals(sellerLoc)) {
			
			// 판매자의 예약내역 조회
			List<Reservation> bookListInfo = sellerService.getReserve(sellerId);
			
			// --- 수령시간이 지났을 경우 취소상태로 변경하기 ---
			// 1. 현재시간과 수령시간 비교
//		logger.info("수령시간:"+bookListInfo.get(0).getPickupDate().toString());
			
			Date sysdate = new Date(); // 현재시간
			
			// 2. bookListInfo의 크기동안 반복
			for(int i=0; i<bookListInfo.size(); i++) {
				// 상태가 예약인 경우에만
				if(bookListInfo.get(i).getStatus().equals("예약")) {
					if(sysdate.before(bookListInfo.get(i).getPickupDate())) {
	//				logger.info("현재시간이 더 큼");
						
					} else { 
	//				logger.info("DB시간이 더 큼");
						
						// 취소한 부수만큼 증가시키기
						sellerService.setCirculation(bookListInfo.get(i));
						// 4. DB에 저장된 시간이 현재시간보다 클때 취소상태로 변경
						sellerService.setPickupDate(bookListInfo.get(i));
					}
				}
			}
			
			// 4. 예약내역 재조회
			bookListInfo = sellerService.getReserve(sellerId);
			// ------------------------------------------ 상태변경 끝
			
			model.addAttribute("bookListInfo", bookListInfo);
		}
		
		
	}
	
	@RequestMapping(value="/seller/bookCancel", method=RequestMethod.GET)
	public String bookCancel(Reservation reservation) {
		
//		logger.info(reservation.toString());
		// reserveNo로 해당 컬럼 조회
		reservation = sellerService.getReservationInfo(reservation);
		
		// reserveNo로 예약내역-예약취소로 변경
		sellerService.cancelReserve(reservation.getReserveNo());
		
		// sellerloc에 취소한 수량 증가
		sellerService.setCirculation(reservation);
		
		return "redirect:/seller/bookinglist";
	}
	
	@RequestMapping(value="/seller/bookUpdate", method=RequestMethod.GET)
	public String bookUpdate(Reservation reservation) {
		
//		logger.info(reservation.toString());
		
		// reserveNo로 예약내역-수령 으로 변경
		sellerService.updateReserve(reservation.getReserveNo());
		
		return "redirect:/seller/bookinglist";
	}
	
	@RequestMapping(value="/seller/upOpentime", method=RequestMethod.GET)
	public String upOpentime(SellerLoc sellerLoc, HttpSession session) {
		
		// 세션값 가져오기
		String sellerId = (String) session.getAttribute("sellerId");
		sellerLoc.setSellerId(sellerId);
		
//		logger.info("변경할 오픈시간 : "+sellerLoc.toString());
		sellerLoc.setSellerTimeS(sellerLoc.getStartTime1()+sellerLoc.getStartTime2());
//		logger.info("세팅한 오픈시간 : "+sellerLoc.toString());
		
		// 오픈 시간 업데이트
		sellerService.setStartTime(sellerLoc);
		
		return "redirect:/seller/time";
	}
	
	@RequestMapping(value="/seller/upClosetime", method=RequestMethod.GET)
	public String upClosetime(SellerLoc sellerLoc, HttpSession session) {
		
		// 세션값 가져오기
		String sellerId = (String) session.getAttribute("sellerId");
		sellerLoc.setSellerId(sellerId);
		
//		logger.info("변경할 오픈시간 : "+sellerLoc.toString());
		sellerLoc.setSellerTimeE(sellerLoc.getEndTime1()+sellerLoc.getEndTime2());
//		logger.info("세팅한 오픈시간 : "+sellerLoc.toString());
		
		// 종료 시간 업데이트
		sellerService.setEndTime(sellerLoc);
		
		return "redirect:/seller/time";
	}
	
	
	
	@RequestMapping(value="/seller/review/list", method=RequestMethod.GET)
	public void review(Review review, Model model, HttpServletRequest req) {
		
		logger.info("후기 게시판 리스트");
		
		//현재 페이지 번호 얻기
		int curPage = sellerService.getCurPage(req);
		
		//게시글 수 얻기
		int totalCount = sellerService.getTotalCount();
		
		//페이지 객체 생성
		Paging paging = new Paging(totalCount, curPage);
		
		//페이징객체 MODEL로 추가
		model.addAttribute("paging", paging);
		
		//게시글 목록 MODEL로 추가
		List<Review> reviewList = sellerService.getPagingList(paging);
		model.addAttribute("reviewList", reviewList);
		
	}
	
	@RequestMapping(value="/seller/review/write", method=RequestMethod.GET)
	public void reviewWrite() {
		
		logger.info("후기 글쓰기 페이지");
		
//		if(session.getAttribute("sellerLogin") == null ) {
//			return "redirect:/seller/review/list";
//		} else {
//			return "seller/review/write";
//		}
		
	}
	
	@RequestMapping(value="/seller/review/write", method=RequestMethod.POST)
	public String reviewWriteProc(Review review, HttpSession session) {
		
		logger.info("후기 글쓰기");
		
		review.setSellerId( (String)session.getAttribute("sellerId") );
		
		sellerService.write(review);
		
		return "redirect:/seller/review/list";
	}
	
	@RequestMapping(value="/seller/review/view", method=RequestMethod.GET)
	public void reviewView(Review review, Model model, HttpServletRequest req) {
		
		logger.info("후기 상세페이지");
		
		int reviewno = Integer.parseInt(req.getParameter("reviewNo"));
		review.setReviewNo(reviewno);
//		logger.info("리뷰::::"+review.toString());
		
		//게시글 조회 수행
		Review reviewView = sellerService.view(reviewno);
		
		//MODEL 전달
		model.addAttribute("reviewView", reviewView);
		
		
		//댓글 리스트 MODEL 추가
		List<ReviewReply> replyList = sellerService.getReplyList(reviewno);
//		for(ReviewReply r : replyList) System.out.println(r);
		
		model.addAttribute("replyList", replyList);
				
	}
	
	@RequestMapping(value="/seller/review/update", method=RequestMethod.GET)
	public void reviewUpdate(Review review, Model model, HttpServletRequest req) {
		
		logger.info("후기 글 수정페이지");
		
		int reviewno = Integer.parseInt(req.getParameter("reviewno"));
		
		Review view = sellerService.view(reviewno);
		
		model.addAttribute("reviewView", view);
		
	}
	
	@RequestMapping(value="/seller/review/update", method=RequestMethod.POST)
	public String reviewUpdateProc(Review review) {
		
		sellerService.update(review);
		
		return "redirect:/seller/review/view?reviewo=" + review.getReviewNo();
	}
	
	@RequestMapping(value="/seller/review/delete", method=RequestMethod.GET)
	public String reviewDelete(Review review, HttpServletRequest req) {
		
		logger.info("후기 글 삭제");
		
		int reviewno = Integer.parseInt(req.getParameter("reviewno"));
		
		sellerService.delete(reviewno);
		
		return "redirect:/seller/review/list";
	}

	@RequestMapping(value="/seller/review/mylist", method=RequestMethod.GET)
	public void reviewMyList(Review review, Model model, HttpSession session, HttpServletRequest req) {
		
		logger.info("내가 쓴 후기 리스트");
		
		//현재 페이지 번호 얻기
		int curPage = sellerService.getCurPage(req);
		
		//내 후기글 수 얻기
		review.setSellerId( (String)session.getAttribute("sellerId") );
		int myTotalCount = sellerService.getMyTotalCount(review);
		
		//페이지 객체 생성
		Paging paging = new Paging(myTotalCount, curPage);
		paging.setSellerId( (String)session.getAttribute("sellerId") );
		
		//페이징객체 MODEL로 추가
		model.addAttribute("paging", paging);
		
		//내 후기글 목록 MODEL로 추가
		List<Review> reviewMylist = sellerService.getPagingMyList(paging);
		model.addAttribute("reviewMylist", reviewMylist);

	}
	
		
	@RequestMapping(value="/seller/review/reply/insert", method=RequestMethod.POST)
	public String replyWrite(ReviewReply reviewReply, Model model) {
		
		logger.info("댓글 달기");
//		System.out.println(reviewReply.toString());		 
		
		//댓글 입력
		sellerService.replyWrite(reviewReply);
		
		//댓글 리스트 MODEL 추가
		List<ReviewReply> replyList = sellerService.getReplyList(reviewReply.getReviewNo());

		model.addAttribute("replyList", replyList);
		
		return "redirect:/seller/review/view?reviewNo=" + reviewReply.getReviewNo();
		
	}
	
	@RequestMapping(value="/seller/review/reply/delete", method=RequestMethod.POST)
	public String replyDelete(int replyNo, int reviewNo) {
		
		logger.info("댓글 삭제");

//		System.out.println(replyNo);
//		System.out.println(reviewNo);
		
		sellerService.replyDelete(replyNo);

//		return "redirect:/seller/review/view?reviewNo=" + reviewNo;
		return "jsonView";
	}

	@RequestMapping(value="/seller/review/reply/update", method=RequestMethod.POST)
	public String replyUpdate(int replyNo, String updateContent, ReviewReply reviewReply, Model model) {
		
		logger.info("댓글 수정");
		
		reviewReply.setReplyNo(replyNo);
		reviewReply.setReplyContent(updateContent);
//		reviewReply.setReviewNo(reviewNo);
		
		sellerService.replyUpdate(reviewReply);
		
		//댓글 리스트 MODEL 추가
//		List<ReviewReply> replyList = sellerService.getReplyList(reviewNo);
//		
//		model.addAttribute("replyList", replyList);
		
		return "jsonView";
		
	}
}
