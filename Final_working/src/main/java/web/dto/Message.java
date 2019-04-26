package web.dto;

import java.util.Date;

public class Message { // 채팅내용
	
	private int chatMessageNo; // 채팅내용번호
	private String chatSender; // 보낸사람
	private String chatContent; // 채팅내용
	private Date chatDate; // 채팅날짜
	private int chatRoomNo; // 채팅방번호
	private String stringChatDate;//String타입의 채팅날짜 - 추가이유 : date타입으로는 이쁘게 변환이 안됨.
									//DB에 Date타입으로 저장되어 있는것을 채팅창에 보여줄때 이곳에 String으로 변환된것을 저장하여 사용중.
	
	public int getChatMessageNo() {
		return chatMessageNo;
	}
	public void setChatMessageNo(int chatMessageNo) {
		this.chatMessageNo = chatMessageNo;
	}
	public String getChatSender() {
		return chatSender;
	}
	public void setChatSender(String chatSender) {
		this.chatSender = chatSender;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public Date getChatDate() {
		return chatDate;
	}
	public void setChatDate(Date chatDate) {
		this.chatDate = chatDate;
	}
	public int getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	public String getStringChatDate() {
		return stringChatDate;
	}
	public void setStringChatDate(String stringChatDate) {
		this.stringChatDate = stringChatDate;
	}
	@Override
	public String toString() {
		return "Message [chatMessageNo=" + chatMessageNo + ", chatSender=" + chatSender + ", chatContent=" + chatContent
				+ ", chatDate=" + chatDate + ", chatRoomNo=" + chatRoomNo + ", stringChatDate=" + stringChatDate + "]";
	}
	
	
}
