package web.dto;

import java.util.Date;

public class MessageChk {
	
	private int chatMessageChkNo;
	private int chatRoomNo;
	private String chatId;
	private Date chatFinalDate;
	private int messageNoReadNum;
	
	

	
	@Override
	public String toString() {
		return "MessageChk [chatMessageChkNo=" + chatMessageChkNo + ", chatRoomNo=" + chatRoomNo + ", chatId=" + chatId
				+ ", chatFinalDate=" + chatFinalDate + ", messageNoReadNum=" + messageNoReadNum + "]";
	}
	public int getChatMessageChkNo() {
		return chatMessageChkNo;
	}
	public void setChatMessageChkNo(int chatMessageChkNo) {
		this.chatMessageChkNo = chatMessageChkNo;
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
	public Date getChatFinalDate() {
		return chatFinalDate;
	}
	public void setChatFinalDate(Date chatFinalDate) {
		this.chatFinalDate = chatFinalDate;
	}
	public int getMessageNoReadNum() {
		return messageNoReadNum;
	}
	public void setMessageNoReadNum(int messageNoReadNum) {
		this.messageNoReadNum = messageNoReadNum;
	}


	
	
	
	
}
