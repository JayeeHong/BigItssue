package web.service.impl;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.ChatDao;
import web.dto.Chat;
import web.dto.Message;
import web.dto.User;
import web.service.face.ChatService;


@Service
public class ChatServiceImpl implements ChatService{
	
	private static final Logger logger = LoggerFactory.getLogger(ChatServiceImpl.class);
	
	@Autowired ChatDao chatDao;
	
	public Chat getChat(User user, HttpSession session) {
		
		//현재 로그인의 정보
		User LoginInfo = (User)session.getAttribute("LoginInfo");
		
		//현재 로그인한 id
		String sessionId = LoginInfo.getId();
		//문의하기 눌렀을때의 상대방 id
		String opposingId = user.getId();
		//문의하기 눌렀을때의 상대방 sort
		String opposingSort = user.getSort();
		
		//chat방DB에 데이터 전달을 위한 DTO
		Chat chat = new Chat();
		
		//chat에 상대방id를 저장
		if(opposingSort.equals("판매자")) {
			chat.setSellerId(opposingId);
		}else if(opposingSort.equals("빅돔")) {
			chat.setBigdomId(opposingId);
		}
		//chat에 나의id(무조건 구매자) 저장
		chat.setBuyerId(sessionId);
		
		return chat;
	}
	
	@Override
	public boolean createRoomChk(Chat chat) {
				
		//chat에 저장한 id에 맞는 방이 몇개있는지 검사
		int cnt = chatDao.selectCntChatByIds(chat);
		
		logger.info("cnt:"+cnt);
		
		//회원 정보 있는지 확인
		if( cnt == 0 ) {
			return true; //방만들기
		} else {
			return false; //방만들지 않기
		}
	}

	@Override
	public int createRoom(Chat chat) {
			
		logger.info("[방만들기 전]chat:"+chat);
		
		chatDao.insertRoom(chat);
		
		logger.info("[방만들고 난후]chat:"+chat);
		
		return chat.getChatRoomNo();
		
	}

	@Override
	public int selectRoom(Chat chat) {
		
		return chatDao.selectRoom(chat);
	}

	@Override
	public List<Chat> selectRooms(User LoginInfo) {
		return chatDao.selectRooms(LoginInfo);
	}

	@Override
	public List<Message> selectMessage(int chatRoomNo) {
		return chatDao.selectMessage(chatRoomNo);
	}

	@Override
	public Message selectSubMessage(int chatRoomNo) {
		return chatDao.selectSubMessage(chatRoomNo);
	}

	@Override
	public void insertMessage(Message msg) {
		chatDao.insertMessage(msg);
		
	}

	@Override
	public Chat selectChatRoomIds(int roomNo) {
		return chatDao.selectChatRoomIds(roomNo);
	}
	
	
}
