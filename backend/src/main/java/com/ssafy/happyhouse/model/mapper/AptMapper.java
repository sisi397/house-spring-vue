package com.ssafy.happyhouse.model.mapper;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;

public interface AptMapper {
	
	List<SidoGugunCodeDto> getSido() throws SQLException;
	List<SidoGugunCodeDto> getGugunInSido(String sido) throws SQLException;
	List<HouseInfoDto> getDongInGugun(String gugun) throws SQLException;
	List<HouseInfoDto> getAptInDong(String dong, String userId) throws SQLException;
	List<HouseInfoDto> getSidoGugun(String sigungudongCode) throws SQLException;
	void getBookmarkReg(String userId, String aptCode) throws SQLException;
	List<HouseInfoDto> getBookmark(String userId) throws SQLException;
	void getBookmarkDelete(String userId, String aptCode) throws SQLException;
	List<HouseInfoDto> getAptDetail(String aptCode) throws SQLException;
}
