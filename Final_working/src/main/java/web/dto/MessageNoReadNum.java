package web.dto;

public class MessageNoReadNum {
	
	private int MessageNoReadNumNo;
	private int chatRoomNo;
	private String chatId;
	private int MessageNoReadNum;
	
	@Override
	public String toString() {
		return "MessageNoReadNum [MessageNoReadNumNo=" + MessageNoReadNumNo + ", chatRoomNo=" + chatRoomNo + ", chatId="
				+ chatId + ", MessageNoReadNum=" + MessageNoReadNum + "]";
	}
	public int getMessageNoReadNumNo() {
		return MessageNoReadNumNo;
	}
	public void setMessageNoReadNumNo(int messageNoReadNumNo) {
		MessageNoReadNumNo = messageNoReadNumNo;
	}
	public int getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	public String getChatId() {
		return chatId;
	}
	public void setChatId(String chatId) {
		this.chatId = chatId;
	}
	public int getMessageNoReadNum() {
		return MessageNoReadNum;
	}
	public void setMessageNoReadNum(int messageNoReadNum) {
		MessageNoReadNum = messageNoReadNum;
	}
	
	

}
