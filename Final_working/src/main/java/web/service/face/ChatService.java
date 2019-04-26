package web.service.face;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import web.dto.Chat;
import web.dto.Message;
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

}
