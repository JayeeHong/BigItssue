package web.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import web.dto.BookListInfo;
import web.dto.Reservation;
import web.dto.SellerInfo;
import web.dto.SellerLoc;
import web.service.face.SellerService;

@Controller
public class SellerController {
	
	private static final Logger logger
	= LoggerFactory.getLogger(SellerController.class);
	
	@Autowired SellerService sellerService;
	
	@RequestMapping(value="/seller/main", method=RequestMethod.GET)
	public void sellerMain() { }
	
	@RequestMapping(value="/seller/login", method=RequestMethod.POST)
	public String sellerLogin(
			SellerInfo sellerInfo,
			HttpSession session) {
		
		// 로그인
		if(sellerService.login(sellerInfo)) { // 로그인 성공 시
			session.setAttribute("sellerLogin", true);
			session.setAttribute("sellerId", sellerInfo.getSellerId());
//			logger.info(sellerInfo.toString());
			
			// 판매자 전체 정보 가져오기
			sellerInfo = sellerService.getSellerInfo(sellerInfo.getSellerId());
//			logger.info(sellerInfo.toString());
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
		
		logger.info(sellerLoc.toString());
		
		String startTime = sellerLoc.getSellerTimeS();
		String startTime1 = startTime.substring(0, 2);
		String startTime2 = startTime.substring(2, 4);
		
		String endTime = sellerLoc.getSellerTimeE();
		String endTime1 = endTime.substring(0, 2);
		String endTime2 = endTime.substring(2, 4);
		
//		logger.info(startTime1 + ":" + startTime2);
		//---------------

		// 판매부수 조회
		List<BookListInfo> bookListInfo = sellerService.getBookList(sellerId);
		
		logger.info(bookListInfo.toString());
		
		model.addAttribute("startTime1", startTime1);
		model.addAttribute("startTime2", startTime2);
		model.addAttribute("endTime1", endTime1);
		model.addAttribute("endTime2", endTime2);
		model.addAttribute("sellerTimeS", sellerLoc.getSellerTimeS());
		model.addAttribute("sellerTimeE", sellerLoc.getSellerTimeE());
		
		model.addAttribute("bookListInfo", bookListInfo);
		
	}
	
	@RequestMapping(value="/seller/updateTime", method=RequestMethod.POST)
	public String updateTime(SellerLoc sellerLoc, HttpSession session) {
		
//		logger.info("변경할 시간:"+sellerLoc);
		
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
		
		if(Integer.parseInt(startTime2)>=0 && Integer.parseInt(startTime2)<10) {
			sellerTimeS = startTime1 + "0" + startTime2;
		} else {
			sellerTimeS = startTime1 + startTime2;
		}
		logger.info("sellerTimeS:"+sellerTimeS);
		
		if(Integer.parseInt(endTime2)>=0 && Integer.parseInt(endTime2)<10) {
			sellerTimeE = endTime1 + "0" + endTime2;
		} else {
			sellerTimeE = endTime1 + endTime2;
		}
		logger.info("sellerTimeE:"+sellerTimeE);
		
		sellerLoc.setSellerTimeS(sellerTimeS);
		sellerLoc.setSellerTimeE(sellerTimeE);
		
		// 시간 변경
		sellerService.setSellerTime(sellerLoc);
		
		return "redirect:/seller/time";
	}
	
	@RequestMapping(value="/seller/mUpdate", method=RequestMethod.POST)
	public String mUpdate(BookListInfo bookListInfo) {
		
//		logger.info("수정할 내용:"+bookListInfo.toString());
		
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
		
		// 판매자의 예약내역 조회
		List<Reservation> bookListInfo = sellerService.getReserve(sellerId);
		
		// --- 수령시간이 지났을 경우 취소상태로 변경하기 ---
		// 1. 현재시간과 수령시간 비교
//		logger.info("수령시간:"+bookListInfo.get(0).getPickupDate().toString());
		
		Date sysdate = new Date(); // 현재시간
		
		// 2. bookListInfo의 크기동안 반복
		for(int i=0; i<bookListInfo.size(); i++) {
			if(sysdate.before(bookListInfo.get(i).getPickupDate())) {
//				logger.info("현재시간이 더 큼");
				
			} else { 
//				logger.info("DB시간이 더 큼");
				
				// 3. DB에 저장된 시간이 현재시간보다 클때 취소상태로 변경
				sellerService.setPickupDate(bookListInfo.get(i));
			}
		}
		
		// 4. 예약내역 재조회
		bookListInfo = sellerService.getReserve(sellerId);
		// ------------------------------------------ 상태변경 끝
		
		model.addAttribute("bookListInfo", bookListInfo);
		
	}
	
	@RequestMapping(value="/seller/bookCancel", method=RequestMethod.GET)
	public String bookCancel(Reservation reservation) {
		
//		logger.info(reservation.toString());
		
		// reserveNo로 예약내역-예약취소로 변경
		sellerService.cancelReserve(reservation.getReserveNo());
		
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

}
