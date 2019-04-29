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

	@Autowired AdminService adminService;
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@RequestMapping(value="/admin/main", method=RequestMethod.GET)
	public void adminMain() {
		//ㄴㄴㄴㄴㄴㄴ
	}
	
	//
	
	@RequestMapping(value="/admin/seller/view", method=RequestMethod.GET)
	public void adminSellseView() {
		
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
