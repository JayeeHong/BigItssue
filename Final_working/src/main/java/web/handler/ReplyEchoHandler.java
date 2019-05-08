package web.handler;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import web.dto.Chat;
import web.dto.Message;
import web.dto.User;
import web.service.face.ChatService;

public class ReplyEchoHandler extends TextWebSocketHandler {
	
	//웹소켓 session들을 담는 List
	public List<WebSocketSession> sessions = new ArrayList<>();
	//httpSession의 id를 key로하고 웹소켓 session을 value로 하는 Map
	public Map<String, WebSocketSession> userSessions = new HashMap<>(); 
	//웹소켓 session을 key로하고 httpSession의 방번호를 value로 하는 Map
	public Map<WebSocketSession, Integer> RoomSessions = new HashMap<>();  
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyEchoHandler.class);
	
	@Autowired private ChatService chatService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		
		System.out.println("afterConnectionEstablished:"+session);
		
		//웹소켓 session List에 추가
		sessions.add(session);
		
		//웹소켓 session과 연동된 httpSession의id 불러오기
		String senderId=getLoginInfo(session).getId();
		
		//httpSession의id, 웹소켓 session Map에 추가
		userSessions.put(senderId, session);
		
		logger.info("[TEST]sessions:"+sessions);
		logger.info("[TEST]userSessions:"+userSessions);
		logger.info("[TEST]userSessions.values():"+userSessions.values());
		
		//웹소켓 session과 연동된 httpSession의 chatRoomNo 불러오기
		int chatRoomNo =  (int)getHttpSession(session).get("chatRoomNo");
		logger.info("[TEST]chatRoomNo:"+chatRoomNo);
		
		//웹소켓 session, httpSession의 chatRoomNo Map에 추가 
		RoomSessions.put(session, chatRoomNo);
		logger.info("[TEST]RoomSessions:"+RoomSessions);
		
		//----- 이곳이 메시지를 읽었다 라고 인식해주는 부분. -----
		//----- 읽은 메시지는 1로, 읽지 않은 메시지는 0(default값)으로 표시. -----
		//보내는사람=로그인된id이면, 방번호에 맞는 모든메시지의 senderChk 1로
		//보내는사람!=로그인된id이면, 방번호에 맞는 모든메시지의 receiverChk 1로
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message ) throws Exception{
		System.out.println("handTextMessage:"+session+" :  " +message);
		
		//현재 HttpSession의 id얻기
		String senderId = getLoginInfo(session).getId();
		//현재 HttpSession의 sort얻기
		String senderSort = getLoginInfo(session).getSort();
		//현재 웹소켓 session의 방번호 가져오기
		int roomNo = RoomSessions.get(session);
		
		//-----Message DB에 저장-----
		
		Message msg = new Message();
		msg.setChatContent(message.getPayload());
		msg.setChatSender(senderId);
		msg.setChatRoomNo(roomNo);
		
		chatService.insertMessage(msg);
		
		//메시지 저장한 시간 msg로 반환 받음.확인.
		logger.info("[TEST]msg:"+msg.toString());
		
		//Date보기 좋게 변경
		SimpleDateFormat date = new SimpleDateFormat("yyyy/MM/dd");
		SimpleDateFormat time = new SimpleDateFormat("hh:mm a");
//		SimpleDateFormat dateTime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		
		String presentTime=time.format(msg.getChatDate());
		logger.info("메시지 시간:"+presentTime);

		
		
		//-------------------------

		//현재 방번호에 맞는 상대방 아이디 다 가져오기
		Chat Ids = chatService.selectChatRoomIds(roomNo);
		
		logger.info("Ids:"+Ids);
		
		String counterpartId =null;
		String counterpartSort =null;
		
		//현재 방번호에 맞는 상대방id 가져오기
		if(Ids.getBuyerId() != null && !Ids.getBuyerId().equals(senderId)) {
			counterpartId = Ids.getBuyerId();
			counterpartSort = "구매자";
		}else if(Ids.getSellerId() != null && !Ids.getSellerId().equals(senderId)) {
			counterpartId = Ids.getSellerId();
			counterpartSort = "판매자";
		}else{
			counterpartId = Ids.getBigdomId();
			counterpartSort = "빅돔";
		}
		
		logger.info("counterpartId:"+counterpartId);
		
		//selectRooms()함수의 매개변수가 UserDto타입이라서 만들어줌
		User user = new User();
		user.setId(counterpartId);
		user.setSort(counterpartSort);
		logger.info("user:"+user);
		
		//현재 방번호에 맞는 상대방id가 들어있는 방번호 모두 불러오기.
		List<Chat> chatRoomList = chatService.selectRooms(user);
		
		logger.info("chatRoomList:"+chatRoomList);
		
		//웹소켓에 접속된 사람들만 반복
		for(WebSocketSession sess: userSessions.values()) {
			//상대방id의 방번호에 대해서 모두 검사
			for(int i=0; i<chatRoomList.size(); i++) {
				//상대방id의 방(방번호)모든 곳에 메시지 전송.
				if(RoomSessions.get(sess)==chatRoomList.get(i).getChatRoomNo() || RoomSessions.get(sess)==-1) {
					//보낼때, (핸들러를 요청한 웹소켓의 방번호)#(보내는Id:내용)#(시간) 이런식으로 메시지 전송.
					sess.sendMessage(new TextMessage(""+RoomSessions.get(session)+"#"+senderId + "#" + message.getPayload()+"#"+presentTime));
				}
			}
		}
		
	}
	
	//웹소켓 session과 연동된 httpSession 불러오기
	private Map getHttpSession(WebSocketSession session) {
		
		//웹소켓session.getAttributes()하면 httpSession을 Map형식으로 불러올 수 있다
		Map<String, Object> httpSession = session.getAttributes();
			
		return httpSession;
	}
		
	//웹소켓 session과 연동된 httpSession의LoginInfo 불러오기
	private User getLoginInfo(WebSocketSession session) {
		
		//웹소켓session.getAttributes()하면 httpSession을 Map형식으로 불러올 수 있다
		Map<String, Object> httpSession = session.getAttributes();
		
		//httpSession의 LoginInfo정보 불러오기
		User loginUser = (User)httpSession.get("LoginInfo");
		
		return loginUser;
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		System.out.println("afterConnectionEstablished:"+session+" : "+ status);
		System.out.println(session.getId() + " 연결 종료됨");
		sessions.remove(session);
		System.out.println("[TEST]sessions에서 session정보 지웠는지 확인:"+sessions);
		RoomSessions.remove(session);
		System.out.println("[TEST]RoomSessions에서 session정보 지웠는지 확인:"+RoomSessions);
		userSessions.remove(getLoginInfo(session).getId());
		System.out.println("[TEST]userSessions에서 session정보 지웠는지 확인:"+userSessions);
		
	}
	
	
}
 