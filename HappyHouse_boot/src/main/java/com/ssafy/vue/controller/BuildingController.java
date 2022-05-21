package com.ssafy.vue.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.vue.dto.AroundbusinessareaDto;
import com.ssafy.vue.dto.DongcodeDto;
import com.ssafy.vue.dto.GuguncodeDto;
import com.ssafy.vue.dto.HouseinfoDto;
import com.ssafy.vue.dto.SidocodeDto;
import com.ssafy.vue.service.BuildingService;

import io.swagger.annotations.ApiOperation;


@RestController
@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RequestMapping("/Building")
public class BuildingController {
	
	@Autowired
	private BuildingService service;
	
	@ApiOperation(value = "시,도 정보를 조회한다.", response = List.class)
	@GetMapping("/Si")
	public @ResponseBody List<SidocodeDto> Si() throws Exception {
		List<SidocodeDto> list =  service.selectSi();
		return list;
	}
	
	@GetMapping("/Gu")
	@ApiOperation(value = "시,도 정보에 맞는 구군 정보를 조회한다.", response = List.class)
	public @ResponseBody List<GuguncodeDto> Gu(@RequestParam("sido") String sido) throws Exception {
		List<GuguncodeDto> list =  service.selectGu(sido);
		return list;
	}
	@GetMapping("/Dong")
	@ApiOperation(value = "시,도,구,군 정보에 맞는 동 정보를 조회한다.", response = List.class)
	public @ResponseBody List<DongcodeDto> Dong(@RequestParam("gugun") String gu) throws Exception {
		List<DongcodeDto> list =  service.selectDong(gu);
		return list;
	}
	
	@GetMapping("/around")
	@ApiOperation(value = "동코드에 맞는 주변상권 정보를 조회한다", response = List.class)
	public @ResponseBody List<AroundbusinessareaDto> around(@RequestParam("dong") String dongcode) throws Exception{
		List<AroundbusinessareaDto> list = service.around(dongcode);
		return list;
	}
	
	@GetMapping("/House")
	@ApiOperation(value = "동코드에 맞는 아파트 거래 정보를 조회한다", response = List.class)
	public @ResponseBody List<HouseinfoDto> Apt(@RequestParam("dong") String apt) throws Exception {
		List<HouseinfoDto> list =  service.selectApt(apt);
		return list;
	}
}
