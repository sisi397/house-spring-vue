package com.ssafy.happyhouse.model;

public class MemberDto {

	private String userId;
	private String userPwd;
	private String userName;
	private String userEmail;
	private String userPhoneNumber;

	public MemberDto() {}
	
	public MemberDto(String userId, String userPwd, String userName, String userEmail,  String userphoneNumber) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.userEmail = userEmail;
		this.userPhoneNumber = userphoneNumber;
	}
	
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}
	public void setUserPhoneNumber(String phoneNumber) {
		this.userPhoneNumber = phoneNumber;
	}

	@Override
	public String toString() {
		return "MemberDto [userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName + ", userEmail="
				+ userEmail + ", phoneNumber=" + userPhoneNumber + "]";
	}

	
	
	
}
