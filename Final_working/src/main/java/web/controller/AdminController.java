package web.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import web.dto.SellerLoc;
import web.service.face.AdminService;

@Controller
public class AdminController {
	@Autowired ServletContext context;
	@Autowired AdminService adminService;
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@RequestMapping(value="/admin/main", method=RequestMethod.GET)
	public void adminMain() {
		//ㄴㄴㄴㄴㄴㄴ
	}
	
	@RequestMapping(value="/admin/seller/list", method=RequestMethod.GET)
	public void adminSellseView() {

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
	public void adminNoticeList(
			Model model
			) {
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
	
	
	@RequestMapping(value="/admin/notice/view", method=RequestMethod.GET)
	public void adminNoticeView(Notice notice, Model model) {
		
			
		Notice no = adminService.noticeView(notice);
		
		model.addAttribute("notice", no);
		
	}
	@RequestMapping(value="/admin/notice/write", method=RequestMethod.GET)
	public void noticeWriteForm() {
		
	}
	
	@RequestMapping(value="/admin/notice/write", method=RequestMethod.POST)
	public void noticeWriteInsert(
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
				
				
			
				
				
				//파일 저장 경로
				String path = context.getRealPath("upload");
				
				//저장될 파일
				File dest = new File(path, notice.getNoticeImg());
				
				
				
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
	
	
	@RequestMapping(value="/admin/notice/delete", method=RequestMethod.POST)
	public void adminNoticeDelete(Notice notice, HttpServletResponse res) throws IOException {
		
		PrintWriter out = null;
		res.setContentType("text/html; charset=UTF-8");
		out = res.getWriter();
		
		adminService.adminNoticeDelete(notice);
		
		out.println("<script>alert('삭제되었습니다.'); location.href='/admin/notice/list'</script>" );
		out.flush();
		
		
	}
	
	
	@RequestMapping(value="/admin/loc/list", method=RequestMethod.GET)
	public void locList(String zone, Model model) {
		logger.info("zone : " + zone);
		if(zone != null) {
			List<SellerLoc> list = adminService.viewLoc(zone);
			
			logger.info(String.valueOf(list));
			model.addAttribute("locList", list);
		}
		
	}
	
	
	@RequestMapping(value="/admin/loc/detail", method=RequestMethod.GET)
	public void locDetail(String station, Model model) {
		logger.info("station : "+station);
		
		if(station != null) {
			List<SellerLoc> list = adminService.viewDetail(station);
			
			logger.info(String.valueOf(list));
			model.addAttribute("detailList", list);
			model.addAttribute("station", station);
		}
	}
}
