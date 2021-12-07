package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.AptService;


@RestController
@RequestMapping("/map")
public class AptController {
	
	@Autowired
	private AptService aptService;
	
	@GetMapping("/sido")
	public ResponseEntity<List<SidoGugunCodeDto>> sido() throws Exception{
		return new ResponseEntity<List<SidoGugunCodeDto>>(aptService.getSido(), HttpStatus.OK);
	}
	
	@GetMapping("/gugun")
	public ResponseEntity<List<SidoGugunCodeDto>> gugun(@RequestParam("sido") String sido) throws Exception{
		return new ResponseEntity<List<SidoGugunCodeDto>>(aptService.getGugunInSido(sido), HttpStatus.OK);
	}
	
	@GetMapping("/dong")
	public ResponseEntity<List<HouseInfoDto>> dong(@RequestParam("gugun") String gugun) throws Exception{
		return new ResponseEntity<List<HouseInfoDto>>(aptService.getDongInGugun(gugun), HttpStatus.OK);
	}
	
	@GetMapping("/apt")
	public ResponseEntity<List<HouseInfoDto>> apt(@RequestParam("dong") String dong, @RequestParam("userId") String userId) throws Exception{
		return new ResponseEntity<List<HouseInfoDto>>(aptService.getAptInDong(dong, userId), HttpStatus.OK);
	}
	
	@GetMapping("/apt/detail")
	public ResponseEntity<List<HouseInfoDto>> aptdetail(@RequestParam("aptCode") String aptCode) throws Exception{
		return new ResponseEntity<List<HouseInfoDto>>(aptService.getAptDetail(aptCode), HttpStatus.OK);
	}
	
	@GetMapping("/sidogugun")
	public ResponseEntity<List<HouseInfoDto>> sidogugun(@RequestParam("sigungudongCode") String sigungudongCode) throws Exception{
		return new ResponseEntity<List<HouseInfoDto>>(aptService.getSidoGugun(sigungudongCode), HttpStatus.OK);
	}
	
	@PostMapping("/bookmark/{userId}/{aptCode}")
	public ResponseEntity<?> regbookmark(@PathVariable String userId,@PathVariable String aptCode) throws Exception{
		aptService.getBookmarkReg(userId, aptCode);
		return new ResponseEntity<Integer>(1, HttpStatus.OK);
	}
	
	@GetMapping("/bookmark/{userId}")
	public ResponseEntity<?> getbookmark(@PathVariable String userId) throws Exception{
		return new ResponseEntity<List<HouseInfoDto>>(aptService.getBookmark(userId), HttpStatus.OK);
	}
	
	@DeleteMapping("/bookmark/{userId}/{aptCode}")
	public ResponseEntity<?> deletebookmark(@PathVariable String userId,@PathVariable String aptCode) throws Exception{
		aptService.getBookmarkDelete(userId, aptCode);
		return new ResponseEntity<Integer>(1, HttpStatus.OK);
	}
}
