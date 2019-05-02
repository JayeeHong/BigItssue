package web.controller;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

@Controller
public class SubwayApi {
	



	@RequestMapping(value="/admin/seller/searchzone", method=RequestMethod.GET)
	public void searchZone() {
		
	}
	
	
	
	@RequestMapping(value="/admin/seller/searchzone", method=RequestMethod.POST)
	public String searchZone(String searchWord, Model model) throws Exception {
		System.out.println("전달은됨?"+searchWord);
	
		SubwayApi http = new SubwayApi();
		Map map = http.search(searchWord);
		
		model.addAttribute("zoneList", map);
		
		return "jsonView";
	}
	
	
	private Map search(String searchWord) throws Exception {
		
		
		
		String text = URLEncoder.encode(searchWord, "UTF-8");
		String url = "http://openapi.tago.go.kr/openapi/service/SubwayInfoService/getKwrdFndSubwaySttnList?serviceKey=FTsFabal6deoKxbke9kWGIb3kvMUFuKfJViCmlpItTmYPEDx1WeRTBx49otZympexcYXYzHV7c6obfhhawzocg%3D%3D&subwayStationName="+text;
		
		Node seoul = null;
		
		URL obj = new URL(url);
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		
		con.setRequestMethod("GET");
		con.setRequestProperty("User-Agent", "test");
		con.getResponseCode();
		
		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();
		
		while ((inputLine= in.readLine())!=null) {
			System.out.println(inputLine);
			response.append(inputLine);
		}
		in.close();
		
		
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
		
		FileOutputStream output = new FileOutputStream("./getServer");
		output.write(response.toString().getBytes());
		output.close();
		
		Document doc = dBuilder.parse("./getServer");
		doc.getDocumentElement().normalize();
		
		Element body = (Element) doc.getElementsByTagName("body").item(0);
		
		Element items; 
		items = (Element) doc.getElementsByTagName("items").item(0);
		
		Element item = null;
		
		
		Node cnt = doc.getElementsByTagName("totalCount").item(0);
		
		Map map = new HashMap();
		String subwayLine;
		for(int i=0; i<Integer.parseInt(cnt.getTextContent()); i++) {
			item = (Element) doc.getElementsByTagName("item").item(i);
			seoul = item.getElementsByTagName("subwayRouteName").item(0);
			System.out.println("호선 : "+seoul.getChildNodes().item(0).getNodeValue());
			subwayLine = seoul.getChildNodes().item(0).getNodeValue().replace("서울 ", "").replace("호선", "").replace("중앙선", "").replace("선", "").replace("철도", "").replace("라인", "");
			map.put(i, subwayLine);
		}
		
		
				
		System.out.println("몇개냐 : "+cnt.getTextContent());
		return map;
	}
	
	
	
}
