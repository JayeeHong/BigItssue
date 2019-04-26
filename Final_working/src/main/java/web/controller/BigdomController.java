package web.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import web.dto.BigdomInfo;
import web.service.face.BigdomService;

@Controller
public class BigdomController {
	
	private static final Logger logger
	= LoggerFactory.getLogger(BigdomController.class);
	
	@Autowired BigdomService bigdomService;
	
	@RequestMapping(value="/bigdom/main", method=RequestMethod.GET)
	public void bigdomMain() { }
	
	@RequestMapping(value="/bigdom/login", method=RequestMethod.POST)
	public String bigdomLogin(BigdomInfo bigdomInfo, HttpSession session) {
		
		// 로그인
		if(bigdomService.login(bigdomInfo)) { // 로그인 성공 시
			
			session.setAttribute("bigdomLogin", true);
			session.setAttribute("bigdomId", bigdomInfo.getBigdomId());
			
			// 빅돔 전체 정보 가져오기
			bigdomInfo = bigdomService.getBigdomInfo(bigdomInfo.getBigdomId());
			
		}
		
		return "redirect:/bigdom/main";
	}
	
	@RequestMapping(value="/bigdom/logout", method=RequestMethod.GET)
	public String bigdomLogout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/bigdom/main";
	}

}
