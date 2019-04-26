package web.controller;

import java.text.ParseException;
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

import web.dto.Chat;
import web.dto.Message;
import web.dto.User;
import web.service.face.ChatService;


@Controller
public class ChattingController {
	
	@Autowired private ChatService chatService;
	
	private static final Logger logger
		= LoggerFactory.getLogger(ChattingController.class);
	
	@RequestMapping(value="/createRoom", method=RequestMethod.GET)
	public String createRoom(User user, HttpSession session, Model model) {
		
		//현재 넘어온 user에는 문의하기 버튼을 클릭했을때,
		//상대방에 대한 정보가 들어있음.
		
		//로그인한id와 문의하기버튼눌렀을때 상대방id chat에 저장
		Chat chat = chatService.getChat(user, session);
		
		//방이 이미 존재하는지 판단
		boolean createRoomChk =  chatService.createRoomChk(chat);
		//-1로 방번호 초기화
		int chatRoomNo = -1;
		
		if(createRoomChk==true) {
			
			logger.info("[방만들기]");
			chatRoomNo = chatService.createRoom(chat);
			logger.info("chatRoomNo:"+chatRoomNo);
			
			
		}else {
			logger.info("[방안만들기]");
			chatRoomNo = chatService.selectRoom(chat);
			logger.info("chatRoomNo:"+chatRoomNo);
		}
		
		//웹소켓 핸들러클래스에서 방번호를 사용하기위해서 session에 저장
		session.setAttribute("chatRoomNo", chatRoomNo);
		
		//-------------------채팅내역 방들(사이드에 보이는 채팅방들)을 보여지기 위한 model설정--------------------
		User LoginInfo = (User)session.getAttribute("LoginInfo");
		
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
			//현재 date받아오기
			tempTime = subMsg.getChatDate();
			//date를 이쁜String으로 바꾸기
			stringTime = time.format(tempTime);		
			//subMsgList에 stringChatDate설정
			subMsg.setStringChatDate(stringTime);

			if(subMsg != null) {
				subMsgList.add(subMsg);
			}
			
		}
		
		//주채팅창 message list
		logger.info("primaryMsgList:"+primaryMsgList);
		model.addAttribute("primaryMsgList", primaryMsgList);
		
		//보조채팅창 message list
		logger.info("subMsgList:"+subMsgList);
		model.addAttribute("subMsgList", subMsgList);
		
		return "/chat/chat";
	}
	
	@RequestMapping(value="chatRoomListAjax", method=RequestMethod.POST)
	public String chatRoomListAjax(HttpSession session, Model model) {
		
		User LoginInfo = (User)session.getAttribute("LoginInfo");
		
		List<Chat> refreshChatRoomList = chatService.selectRooms(LoginInfo);
		
		logger.info("refreshChatRoomList:"+refreshChatRoomList);
		
		model.addAttribute("refreshChatRoomList",refreshChatRoomList);
		
		return "jsonView";
	}
	@RequestMapping(value="/chatting",method=RequestMethod.GET)
	public String requestParamGet(int chatRoomNo, HttpSession session, Model model) {
		
		logger.info("chatRoomNo:"+chatRoomNo);

		session.setAttribute("chatRoomNo", chatRoomNo);
		
		//-------------------채팅내역 방들(사이드에 보이는 채팅방들)을 보여지기 위한 model설정--------------------
		User LoginInfo = (User)session.getAttribute("LoginInfo");
			
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
			//현재 date받아오기
			tempTime = subMsg.getChatDate();
			//date를 이쁜String으로 바꾸기
			stringTime = time.format(tempTime);		
			//subMsgList에 stringChatDate설정
			subMsg.setStringChatDate(stringTime);

			if(subMsg != null) {
				subMsgList.add(subMsg);
			}
			
		}
		
		//주채팅창 message list
		logger.info("primaryMsgList:"+primaryMsgList);
		model.addAttribute("primaryMsgList", primaryMsgList);
		
		//보조채팅창 message list
		logger.info("subMsgList:"+subMsgList);
		model.addAttribute("subMsgList", subMsgList);
		
		return "/chat/chat";
	}
		
	@RequestMapping(value="/roomOut", method=RequestMethod.GET)
	public String roomOut(HttpSession session) {	
		
		User LoginInfo = (User)session.getAttribute("LoginInfo");
		
		session.removeAttribute("chatRoomNo");
		System.out.println("[TEST]룸세션 삭제확인:"+session);
		
		//리다이렉트
		if(LoginInfo.getSort().equals("구매자")) {
			return "redirect:/buyer/main";
		}else if(LoginInfo.getSort().equals("판매자")) {
			return "redirect:/seller/main";
		}
		return "redirect:/bigdom/main";
	}

}
