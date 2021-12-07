package com.ssafy.happyhouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

// index page 처리용 controller
@Controller
public class MainController {

//	@RequestMapping(value = "/", method = RequestMethod.GET)
	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	@GetMapping("/member/signup")
	public String registPage() {
		return "signup";
	}
	
	@GetMapping("/member/userinfo")
	public String userinfoPage() {
		return "userinfo";
	}
}
