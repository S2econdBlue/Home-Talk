package com.ssafy.vue.service;

import java.util.List;
import java.util.Map;

import com.ssafy.vue.dto.AroundbusinessareaDto;
import com.ssafy.vue.dto.DongcodeDto;
import com.ssafy.vue.dto.GuguncodeDto;
import com.ssafy.vue.dto.HousedealDto;
import com.ssafy.vue.dto.HouseinfoDto;
import com.ssafy.vue.dto.SidocodeDto;


public interface BuildingService {
	List<DongcodeDto> select(String gu) throws Exception;
	List<GuguncodeDto> selectGu(String si) throws Exception;
	List<SidocodeDto> selectSi() throws Exception;
	List<AroundbusinessareaDto> around(String dong) throws Exception;
}
