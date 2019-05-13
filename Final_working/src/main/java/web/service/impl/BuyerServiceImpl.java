package web.service.impl;

import java.security.MessageDigest;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import web.dao.face.BuyerDao;
import web.dto.BookListInfo;
import web.dto.BuyerInfo;
import web.dto.Notice;
import web.dto.MainBanner;
import web.dto.Reservation;
import web.dto.SellerLoc;
import web.dto.User;
import web.service.face.BuyerService;
import web.util.MyBookingPaging;
import web.util.Paging;
import web.util.SellerLocPaging;

@Service
public class BuyerServiceImpl implements BuyerService {
	@Autowired BuyerDao buyerDao;
	
	@Override
	public boolean haveId(BuyerInfo bi) {
		int usingId = 0;
		
		usingId=buyerDao.usingid(bi);
		
		if(usingId==1) {
			return true;
		}
		return false;
	}

	@Override
	public void buyerJoin(BuyerInfo buyerInfo) {

		buyerDao.buyerJoin(buyerInfo);
		
	}

	@Override
	public boolean buyerLogin(BuyerInfo buyerInfo) {
		
		int login =  buyerDao.buyerLogin(buyerInfo);
		if(login == 1) {
			return true;
		}
		
		return false;
	}

	@Override
	public void mailSender(String email, String subject, String body) {


				// 네이버일 경우 smtp.naver.com 을 입력합니다. // Google일 경우 smtp.gmail.com 을 입력합니다. 
				String host = "smtp.gmail.com"; 
				final String username = "bigitssue4"; //네이버 아이디를 입력해주세요. @naver.com은 입력하지 마시구요. 
				final String password = "bigitssue4_final"; //네이버 이메일 비밀번호를 입력해주세요. 
				int port=465; //포트번호 
				
				
				// 메일 내용 
				String recipient = email; //받는 사람의 메일주소를 입력해주세요. 
				
				
				 
				Properties props = System.getProperties(); 
				
				// 정보를 담기 위한 객체 생성 
				// SMTP 서버 정보 설정 
				props.put("mail.smtp.host", host); 
				props.put("mail.smtp.port", port); 
				props.put("mail.smtp.auth", "true"); 
				props.put("mail.smtp.ssl.enable", "true"); 
				props.put("mail.smtp.ssl.trust", host); 
				
				//Session 생성 
				Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
					String un=username; String pw=password; 
					protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
						return new javax.mail.PasswordAuthentication(un, pw); } }); 
				session.setDebug(true); //for debug 
				
				Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
				try {
					mimeMessage.setFrom(new InternetAddress("eungone0205@naver.com"));
					mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));//수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음 
					
					mimeMessage.setSubject(subject); //제목셋팅 
					
					mimeMessage.setText(body); //내용셋팅 
					
					Transport.send(mimeMessage); 
					//javax.mail.Transport.send() 이용
				} catch (AddressException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} //발신자 셋팅 , 보내는 사람의 이메일주소를 한번 더 입력합니다. 
				//이때는 이메일 풀 주소를 다 작성해주세요. 

	
		
		
	}

	
	
	@Override
	public BuyerInfo buyerFindId(BuyerInfo buyerInfo) {
		
		return buyerDao.buyerFindId(buyerInfo);
	}

	@Override
	public int buyerCnt(BuyerInfo buyerInfo) {
		// TODO Auto-generated method stub
		return buyerDao.buyerCnt(buyerInfo);
	}

	@Override
	public BuyerInfo buyerFindInfo(BuyerInfo buyerInfo) {
		// TODO Auto-generated method stub
		return buyerDao.buyerFindInfo(buyerInfo);
	}

	@Override
	public int buyerFindCnt(BuyerInfo buyerInfo) {
		// TODO Auto-generated method stub
		return buyerDao.buyerFindCnt(buyerInfo);
	}

	
	//비밀번호 변경
	@Override
	public void pwUpdate(BuyerInfo buyerInfo) {
		buyerDao.pwUpdate(buyerInfo);
		
	}

	@Override
	public int eamilSerch(String email) {
		
		return buyerDao.eamilSerch(email);
	}
	
	//판매처 총 게시글 수 얻기
	@Override
	public int getTotalCountOfSellerLoc() {
		return buyerDao.selectCntOfSellerLoc();
	}

	@Override
	public List getPagingListOfSellerLoc(SellerLocPaging paging) {
		return buyerDao.selectPaginglistOfSellerLoc(paging);
	}
	
	//buyerId로 Buyer정보 검색(반환User)
	@Override
	public User getBuyerInfo(BuyerInfo buyerInfo) {
		return buyerDao.selectBuyerInfoByBuyerId(buyerInfo);
		
	}

	@Override
	public SellerLoc getSellerLoc(int sellerLoc) {
		return buyerDao.selectSellerLoc(sellerLoc);
	}

	@Override
	public BookListInfo getBookListInfo(int magazineNo) {
		return buyerDao.selectBookListInfo(magazineNo);
	}

	@Override
	public boolean confirmpw(BuyerInfo buyerInfo) {
		
		int login =  buyerDao.selectBuyerIdAndPw(buyerInfo);
		if(login == 1) {
			return true;
		}
		
		return false;
		
	}
  
	@Override
	public List<BookListInfo> getBookListInfoBySellerId(String sellerId) {
		return buyerDao.selectBookListInfoBySellerId(sellerId);
	}

	@Override
	public void booking(Reservation reservationInfo) {
		 buyerDao.insertResrvation(reservationInfo);
		 buyerDao.decreaseBookNumber(reservationInfo);
		
	}

	@Override
	public List<Reservation> getResrvaionList(Reservation reservationInfo) {
		return buyerDao.selectResrvation(reservationInfo);
	}

	@Override
	public int getResrvaionCnt(Reservation reservationInfo) {
		return buyerDao.selectResrvaionCnt(reservationInfo);
	}

	@Override
	public List<Reservation> getResrvaionListByBuyerId(String buyerId) {
		return buyerDao.selectResrvationByBuyerId(buyerId);
	}

	@Override
	public void setPickupDate(Reservation bookList) {
		buyerDao.updatePickupDate(bookList);	
	}

	@Override
	public List<SellerLoc> getZoneList() {
		return buyerDao.selectZoneList();
	}

	@Override
	public List<SellerLoc> getStationList() {
		return buyerDao.selectStationList();
	}

	@Override
	public BuyerInfo getBuyerInfoAtBuyermyinfo(BuyerInfo buyerInfo) {
		return buyerDao.selectBuyerInfoAtBuyermyinfo(buyerInfo);
	}

	@Override
	public void setBuyerPhone(BuyerInfo buyerInfo) {
		buyerDao.updateBuyerPhone(buyerInfo);
	}

	@Override
	public void setBuyerEmail(BuyerInfo buyerInfo) {
		buyerDao.updateBuyerEmail(buyerInfo);
	}

  @Override
	public int getTotalCountOfSellerLocByZoneAndStation(Map<String, Object> map) {
		return buyerDao.selectTotalCountOfSellerLocByZoneAndStation(map);
	}

	@Override
	public List<SellerLoc> getPagingListOfSellerLocByZoneAndStation(SellerLocPaging paging) {
		return buyerDao.selectPagingListOfSellerLocByZoneAndStation(paging);
	}

	@Override
	public int getTotalCountOfMyBooking(String buyerId) {
		return buyerDao.selectTotalCountOfMyBooking(buyerId);
	}

	@Override
	public List<Reservation> getPagingListOfMyReservation(MyBookingPaging paging) {
		return buyerDao.selectPagingListOfMyReservation(paging);
	}

	@Override
	public void setStatusOfReservation(int magazineNo) {
		buyerDao.updateStatusOfReservation(magazineNo);
	}

	@Override
	public Reservation getReservaionByMagazineNo(int magazineNo) {
		return buyerDao.selectReservationByMagazineNo(magazineNo);
	}

	@Override
	public void increaseCirculation(Reservation reservationInfo) {
		buyerDao.increaseCirculation(reservationInfo);	
	}

	@Override
	public List<MainBanner> getBannerList() {
		return buyerDao.selectBanner();
	}
  
	@Override
	public int getNoticeCnt() {
		
		return buyerDao.getNoticeCnt();
	}

	@Override
	public List<Notice> getNoticeList(Paging paging) {
		
		return buyerDao.getNoticeList(paging);
	}

	@Override
	public Notice getNoticeView(int noticeNo) {
		return buyerDao.getNoticeView(noticeNo);
	}

	@Override
	public void setBuyerInfoAtMypage(BuyerInfo buyerInfo) {
		buyerDao.updateBuyerInfoAtMypage(buyerInfo);
	}

  @Override
	public String shaPw(String buyerPw) {
		String pw = buyerPw;
		
		 try{
	            MessageDigest md = MessageDigest.getInstance("SHA-256");
	            md.update(pw.getBytes());
	            byte byteData[] = md.digest();

	            StringBuffer sb = new StringBuffer();
	            for (int i = 0; i < byteData.length; i++) {
	                sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	            }

	            StringBuffer hexString = new StringBuffer();
	            for (int i=0;i<byteData.length;i++) {
	                String hex=Integer.toHexString(0xff & byteData[i]);
	                if(hex.length()==1){
	                    hexString.append('0');
	                }
	                hexString.append(hex);
	            }

	           return hexString.toString();
	        }catch(Exception e){
	            e.printStackTrace();
	            throw new RuntimeException();
	        }
		

	}
  

}

