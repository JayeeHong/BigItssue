package web.handler;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

import web.dto.ReviewReply;
import web.dto.User;
import web.service.face.SellerService;

public class ReplyEchoCommentHandler  extends TextWebSocketHandler {
	
	//웹소켓 session들을 담는 List
	public List<WebSocketSession> sessionsComnnet = new ArrayList<>();
	//httpSession의 id를 key로하고 웹소켓 session을 value로 하는 Map
	public Map<String, WebSocketSession> userSessionsComnnet = new HashMap<>(); 
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyEchoCommentHandler.class);
	
	@Autowired SellerService sellerService;
	
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
		
		Gson gson = new Gson();			
		
		ReviewReply reviewReply = gson.fromJson(message.getPayload(), ReviewReply.class);
		logger.info("reviewReply:"+reviewReply);
		
		//댓글 입력
		sellerService.replyWrite(reviewReply);
		
		//
		reviewReply = sellerService.getReply(reviewReply.getReplyNo());
		
		//----- reviewReply의 날짜형식 바꿔주기 -----
		// append로 댓글 넣으려했는데 <fmt>태그를 인식못해서 여기서 바꿔주었음.
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String presentTime=time.format(reviewReply.getReplyDate());
		
		reviewReply.setStringDate(presentTime);

		//------------------------------------

		
		//map형태로 보내주기 위해 map생성
		Map map = new HashMap<>();

		map.put("reviewReply", reviewReply);
		
		//댓글방 주인
		String reviewViewSellerId = reviewReply.getReviewViewSellerId();
		
		//-------------------------------------------------
		
		//----------웹소켓으로 접속된 사람들만 반복 -----------------
		for(WebSocketSession sess: userSessionsComnnet.values()) {
			
			//---------- 메시지 전송 ------------------------------
			//Gson이용해서 map을 json형태로 보내주기
			sess.sendMessage(new TextMessage(gson.toJson(map)));
			//-------------------------------------------------

		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		logger.info("댓글용 웹소켓 끊김");
		//---------- 현재 웹소켓을 sessions에서 제거 --------------
		sessionsComnnet.remove(session);
		System.out.println("[TEST]sessions에서 session정보 지웠는지 확인:"+sessionsComnnet);
		//------------------------------------------------
		
		//------------------------------------------------
		
		//---------- 현재 웹소켓을 userSessions에서 제거 ----------
		userSessionsComnnet.remove(getLoginInfo(session).getId());
		System.out.println("[TEST]userSessions에서 session정보 지웠는지 확인:"+userSessionsComnnet);
		//------------------------------------------------
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
