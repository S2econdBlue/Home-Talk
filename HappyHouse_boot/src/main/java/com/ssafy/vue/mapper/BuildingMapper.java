package com.ssafy.vue.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.vue.dto.AroundbusinessareaDto;
import com.ssafy.vue.dto.DongcodeDto;
import com.ssafy.vue.dto.GuguncodeDto;
import com.ssafy.vue.dto.HouseinfoDto;
import com.ssafy.vue.dto.SidocodeDto;


@Mapper
public interface BuildingMapper {
	List<DongcodeDto> selectDong(String gu) throws SQLException;
	List<GuguncodeDto> selectGu(String si) throws SQLException;
	List<SidocodeDto> selectSi() throws SQLException;
	List<AroundbusinessareaDto> around(String dong) throws SQLException;
	List<HouseinfoDto> selectApt(String code) throws SQLException;
}