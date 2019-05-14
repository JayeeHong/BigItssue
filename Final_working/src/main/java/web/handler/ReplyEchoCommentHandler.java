package web.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import web.dto.User;

public class ReplyEchoCommentHandler  extends TextWebSocketHandler {
	
	//웹소켓 session들을 담는 List
	public List<WebSocketSession> sessionsComnnet = new ArrayList<>();
	//httpSession의 id를 key로하고 웹소켓 session을 value로 하는 Map
	public Map<String, WebSocketSession> userSessionsComnnet = new HashMap<>(); 
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyEchoCommentHandler.class);
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		//---------- 웹소켓 연결됐을때 동작!!!!! --------------------------
		logger.info("댓글용 웹소켓 연결:"+session);
		
		
		//---------- 웹소켓 session List에 추가 -------------------------
		sessionsComnnet.add(session);
		//---------------------------------------------------------
		
		
		//---------- httpSession의id, 웹소켓 session Map에 추가 ----------
		userSessionsComnnet.put(getLoginInfo(session).getId(), session);
		//----------------------------------------------------------
		
		//----------- 확인--------------------------------------------
		logger.info("[TEST]sessionsComnnet확인(댓글용):"+sessionsComnnet);
		logger.info("[TEST]userSessionsComnnet확인(댓글용):"+userSessionsComnnet);
		//-----------------------------------------------------------
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message ) throws Exception{
		logger.info("댓글용 웹소켓 전달받음");
		logger.info("///////////////////////////////////////////////////////////////////////////");
		logger.info("message:"+message.getPayload());
		
		//----------웹소켓으로 접속된 사람들만 반복 -----------------
		for(WebSocketSession sess: userSessionsComnnet.values()) {
			
			//---------- 메시지 전송 ------------------------------
			sess.sendMessage(new TextMessage(message.getPayload()));
			//-------------------------------------------------
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		logger.info("댓글용 웹소켓 끊김");
	}
	
	//웹소켓 session과 연동된 httpSession의LoginInfo 불러오기
	private User getLoginInfo(WebSocketSession session) {
		
		//웹소켓session.getAttributes()하면 httpSession을 Map형식으로 불러올 수 있다
		Map<String, Object> httpSession = session.getAttributes();
		
		//httpSession의 LoginInfo정보 불러오기
		User loginUser = (User)httpSession.get("LoginInfo");
		
		return loginUser;
	}

}
