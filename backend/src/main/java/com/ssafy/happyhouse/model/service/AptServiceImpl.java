package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.mapper.AptMapper;

@Service
public class AptServiceImpl implements AptService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return sqlSession.getMapper(AptMapper.class).getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return sqlSession.getMapper(AptMapper.class).getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return sqlSession.getMapper(AptMapper.class).getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong, String userId) throws Exception {
		return sqlSession.getMapper(AptMapper.class).getAptInDong(dong, userId);
	}

	@Override
	public List<HouseInfoDto> getSidoGugun(String sigungudongCode) throws Exception {
		return sqlSession.getMapper(AptMapper.class).getSidoGugun(sigungudongCode);
	}

	@Override
	public void getBookmarkReg(String userId, String aptCode) throws Exception {
		sqlSession.getMapper(AptMapper.class).getBookmarkReg(userId, aptCode);
		
	}

	@Override
	public List<HouseInfoDto> getBookmark(String userId) throws Exception {
		return sqlSession.getMapper(AptMapper.class).getBookmark(userId);
	}

	@Override
	public void getBookmarkDelete(String userId, String aptCode) throws Exception {
		sqlSession.getMapper(AptMapper.class).getBookmarkDelete(userId, aptCode);
		
	}

	@Override
	public List<HouseInfoDto> getAptDetail(String aptCode) throws Exception {
		return sqlSession.getMapper(AptMapper.class).getAptDetail(aptCode);
	}
}
