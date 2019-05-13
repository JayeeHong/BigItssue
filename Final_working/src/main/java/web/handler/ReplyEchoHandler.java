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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import web.dto.Chat;
import web.dto.Message;
import web.dto.MessageChk;
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
		
		//---------- 웹소켓 연결됐을때 동작!!!!! --------------------------
		System.out.println("afterConnectionEstablished:"+session);
		
		
		//---------- 웹소켓 session List에 추가 -------------------------
		sessions.add(session);
		//---------------------------------------------------------
		
		
		//---------- httpSession의id, 웹소켓 session Map에 추가 ----------
		userSessions.put(getLoginInfo(session).getId(), session);
		//----------------------------------------------------------
		
		
		//---------- 현재 웹소켓의 chatRoomNo 불러오기 ----------------------
		int chatRoomNo=0;
		if(getHttpSession(session).get("chatRoomNo")==null) {
			chatRoomNo = -1;		
		}else { 
			chatRoomNo =  (int)getHttpSession(session).get("chatRoomNo");
		}
		//-----------------------------------------------------------
		
		
		//---------- 웹소켓 session, httpSession의 chatRoomNo Map에 추가 ---
		RoomSessions.put(session, chatRoomNo);
		//-----------------------------------------------------------
		
		//----------- 확인--------------------------------------------
		logger.info("[TEST]sessions확인:"+sessions);
		logger.info("[TEST]userSessions확인:"+userSessions);
		logger.info("[TEST]RoomSessions확인:"+RoomSessions);
		//-----------------------------------------------------------
		
		
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message ) throws Exception{
		
		//---------- 웹소켓이 메시지 송신했을때 동작!!!!! ------------
		//알아둬야할것 => session은 송신자의 웹소켓
		
		//---------- 송신자에 대한 정보 얻어오기 --------------------
		//송신자의 id얻기
		String senderId = getLoginInfo(session).getId();
		//송신자의 sort얻기
		String senderSort = getLoginInfo(session).getSort();
		//송신자의 roomNo얻기
		int roomNo = RoomSessions.get(session);
		//-------------------------------------------------
		
		//---------- Message DB에 저장 -----------------------	
		Message msg = new Message();
		msg.setChatContent(message.getPayload());
		msg.setChatSender(senderId);
		msg.setChatRoomNo(roomNo);
		
		//아래insert에서 사용한 sysdate값 msg(DTO)로 반환받음.
		chatService.insertMessage(msg);
		//-------------------------------------------------
				
		//---------- Date "09:30 오후" 이런 형식으로 변경  ---------	
		//msg(DTO)의 날짜 Date타입 날짜와 String타입 날짜 둘다 있음.
		//바뀐 날짜 String타입으로 저장.
		SimpleDateFormat time = new SimpleDateFormat("hh:mm a");		
		String presentTime=time.format(msg.getChatDate());
		msg.setStringChatDate(presentTime);		
		logger.info("메시지 시간:"+presentTime);
		logger.info("[TEST]msg:"+msg.toString());
		//-------------------------------------------------
		
		//---------- 채팅방 list(sub메시지 창) 최신순 으로 나열해주기 ---
		// 방에서 메시지가 오갈때마다  방에 최신날짜 저장.
		chatService.updateChatFinalDate(msg);		
		//-------------------------------------------------

		//---------- 수신자가 누구인지 select하기 ------------------
		//송신자의 방번호에 대한 정보(어떤 id들이 있는지) 검색
		Chat Ids = chatService.selectChatRoomIds(roomNo);		
		logger.info("Ids:"+Ids);
		
		String counterpartId =null;
		String counterpartSort =null;
		
		//수신자id,sort얻어오기
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
		//-------------------------------------------------
		
		
		//---------- 송신자의 메시지를 보내줘야할 웹소켓에게 보내주기 ------
		//웹소켓으로 접속된 사람들만 반복
		//헷갈리지말자! sess는 모든 웹소켓을 한번씩 불러오는 거임.
		for(WebSocketSession sess: userSessions.values()) {
			// 웹소켓sess의 id가 송신자이거나, 수신자일 때 동작
			if(getLoginInfo(sess).getId().equals(senderId) || getLoginInfo(sess).getId().equals(counterpartId)) {
				
				logger.info("<//////////// 단순표시 ////////////>");
				
				//---------- sess 정보(송신자or수신자) 가져오기 ------------------
				User sessInfo = new User();
				sessInfo.setId(getLoginInfo(sess).getId());
				sessInfo.setSort(getLoginInfo(sess).getSort());
				logger.info("현재 sess id:"+sessInfo.getId());
				logger.info("현재 sess sort:"+sessInfo.getSort());
				//-------------------------------------------------------
				
				//---------- (송신자or수신자)id로 방검색  ------------------------
				//refreshChatRoomList이름은 jsp도 고쳐야해서 그냥 둔거임. 단순 방list임.
				//채팅방 list(sub메시지 창)
				List<Chat> refreshChatRoomList = chatService.selectRooms(sessInfo);
				//--------------------------------------------------------
				
				//---------- (송신자or수신자)의 방번호 얻기 ------------------------
				//default값을 null이 아닌 -1로 만들어주기 위해서
				int chatRoomNo=0;
				if(getHttpSession(sess).get("chatRoomNo")==null) {
					chatRoomNo = -1;
					
				}else { 
					//방번호 얻기
					chatRoomNo =  (int)getHttpSession(sess).get("chatRoomNo");
				}
				//---------------------------------------------------------
				
				//---------- 채팅방 list(sub메시지 창)에 상대방 이름을 띄워 주기 위해서 추가 ------
				//채팅방 list에 TheOtherParty(상대방 id) 저장.
				for(int i=0; i<refreshChatRoomList.size(); i++) {
					if(refreshChatRoomList.get(i).getBuyerId() != null && !refreshChatRoomList.get(i).getBuyerId().equals(sessInfo.getId())) {
						refreshChatRoomList.get(i).setTheOtherParty(refreshChatRoomList.get(i).getBuyerId());
					}else if(refreshChatRoomList.get(i).getSellerId() != null && !refreshChatRoomList.get(i).getSellerId().equals(sessInfo.getId())) {
						refreshChatRoomList.get(i).setTheOtherParty(refreshChatRoomList.get(i).getSellerId());
					}else if(refreshChatRoomList.get(i).getBigdomId() != null && !refreshChatRoomList.get(i).getBigdomId().equals(sessInfo.getId())) {
						refreshChatRoomList.get(i).setTheOtherParty(refreshChatRoomList.get(i).getBigdomId());
					}
				}
				logger.info("refreshChatRoomList:"+refreshChatRoomList);
				//---------------------------------------------------------
				
				//---------- map에 채팅방 list 추가 ----------------------------
				//map형태로 보내주기 위해 map생성
				Map map = new HashMap<>();
				map.put("refreshChatRoomList", refreshChatRoomList);
				//---------------------------------------------------------
				
				//---------- 안읽은 메시지 개수 표시하기 위해 추가 ----------------------
				//설명: 메시지 송신이 발생하면, 접속중인 모든 웹소켓은  현재id,방no의 Date가 현재시간으로 바뀜.
				//MessageChk(현재id,방no,Date)이용.
				
				//EX1) 
				//    현재시각 09시 45분임.
				//    buyer01, 1번방, 08시30분  (현재 비접속상태)
				//    seller01, 1번방, 07시 20분 (현재 비접속상태)
				//    bigdom01, 2번방, 06시 00분 (현재 접속 상태) 06시00분에 접속했었음.
				//    06시 00분에 접속했을 때 MessageChk에 06시 00분이 저장돼 있는 것은 ChattingController에 있음.
				//
				//    위 상황에서 현재 시간 09시 45분에 2번방에서 bigdom01가 메시지를 보낸다면
				//    (현재 접속 상태)인 웹소켓만 현재시간으로 변경
				//    buyer01, 1번방, 08시30분
				//    seller01, 1번방, 07시 20분 
				//	  bigdom01, 2번방, 09시 45분 (현재 접속 상태)
				//
				//EX2) 
				//    현재시각 09시 45분임.
				//    buyer01, 1번방, 08시30분  (현재 접속 상태) 08시30분에 접속했었음.
				//    seller01, 1번방, 07시 20분 (현재 비접속상태)
				//    bigdom01, 2번방, 06시 00분 (현재 접속 상태) 06시00분에 접속했었음.
				//
				//    위 상황에서 현재 시간 09시 45분에 1번방에서 buyer01가 메시지를 보낸다면
				//    (현재 접속 상태)인 웹소켓만 현재시간으로 변경
				//    buyer01, 1번방,  09시 45분 (현재 접속 상태)
				//    seller01, 1번방, 07시 20분 
				//	  bigdom01, 2번방, 09시 45분 (현재 접속 상태)
				
				
				//---------- messageChk의 날짜가 실시간으로 수정되는 부분 --------------
				
				MessageChk messageChk = new MessageChk();
				//(송신자or수신자)id, (송신자or수신자)방no, 현재시간을 저장하는 DTO
				messageChk = chatService.setDtoMessageChk(sessInfo.getId(),chatRoomNo,new Date());
				logger.info("messageChk확인:"+messageChk);
				
				//MessageChk테이블에 이미(id,방no)있는지 없는지 확인
				boolean existenceStatusOfChatId = chatService.getExistenceStatusOfChatId(messageChk);
				
				//MessageChk에 (id,방no)가 이미 없다면 새롭게 넣어주고,
				//(id,방no)가 이미 있다면  수정해준다.
				if(messageChk.getChatRoomNo()!=-1) {
					if(existenceStatusOfChatId) {//(id,방no)없으면
						logger.info("MessageChk에 이미 Id가 존재하지 않음");
						chatService.insertMessageChk(messageChk);
					}else {//(id,방no)있으면
						logger.info("MessageChk에 이미 Id가 존재함");
						logger.info("messageChk확인:"+messageChk);
						chatService.updateMessageChk(messageChk);
					}
				}
				//---------------------------------------------------------
				
				//---------- 안읽은 메시지 개수 읽어오는 부분 --------------	-----------		
				//(송신자or수신자)id로 MessageChk 리스트 얻기
				List<MessageChk> finalDateListById = chatService.getFinalDateListById(sessInfo.getId());
				logger.info("finalDateListById:"+finalDateListById);
				
				//finalDateListById크기만큼 반복해서 읽지 않은 메시지 개수 가져오기
				List<MessageChk> messageChkResult = new ArrayList<>();
				
				for(int i=0; i<finalDateListById.size(); i++) {
					MessageChk tempMessageChk = chatService.getMessageNoReadNum(finalDateListById.get(i));
					messageChkResult.add(tempMessageChk);
				}
				logger.info("messageChkResult:"+messageChkResult);
				//---------------------------------------------------------
				
				//---------- map에 각 방마다 안읽은 메시지 개수list 추가 ---------------
				map.put("messageChkResult", messageChkResult);
				//---------------------------------------------------------
							
				//---------- map에 보낼 메시지 추가 ------------------------------
				map.put("msg", msg);
				//---------------------------------------------------------
				
				//----------map=>json으로 변경------------------------
				//Gson이용해서 map을 json형태로 보내주기
				Gson gson = new Gson();
				gson.toJson(map);		
				//-------------------------------------------------
				
				//---------- 메시지 전송 ------------------------------
				sess.sendMessage(new TextMessage(gson.toJson(map)));
				//-------------------------------------------------
			}
		}
		//-------------------------------------------------
		
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
		//---------- 웹소켓의 연결이 끊겼을 때 동작!!!!! ------------
		System.out.println("afterConnectionEstablished:"+session+" : "+ status);
		System.out.println(session.getId() + " 연결 종료됨");
		
		//---------- 현재 웹소켓을 sessions에서 제거 --------------
		sessions.remove(session);
		System.out.println("[TEST]sessions에서 session정보 지웠는지 확인:"+sessions);
		//------------------------------------------------
		
		//---------- 현재 웹소켓을 RoomSessions에서 제거 ----------
		RoomSessions.remove(session);
		System.out.println("[TEST]RoomSessions에서 session정보 지웠는지 확인:"+RoomSessions);
		//------------------------------------------------
		
		//---------- 현재 웹소켓을 userSessions에서 제거 ----------
		userSessions.remove(getLoginInfo(session).getId());
		System.out.println("[TEST]userSessions에서 session정보 지웠는지 확인:"+userSessions);
		//------------------------------------------------
		
	}
	
	
}
 