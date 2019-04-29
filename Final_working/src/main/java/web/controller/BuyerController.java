package web.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import web.dto.SellerLoc;
import web.dto.User;
import web.service.face.BuyerService;
import web.util.SellerLocPaging;

@Controller
public class BuyerController {
	
	private static final Logger logger = LoggerFactory.getLogger(BuyerController.class);
	
	@Autowired BuyerService buyerService;

	@RequestMapping(value="/buyer/main", method=RequestMethod.GET)
	public void buyerMain(
			@RequestParam(defaultValue="0") String curPage,
			Model model) { 
		
		//현재 페이지 번호 얻기
		logger.info("curPage:"+curPage);
		
		//총 게시글 수 얻기
		int totalCount = buyerService.getTotalCountOfSellerLoc();
		
		logger.info("totalCount:"+totalCount);
		
		//페이지 객체 생성
		SellerLocPaging paging = new SellerLocPaging(totalCount, Integer.parseInt(curPage));
		
		logger.info("paging:"+paging);
		
		List<SellerLoc> sellerLocList = buyerService.getPagingListOfSellerLoc(paging);
		
		logger.info("sellerLocList:"+sellerLocList);
			
		//조회 결과를 VIEW에 전달하기
		model.addAttribute("sellerLocList", sellerLocList);

		//페이징 객체 MODEL로 추가
		model.addAttribute("paging", paging);
		
	}
	
	@RequestMapping(value="/buyer/locview", method=RequestMethod.GET)
	public void buyerLocView(int locNo, Model model) {
		
		logger.info("locNo:"+locNo);
		//locNo에 맞는 SellerLoc 조회
		SellerLoc sellerLoc = buyerService.getSellerLoc(locNo);
		
		logger.info("sellerLoc:"+sellerLoc);
		
		model.addAttribute("sellerLoc", sellerLoc);
				
		//locNo에 맞는 magazineNo으로 북리스트 조회
		BookListInfo bookListInfo = buyerService.getBookListInfo(sellerLoc.getMagazineNo());
		
		logger.info("bookListInfo:"+bookListInfo);
		
		model.addAttribute("bookListInfo", bookListInfo);
			
	}
	
	@RequestMapping(value="/sellerLocMap", method=RequestMethod.GET)
	public void buyerSellerLocMap(String zone, String station, String spot, Model model) {
		logger.info("역 :" +station +" || 출구 : "+ spot);
	
		
		if(zone.contains("/")) {
			String[] str = zone.split("/");
			zone = str[0];
			
			Map map = new HashMap();
			map.put("zone", zone);
			map.put("station", station);
			map.put("spot", spot);
			logger.info("맵! : "+map);
			model.addAttribute("map", map);
		} else {
			Map map = new HashMap();
			map.put("zone", zone);
			map.put("station", station);
			map.put("spot", spot);
			logger.info("맵! : "+map);
			model.addAttribute("map", map);
		}
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

		
		String subject = "가입인증 메일입니다 "; //메일 제목 입력해주세요. 
		String frontBody = "인증코드란에 "; //앞단
		String middleBody = code;
		String endBody = "를 써주세요"; //뒷단
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
		
		System.out.println(buyerInfo.toString());
		
		buyerService.buyerJoin(buyerInfo);
		
		return "redirect:/buyer/login";
	}
	
	
	@RequestMapping(value="/buyer/login", method=RequestMethod.GET)
	public void buyerLoginForm() {
		
	}
	
	@RequestMapping(value="/buyer/login", method=RequestMethod.POST)
	public String buyerLogin(BuyerInfo buyerInfo, HttpSession session) {
		
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
			
			buyerInfo.setBuyerPw(newPw);
			
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
	
	@RequestMapping(value="/buyer/my/booking", method=RequestMethod.GET)
	public void myBooking() { // 마이페이지-예약내역
		
	}
	
	@RequestMapping(value="/buyer/my/chat", method=RequestMethod.GET)
	public void myChat() { // 마이페이지-문의내역
		
	}
	
	@RequestMapping(value="/buyer/my/info", method=RequestMethod.GET)
	public void myInfo() { // 마이페이지-정보수정
		
	}
	
	@RequestMapping(value="/buyer/my/confirmpw", method=RequestMethod.POST)
	public String myPwConfirm(BuyerInfo buyerInfo) { // 마이페이지-정보수정 -> 비밀번호확인
		
//		logger.info(buyerInfo.toString());
		
		
		
		return "redirect:/buyer/my/info";
	}
}
