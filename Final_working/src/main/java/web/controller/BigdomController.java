package web.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;

import web.dto.BigdomInfo;
import web.dto.Chat;
import web.dto.Message;
import web.dto.User;
import web.service.face.BigdomService;
import web.service.face.ChatService;

@Controller
public class BigdomController {
	
	private static final Logger logger
	= LoggerFactory.getLogger(BigdomController.class);
	
	@Autowired BigdomService bigdomService;
	@Autowired ChatService chatService;
	
	@RequestMapping(value="/bigdom/main", method=RequestMethod.GET)
	public String bigdomMain(
			@RequestParam(defaultValue="-1") int chatRoomNo, HttpSession session, Model model) { 
		
		logger.info("chatRoomNo:"+chatRoomNo);

		session.setAttribute("chatRoomNo", chatRoomNo);
		
		//-------------------채팅내역 방들(사이드에 보이는 채팅방들)을 보여지기 위한 model설정--------------------
		User LoginInfo = (User)session.getAttribute("LoginInfo");
		logger.info("LoginInfo:"+LoginInfo);
		if(LoginInfo==null) {
			return "bigdom/main";
		}
			
		List<Chat> chatRoomList = chatService.selectRooms(LoginInfo);
		
		//채팅내역의 상대방 이름을 띄워 주기 위해서 추가
		//Chat의 TheOtherParty에
		//chatRoomList속에 있는 Chat를 하나하나 조사해서 로그인된 아이디와 같지않고 null이 아닌 아이디를 넣어주자.
		for(int i=0; i<chatRoomList.size(); i++) {
			if(chatRoomList.get(i).getBuyerId() != null && !chatRoomList.get(i).getBuyerId().equals(LoginInfo.getId())) {
				chatRoomList.get(i).setTheOtherParty(chatRoomList.get(i).getBuyerId());
			}else if(chatRoomList.get(i).getSellerId() != null && !chatRoomList.get(i).getSellerId().equals(LoginInfo.getId())) {
				chatRoomList.get(i).setTheOtherParty(chatRoomList.get(i).getBuyerId());
			}else if(chatRoomList.get(i).getBigdomId() != null && !chatRoomList.get(i).getBigdomId().equals(LoginInfo.getId())) {
				chatRoomList.get(i).setTheOtherParty(chatRoomList.get(i).getBuyerId());
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
		
		return "bigdom/main";
	}
	
	@RequestMapping(value="/bigdom/login", method=RequestMethod.POST)
	public String bigdomLogin(BigdomInfo bigdomInfo, HttpSession session) {
		
		User LoginInfo = null;
		
		// 로그인
		if(bigdomService.login(bigdomInfo)) { // 로그인 성공 시
			
			session.setAttribute("bigdomLogin", true);
			session.setAttribute("bigdomId", bigdomInfo.getBigdomId());
			
			// 빅돔 전체 정보 가져오기
			bigdomInfo = bigdomService.getBigdomInfo(bigdomInfo.getBigdomId());
			
			//User으로 정보가 필요해서 추가
			LoginInfo = bigdomService.getBigdomInfoUser(bigdomInfo);
			session.setAttribute("LoginInfo", LoginInfo);
			
		}
		
		return "redirect:/bigdom/main";
	}
	
	@RequestMapping(value="/bigdom/logout", method=RequestMethod.GET)
	public String bigdomLogout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/bigdom/main";
	}

}
