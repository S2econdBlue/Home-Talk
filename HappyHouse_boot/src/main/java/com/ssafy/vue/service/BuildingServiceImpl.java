package com.ssafy.vue.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.vue.dto.AroundbusinessareaDto;
import com.ssafy.vue.dto.DongcodeDto;
import com.ssafy.vue.dto.GuguncodeDto;
import com.ssafy.vue.dto.HouseinfoDto;
import com.ssafy.vue.dto.SidocodeDto;
import com.ssafy.vue.mapper.BuildingMapper;


@Service
public class BuildingServiceImpl implements BuildingService {
	
	@Autowired
	private BuildingMapper mapper;
	
	@Override
	public List<SidocodeDto> selectSi() throws Exception {
		return mapper.selectSi();
	}

	@Override
	public List<GuguncodeDto> selectGu(String si) throws Exception {
		return mapper.selectGu(si);
	}
	
	@Override
	public List<AroundbusinessareaDto> around(String dong) throws Exception {
		return mapper.around(dong);
	}

	@Override
	public List<DongcodeDto> selectDong(String gu) throws Exception {
		return mapper.selectDong(gu);
	}

	@Override
	public List<HouseinfoDto> selectApt(String code) throws Exception {
		return mapper.selectApt(code);
	}
}
