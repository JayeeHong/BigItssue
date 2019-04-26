package web.dao.face;


import java.util.Date;
import java.util.List;

import web.dto.Chat;
import web.dto.Message;
import web.dto.User;

public interface ChatDao {
	
	public int selectCntChatByIds(Chat chat); 
	
	public void insertRoom(Chat chat);
	
	public int selectRoom(Chat chat);
	
	public List<Chat> selectRooms(User LoginInfo);
	
	public Chat selectChatRoomIds(int roomNo);
	
	public void insertMessage(Message msg);
	
	public List<Message> selectMessage(int chatRoomNo);
	
	public Message selectSubMessage(int chatRoomNo);
	
		
}
