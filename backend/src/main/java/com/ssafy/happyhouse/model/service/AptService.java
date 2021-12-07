package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;

public interface AptService {

	List<SidoGugunCodeDto> getSido() throws Exception;
	List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception;
	List<HouseInfoDto> getDongInGugun(String gugun) throws Exception;
	List<HouseInfoDto> getAptInDong(String dong, String userId) throws Exception;
	List<HouseInfoDto> getSidoGugun(String sigungudongCode) throws Exception;
	void getBookmarkReg(String userId, String aptCode) throws Exception;
	List<HouseInfoDto> getBookmark(String userId) throws Exception;
	void getBookmarkDelete(String userId, String aptCode) throws Exception;
	List<HouseInfoDto> getAptDetail(String aptCode) throws Exception;
	
}
