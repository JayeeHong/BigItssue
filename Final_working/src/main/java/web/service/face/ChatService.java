package web.service.face;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import web.dto.Chat;
import web.dto.ChatReport;
import web.dto.Message;
import web.dto.MessageChk;
import web.dto.User;

public interface ChatService {
	
	public boolean createRoomChk(Chat chat);
	
	public int createRoom(Chat chat);
	
	public int selectRoom(Chat chat);
	
	public Chat getChat(User user, HttpSession session);
	
	public List<Chat> selectRooms(User LoginInfo);
	
	public List<Message> selectMessage(int chatRoomNo);
	
	public Message selectSubMessage(int chatRoomNo);
	
	public void insertMessage(Message msg);
	
	public Chat selectChatRoomIds(int roomNo);
	
	
	//dto는 MessageChk사용.
	public MessageChk setDtoMessageChk(String chatId, int chatRoomNo, Date sysdate);
	
	//MessageChk테이블에 이미 id가 들어가 있지 않다면, 현재id,방no,들어간date를 MessageChk에 넣어주자. - 나중에 안읽은 메시지 표시하기 위해서
	public void insertMessageChk(MessageChk messageChk);
	
	//MessageChk테이블에 이미 id가 들어가 있다면, 현재id,방no,들어간date를 수정해주자.
	public void updateMessageChk(MessageChk messageChk);

	//MessageChk테이블에 이미 id가 들어가 있는지 없는지 확인
	public boolean getExistenceStatusOfChatId(MessageChk messageChk);
	
	//로그인한 id로 방마다 마지막으로 메시지 읽은 날짜가져오기
	public List<MessageChk> getFinalDateListById(String chatId);
	
	//finalDateListById크기만큼 반복해서 읽지 않은 메시직 개수 가져오기
	public MessageChk getMessageNoReadNum(MessageChk messageChk);
	
	//방만들때 messageChk DB에 id와 날짜2001/**/**을 넣어주자. 
	public void createMessageChk(Chat chat);
	
	// 방에서 메시지가 오갈때마다  방에 최신날짜 저장.
	public void updateChatFinalDate(Message msg);
	
	//메시지 번호에 대한 정보 가져오기.
	public Message getMessageBychatMessageNo(int chatMessageNo);
	
	//방번호와 현재날짜로 message리스트 조회. 신고한 번호 기준으로 아래로50
	public List<Message> getMessageBySysdateAndChatRoomNo50Down(Message msg);
	
	//방번호와 현재날짜로 message리스트 조회. 신고한 번호 기준으로 위로50
	public List<Message> getMessageBySysdateAndChatRoomNo50Up(Message msg);
	
	//ChatReport로 얻어오기
	public ChatReport getChatReport(Message msg,Message msg2,HttpSession session);
	
	//신고한 내용 DB에 저장하기
	public void insertChatReport(List<ChatReport> chatReportList);
	
	
	
	
}
