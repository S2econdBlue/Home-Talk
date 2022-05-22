package com.ssafy.vue.service;

import java.util.List;

import com.ssafy.vue.dto.AroundbusinessareaDto;
import com.ssafy.vue.dto.DongcodeDto;
import com.ssafy.vue.dto.GuguncodeDto;
import com.ssafy.vue.dto.HouseinfoDto;
import com.ssafy.vue.dto.SidocodeDto;
import com.ssafy.vue.dto.SubwayDto;


public interface BuildingService {
	List<DongcodeDto> selectDong(String gu) throws Exception;
	List<GuguncodeDto> selectGu(String si) throws Exception;
	List<SidocodeDto> selectSi() throws Exception;
	List<AroundbusinessareaDto> around(String dong) throws Exception;
	List<HouseinfoDto> selectApt(String code) throws Exception;
	List<SubwayDto> selectSubway() throws Exception;
}
