package com.ssafy.happyhouse.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.NewsDto;

@RestController
@RequestMapping("/crawling")
public class CrawlingController {
	
	private static final Logger logger = LoggerFactory.getLogger(CrawlingController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	
	@GetMapping
	public ResponseEntity<List<NewsDto>> crawling() throws Exception{

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
		Date currentTime = new Date();
		
		String dTime = formatter.format(currentTime);
		String e_date = dTime;
		
		currentTime.setDate(currentTime.getDate()-1);
		String s_date = formatter.format(currentTime);
		
		String query="부동산";
		String s_from = s_date.replace(".", "");
		String e_to = e_date.replace(".", "");
		int page=1;
		List<NewsDto> newsList = new ArrayList<>();
		
		List<String> newsTitle = new ArrayList<>();
		List<String> newsUrl = new ArrayList<>();
		List<String> newsContent = new ArrayList<>();
		List<String> imgUrl = new ArrayList<>();
		
		int no = 1;
		while(page < 20) {
//			https://search.naver.com/search.naver?where=news&query=%EC%84%B1%EB%B6%81%EA%B5%AC&sm=tab_opt&sort=0&photo=0&field=0&pd=3&ds=2021.11.21&de=2021.11.24&docid=&related=0&mynews=0&office_type=0&office_section_code=0&news_office_checked=&nso=so%3Ar%2Cp%3Afrom20211121to20211124&is_sug_officeid=0
			String address = "https://search.naver.com/search.naver?where=news&query=" + query+ "&sort=0&ds="+s_date
					+ "&de=" + e_date + "&nso=so%3Ar%2Cp%3Afrom" + s_from + "to" + e_to + "%2Ca%3A&start="
					+ Integer.toString(page);
			
			Document rawData = Jsoup.connect(address).timeout(5000).get();
//			System.out.println(address);

			// 기사 url, 제목
			Elements blogOption = rawData.getElementsByAttributeValue("class", "news_tit");	// 찾으려는 값
			
			// 기사 내용
			Elements contents = rawData.getElementsByAttributeValue("class", "api_txt_lines dsc_txt_wrap");
			
			// 기사 사진
			Elements imgs = rawData.getElementsByAttributeValue("class", "thumb api_get");
			
			String realURL = "";
			String realTITLE = "";
			
			// for문 3개를 돌면서 기사 제목, url, 내용, 이미지 url을 각각 리스트에 저장
			for(Element option : blogOption) {
				realURL = option.select("a").attr("href");
				realTITLE = option.select("a").attr("title");
//				System.out.println(realURL);
//				System.out.println(realTITLE);
				
				newsUrl.add(realURL);
				newsTitle.add(realTITLE);
			}
			
			for(Element option : contents) {
				String realContent = option.select("a").text();
//				System.out.println(realContent);
				newsContent.add(realContent);
			}
			
			for(Element option : imgs) {
				String src = option.select("img").attr("src");
//				System.out.println(src);
				imgUrl.add(src);
			}
			page += 10;
			
		}
		
		// 전체 20개 저장했기 때문에 각 리스트에서 하나씩 뽑아 dto에 저장
		for(int i=0; i<20; ++i) {
			NewsDto newsDto = new NewsDto();
			newsDto.setNewsno(i+1);
			newsDto.setUrl(newsUrl.get(i));
			newsDto.setTitle(newsTitle.get(i));
			newsDto.setContent(newsContent.get(i));
			newsDto.setImgURL(imgUrl.get(i));
			newsList.add(newsDto);
		}
		
		
		return new ResponseEntity<List<NewsDto>>(newsList, HttpStatus.OK);
//		model.addAttribute("urls", al1);
//		model.addAttribute("titles", al2);
		
//		System.out.println(al2.size());
	}
	
}
