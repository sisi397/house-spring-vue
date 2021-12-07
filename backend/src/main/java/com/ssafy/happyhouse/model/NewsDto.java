package com.ssafy.happyhouse.model;

public class NewsDto {

	int newsno;
	String url;
	String title;
	String content;
	String imgURL;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	public int getNewsno() {
		return newsno;
	}
	public void setNewsno(int newsno) {
		this.newsno = newsno;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	
}
